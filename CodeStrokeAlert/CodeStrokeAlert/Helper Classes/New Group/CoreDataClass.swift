//
//  CoreDataClass.swift
//  CrownID
//
//  Created by Jayesh on 7/31/17.
//  Copyright © 2017 Samanvay. All rights reserved.
//

import UIKit
import CoreData
import SDWebImage

protocol TypeingDelegate {
    func isTypeing(typeingText: String)
}

class CoreDataClass: NSObject {
    
    @objc static var shared = CoreDataClass()
    var objTypeingDelegate:TypeingDelegate?
    
    // MARK: - Core Data stack
    private let persistentContainer = NSPersistentContainer(name: "CodeStrokeAlert")
    
    // MARK: - Core Data Saving support
    @objc func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Other
    @objc func setupCoreDate() {
        
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.applicationSupportDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
            print("\(path)")
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    // MARK: - Fetch Results Controller
    @objc func fetchedResultsControllerForMessages(delegate:Any, opponentID: String) -> NSFetchedResultsController<Messages> {
        
        // Entity Init
        let objEntity = NSEntityDescription.entity(forEntityName: "Messages", in: self.persistentContainer.viewContext)
        
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<Messages> = Messages.fetchRequest()
        
        //Predicate
        fetchRequest.predicate = NSPredicate(format: "groupID == %@", opponentID)
        
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timeStamp", ascending: true)]
        
        // Propartiy Set
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.entity =  objEntity
        
        // Create Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentContainer.viewContext, sectionNameKeyPath: "sectionIdentifier", cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = delegate as? NSFetchedResultsControllerDelegate
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("An error occurred")
        }
        
        return fetchedResultsController 
    }
    
    @objc func fetchedResultsControllerForRecentChat(delegate:Any, opponentID: String) -> NSFetchedResultsController<RecentChat> {
        
        // Entity Init
        let objEntity = NSEntityDescription.entity(forEntityName: "RecentChat", in: self.persistentContainer.viewContext)
        
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<RecentChat> = RecentChat.fetchRequest()
        
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timeStamp", ascending: true)]
        
        // Propartiy Set
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.entity =  objEntity
        
        // Create Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentContainer.viewContext, sectionNameKeyPath:nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = delegate as? NSFetchedResultsControllerDelegate
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("An error occurred")
        }
        
        return fetchedResultsController
    }
    
    //image Cach Managment
    @objc func downLoadThum(array: [[String : AnyObject]], imgUrl: String) -> Void {
        //DownLoad image
        SDWebImageManager.shared().imageDownloader?.downloadImage(with: URL.init(string: imgUrl), options: SDWebImageDownloaderOptions.ignoreCachedResponse, progress: { (receivedSize, expectedSize, imageURL) in
            let percentComplete = (receivedSize * 360) / expectedSize
            print(percentComplete)
        }, completed: { (image, date, error, succes) in
            SDWebImageManager.shared().saveImage(toCache: image, for: URL.init(string: imgUrl))
            RecentChat.InsertMessag(recentChat: array, context: self.persistentContainer.viewContext)
            Messages.InsertImageMessag(messages: array, context: self.persistentContainer.viewContext)
        })
    }
    
    @objc func downloadThumForMessage(array: [[String : AnyObject]], imgUrl: String) -> Void {
        //DownLoad image
        SDWebImageManager.shared().imageDownloader?.downloadImage(with: URL.init(string: imgUrl), options: SDWebImageDownloaderOptions.ignoreCachedResponse, progress: { (receivedSize, expectedSize, imageURL) in
            let percentComplete = (receivedSize * 360) / expectedSize
            print(percentComplete)
        }, completed: { (image, date, error, succes) in
            SDWebImageManager.shared().saveImage(toCache: image, for: URL.init(string: imgUrl))
            Messages.InsertImageMessag(messages: array, context: self.persistentContainer.viewContext)
        })
    }
    
    // MARK: - Save Messages Controller
    @objc func insertIntoRecentChat(array: [[String : AnyObject]]) -> Void {
        let context:NSManagedObjectContext = NSManagedObjectContext.init(concurrencyType: .privateQueueConcurrencyType)
        context.parent = self.persistentContainer.viewContext
        context.performAndWait {
            let tempDis = array[0]
            if tempDis[MessageKey.messageType] as! String == IMAGE {
                self.downLoadThum(array: array, imgUrl: tempDis[MessageKey.imageThumbURL] as! String)
            }else if tempDis[MessageKey.messageType] as! String == VIDEO {
                RecentChat.InsertMessag(recentChat: array, context: self.persistentContainer.viewContext)
                Messages.InsertVideoMessag(messages: array, context: self.persistentContainer.viewContext)
            }else {
                if tempDis[MessageKey.messageType] as! String == TYPING {
                    RecentChat.InsertIsTyping(recentChat: array, context: self.persistentContainer.viewContext)
                    self.objTypeingDelegate?.isTypeing(typeingText: tempDis[MessageKey.typingText] as! String)
                }
                RecentChat.InsertMessag(recentChat: array, context: self.persistentContainer.viewContext)
                Messages.InsertMessag(messages: array, context: self.persistentContainer.viewContext)
            }
        }
    }
    
    @objc func insertIntoMessage(array: [[String : AnyObject]]) -> Void {
        let context:NSManagedObjectContext = NSManagedObjectContext.init(concurrencyType: .privateQueueConcurrencyType)
        context.parent = self.persistentContainer.viewContext
        context.performAndWait {
            let tempDis = array[0]
            if tempDis[MessageKey.messageType] as! String == IMAGE {
                self.downloadThumForMessage(array: array, imgUrl: tempDis[MessageKey.imageThumbURL] as! String)
            }else if tempDis[MessageKey.messageType] as! String == VIDEO {
                Messages.InsertVideoMessag(messages: array, context: self.persistentContainer.viewContext)
            }else {
                Messages.InsertMessag(messages: array, context: self.persistentContainer.viewContext)
            }
        }
    }
    
    @objc func insertIntoImageMessage(array: [[String : AnyObject]]) -> Void {
        let context:NSManagedObjectContext = NSManagedObjectContext.init(concurrencyType: .privateQueueConcurrencyType)
        context.parent = self.persistentContainer.viewContext
        context.performAndWait {
            Messages.InsertImageMessag(messages: array, context: self.persistentContainer.viewContext)
        }
    }
    
    @objc func insertIntoVideoMessage(array: [[String : AnyObject]]) -> Void {
        let context:NSManagedObjectContext = NSManagedObjectContext.init(concurrencyType: .privateQueueConcurrencyType)
        context.parent = self.persistentContainer.viewContext
        context.performAndWait {
            Messages.InsertVideoMessag(messages: array, context: self.persistentContainer.viewContext)
        }
    }
    
    @objc func UpdateMediaMessag(messageId:String, localUrl:String?, isDownload:Bool) -> Void {
        let context:NSManagedObjectContext = NSManagedObjectContext.init(concurrencyType: .privateQueueConcurrencyType)
        context.parent = self.persistentContainer.viewContext
        context.performAndWait {
            Messages.UpdateMediaMessag(messageUniqueId:messageId, localUrl: localUrl, isDownload: isDownload, context: self.persistentContainer.viewContext)
        }
    }
    
    // MARK: - other Funcation
    
    @objc func getLastMessageID(opponentID:String) -> Messages? {
        
        let request = NSFetchRequest<Messages>(entityName: NSStringFromClass(Messages.self))
        request.predicate = NSPredicate(format: "groupID == %@", opponentID)
        
        request.sortDescriptors = [NSSortDescriptor(key: "timeStamp", ascending: false)]
        request.fetchLimit = 1
        
        let results: [Messages] = try! self.persistentContainer.viewContext.fetch(request)
        if results.count > 0 {
            return results[0]
        }else {
            FirebaseClass.shared.getLast20Messages(opponent: opponentID)
        }
        return nil
    }
    
    
    func GetTotalUnreadCount() -> Int? {
        
        // Entity Init
        let objEntity = NSEntityDescription.entity(forEntityName: "RecentChat", in: self.persistentContainer.viewContext)
        
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<RecentChat> = RecentChat.fetchRequest()
        
        // Propartiy Set
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.entity =  objEntity
        
        var count: Int16 = 0
        var results : [RecentChat]
        do {
            results = try self.persistentContainer.viewContext.fetch(fetchRequest)
            if results.count > 0 {
                for objRecentChat in results {
                    count = count + objRecentChat.unreadCount;
                }
            }
        } catch {
        }
        return Int(count)
    }
}
