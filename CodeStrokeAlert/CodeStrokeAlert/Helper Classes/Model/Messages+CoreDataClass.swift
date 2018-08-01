//
//  Messages+CoreDataClass.swift
//  CodeStrokeAlert
//
//  Created by Apple on 29/07/18.
//  Copyright © 2018 Jayesh. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Messages)
public class Messages: NSManagedObject {
    @objc class func InsertMessag(messages:[[String:AnyObject]], context:NSManagedObjectContext) {
        for discMessages in messages {
            if Messages.isExitMessage(messageId: discMessages[MessageKey.messageId]! as! String, context: context) {
                let objMessages: Messages = Messages.MessageObject(messageId: discMessages[MessageKey.messageId]! as! String, context: context)
                objMessages.caseID              = discMessages[MessageKey.groupID] as? String
                objMessages.groupID             = discMessages[MessageKey.groupID] as? String
                objMessages.groupMember         = discMessages[MessageKey.memberID] as? String
                objMessages.imageURL            = ""
                objMessages.imageThumbURL       = ""
                objMessages.videoUrl            = ""
                objMessages.isGroup             = true
                objMessages.isUpload            = true
                objMessages.isRead              = discMessages[MessageKey.isRead] as! Bool
                objMessages.localPath           = ""
                objMessages.messageUniqueId     = ""
                objMessages.message             = discMessages[MessageKey.messageText] as? String
                objMessages.messageId           = discMessages[MessageKey.messageId] as? String
                objMessages.messageType         = discMessages[MessageKey.messageType] as? String
                objMessages.receiverId          = ""
                objMessages.senderId            = discMessages[MessageKey.senderID] as? String
                objMessages.senderName          = discMessages[MessageKey.senderName] as? String
                let date = Date(timeIntervalSince1970: (discMessages[MessageKey.timeStamp] as? TimeInterval)!/1000)
                objMessages.timeStamp           = date as Date as NSDate
                
                let dateStringSection           =  date.toString(format: DateFormatType.serverDate)
                let dateFormater : DateFormatter = DateFormatter()
                dateFormater.dateFormat         = DateFormatType.serverDate.stringFormat
                let newdate                     = dateFormater.date(from: dateStringSection)
                objMessages.sectionIdentifier   = "\(String(describing: newdate!.timeIntervalSince1970))"
                
                
            }else {
                let objMessages: Messages! = NSEntityDescription.insertNewObject(forEntityName: "Messages", into: context) as! Messages
                objMessages.caseID              = discMessages[MessageKey.groupID] as? String
                objMessages.groupID             = discMessages[MessageKey.groupID] as? String
                objMessages.groupMember         = discMessages[MessageKey.memberID] as? String
                objMessages.imageURL            = ""
                objMessages.imageThumbURL       = ""
                objMessages.videoUrl            = ""
                objMessages.isGroup             = true
                objMessages.isUpload            = true
                objMessages.isRead              = false
                objMessages.localPath           = ""
                objMessages.messageUniqueId     = ""
                objMessages.message             = discMessages[MessageKey.messageText] as? String
                objMessages.messageId           = discMessages[MessageKey.messageId] as? String
                objMessages.messageType         = discMessages[MessageKey.messageType] as? String
                objMessages.receiverId          = ""
                objMessages.senderId            = discMessages[MessageKey.senderID] as? String
                objMessages.senderName          = discMessages[MessageKey.senderName] as? String
                let date = Date(timeIntervalSince1970: (discMessages[MessageKey.timeStamp] as? TimeInterval)!/1000)
                objMessages.timeStamp           = date as Date as NSDate
                
                let dateStringSection           =  date.toString(format: DateFormatType.serverDate)
                let dateFormater : DateFormatter = DateFormatter()
                dateFormater.dateFormat         = DateFormatType.serverDate.stringFormat
                let newdate                     = dateFormater.date(from: dateStringSection)
                objMessages.sectionIdentifier   = "\(String(describing: newdate!.timeIntervalSince1970))"
            }
        }
        
        //Save context
        if context.hasChanges {
            try? context.save()
        }
    }
    
    @objc class func InsertImageMessag(messages:[[String:AnyObject]], context:NSManagedObjectContext) {
        for discMessages in messages {
            if Messages.isExitMessageUniqueId(messageUniqueId: discMessages[MessageKey.messageUniqueId]! as! String, context: context) {
                let objMessages: Messages = Messages.MessageUniqueIdObject(messageUniqueId: discMessages[MessageKey.messageUniqueId]! as! String, context: context)
                
                objMessages.imageURL            = discMessages[MessageKey.imageURL] as? String
                objMessages.imageThumbURL       = discMessages[MessageKey.imageThumbURL] as? String
                objMessages.isUpload            = true
                objMessages.isDownload          = discMessages[MessageKey.isDownload] as! Bool
                objMessages.messageUniqueId     = discMessages[MessageKey.messageUniqueId] as? String
                objMessages.message             = discMessages[MessageKey.messageText] as? String
                objMessages.messageId           = discMessages[MessageKey.messageId] as? String
                let date = Date(timeIntervalSince1970: (discMessages[MessageKey.timeStamp] as? TimeInterval)!/1000)
                objMessages.timeStamp           = date as Date as NSDate
                
                let dateStringSection =  date.toString(format: DateFormatType.serverDate)
                let dateFormater : DateFormatter = DateFormatter()
                dateFormater.dateFormat = DateFormatType.serverDate.stringFormat
                let newdate = dateFormater.date(from: dateStringSection)
                objMessages.sectionIdentifier = "\(String(describing: newdate!.timeIntervalSince1970))"
                
            }else {
                let objMessages: Messages! = NSEntityDescription.insertNewObject(forEntityName: "Messages", into: context) as! Messages
                objMessages.caseID    = discMessages[MessageKey.groupID] as? String
                objMessages.groupID   = discMessages[MessageKey.groupID] as? String
                objMessages.groupMember = discMessages[MessageKey.memberID] as? String
                objMessages.videoUrl  = ""
                objMessages.isGroup  = true
                objMessages.isUpload  = false
                objMessages.isDownload  = false
                objMessages.localPath  = discMessages[MessageKey.localPath] as? String
                objMessages.messageUniqueId  = discMessages[MessageKey.messageUniqueId] as? String
                objMessages.message  = discMessages[MessageKey.messageText] as? String
                objMessages.messageId  = ""
                objMessages.messageType  = discMessages[MessageKey.messageType] as? String
                objMessages.receiverId  = ""
                objMessages.senderId  = discMessages[MessageKey.senderID] as? String
                objMessages.senderName  = discMessages[MessageKey.senderName] as? String
                
                if (discMessages[MessageKey.messageId] != nil) && (discMessages[MessageKey.imageThumbURL] != nil) && (discMessages[MessageKey.imageURL] != nil) {
                    objMessages.messageId  = discMessages[MessageKey.messageId] as? String
                    objMessages.imageThumbURL  = discMessages[MessageKey.imageThumbURL] as? String
                    objMessages.imageURL  = discMessages[MessageKey.imageURL] as? String
                    objMessages.isUpload  = true
                }else {
                    objMessages.messageId  = ""
                    objMessages.imageThumbURL  = ""
                    objMessages.imageURL  = ""
                }
                
                let date = Date(timeIntervalSince1970: (discMessages[MessageKey.timeStamp] as? TimeInterval)!/1000)
                objMessages.timeStamp  = date as Date as NSDate
                
                let dateStringSection =  date.toString(format: DateFormatType.serverDate)
                let dateFormater : DateFormatter = DateFormatter()
                dateFormater.dateFormat = DateFormatType.serverDate.stringFormat
                let newdate = dateFormater.date(from: dateStringSection)
                objMessages.sectionIdentifier = "\(String(describing: newdate!.timeIntervalSince1970))"
            }
        }
        
        //Save context
        if context.hasChanges {
            try? context.save()
        }
    }
    
    @objc class func InsertVideoMessag(messages:[[String:AnyObject]], context:NSManagedObjectContext) {
        for discMessages in messages {
            if Messages.isExitMessageUniqueId(messageUniqueId: discMessages[MessageKey.messageUniqueId]! as! String, context: context) {
                let objMessages: Messages = Messages.MessageUniqueIdObject(messageUniqueId: discMessages[MessageKey.messageUniqueId]! as! String, context: context)
                
                objMessages.videoUrl  = discMessages[MessageKey.videoUrl] as? String
                objMessages.imageThumbURL  = discMessages[MessageKey.imageThumbURL] as? String
                objMessages.isUpload  = true
                objMessages.isDownload  = discMessages[MessageKey.isDownload] as! Bool
                objMessages.messageUniqueId  = discMessages[MessageKey.messageUniqueId] as? String
                objMessages.message  = discMessages[MessageKey.messageText] as? String
                objMessages.messageId  = discMessages[MessageKey.messageId] as? String
                let date = Date(timeIntervalSince1970: (discMessages[MessageKey.timeStamp] as? TimeInterval)!/1000)
                objMessages.timeStamp  = date as Date as NSDate
                
                let dateStringSection =  date.toString(format: DateFormatType.serverDate)
                let dateFormater : DateFormatter = DateFormatter()
                dateFormater.dateFormat = DateFormatType.serverDate.stringFormat
                let newdate = dateFormater.date(from: dateStringSection)
                objMessages.sectionIdentifier = "\(String(describing: newdate!.timeIntervalSince1970))"
                
                
            }else {
                let objMessages: Messages! = NSEntityDescription.insertNewObject(forEntityName: "Messages", into: context) as! Messages
                objMessages.caseID    = discMessages[MessageKey.groupID] as? String
                objMessages.groupID   = discMessages[MessageKey.groupID] as? String
                objMessages.groupMember = discMessages[MessageKey.memberID] as? String
                objMessages.isGroup   = true
                objMessages.isUpload  = false
                objMessages.isDownload  = false
                objMessages.localPath  = discMessages[MessageKey.localPath] as? String
                objMessages.messageUniqueId  = discMessages[MessageKey.messageUniqueId] as? String
                objMessages.message  = discMessages[MessageKey.messageText] as? String
                objMessages.messageType  = discMessages[MessageKey.messageType] as? String
                objMessages.senderId  = discMessages[MessageKey.senderID] as? String
                objMessages.senderName  = discMessages[MessageKey.senderName] as? String
                objMessages.receiverId  = ""
                objMessages.imageURL    = ""
                
                if (discMessages[MessageKey.messageId] != nil) && (discMessages[MessageKey.imageThumbURL] != nil) && (discMessages[MessageKey.videoUrl] != nil) {
                    objMessages.messageId  = discMessages[MessageKey.messageId] as? String
                    objMessages.imageThumbURL  = discMessages[MessageKey.imageThumbURL] as? String
                    objMessages.videoUrl  = discMessages[MessageKey.videoUrl] as? String
                    objMessages.isUpload  = true
                }else {
                    objMessages.messageId  = ""
                    objMessages.imageThumbURL  = ""
                    objMessages.videoUrl  = ""
                }
                
                let date = Date(timeIntervalSince1970: (discMessages[MessageKey.timeStamp] as? TimeInterval)!/1000)
                objMessages.timeStamp  = date as Date as NSDate
                
                let dateStringSection =  date.toString(format: DateFormatType.serverDate)
                let dateFormater : DateFormatter = DateFormatter()
                dateFormater.dateFormat = DateFormatType.serverDate.stringFormat
                let newdate = dateFormater.date(from: dateStringSection)
                objMessages.sectionIdentifier = "\(String(describing: newdate!.timeIntervalSince1970))"
            }
        }
        
        //Save context
        if context.hasChanges {
            try? context.save()
        }
    }
    
    @objc class func UpdateMediaMessag(messageUniqueId:String, localUrl:String?, isDownload:Bool, context:NSManagedObjectContext) {
        
        if Messages.isExitMessageUniqueId(messageUniqueId: messageUniqueId, context: context) {
            let objMessages: Messages = Messages.MessageUniqueIdObject(messageUniqueId: messageUniqueId, context: context)
            objMessages.isDownload  = isDownload
            
            if let url = localUrl {
                objMessages.localPath = url
            }
        }
    }
    
    @objc class func isExitMessage(messageId:String, context:NSManagedObjectContext) -> Bool {
        
        let request = NSFetchRequest<Messages>(entityName: NSStringFromClass(Messages.self))
        let predicate = NSPredicate(format: "messageId == %@", messageId)
        request.predicate = predicate
        
        let results: [Messages] = try! context.fetch(request)
        if results.count > 0 {
            return true
        }
        return false
    }
    
    @objc class func isExitMessageUniqueId(messageUniqueId:String, context:NSManagedObjectContext) -> Bool {
        
        let request = NSFetchRequest<Messages>(entityName: NSStringFromClass(Messages.self))
        let predicate = NSPredicate(format: "messageUniqueId == %@", messageUniqueId)
        request.predicate = predicate
        
        let results: [Messages] = try! context.fetch(request)
        if results.count > 0 {
            return true
        }
        return false
    }
    
    @objc class func MessageObject(messageId:String, context:NSManagedObjectContext) -> Messages {
        
        let request = NSFetchRequest<Messages>(entityName: NSStringFromClass(Messages.self))
        let predicate = NSPredicate(format: "messageId == %@", messageId)
        request.predicate = predicate
        
        let results: [Messages] = try! context.fetch(request)
        if results.count > 0 {
            return results[0]
        }
        return Messages()
    }
    
    @objc class func MessageUniqueIdObject(messageUniqueId:String, context:NSManagedObjectContext) -> Messages {
        
        let request = NSFetchRequest<Messages>(entityName: NSStringFromClass(Messages.self))
        let predicate = NSPredicate(format: "messageUniqueId == %@", messageUniqueId)
        request.predicate = predicate
        
        let results: [Messages] = try! context.fetch(request)
        if results.count > 0 {
            return results[0]
        }
        return Messages()
    }
}
