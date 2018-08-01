//
//  RecentChat+CoreDataClass.swift
//  CodeStrokeAlert
//
//  Created by Apple on 29/07/18.
//  Copyright © 2018 Jayesh. All rights reserved.
//
//

import Foundation
import CoreData

@objc(RecentChat)
public class RecentChat: NSManagedObject {
    @objc class func InsertMessag(recentChat:[[String:AnyObject]], context:NSManagedObjectContext) {
        
        for discRecentChat in recentChat {
            
            if RecentChat.isExitMessage(groupID: discRecentChat[MessageKey.groupID]! as! String, context: context) {
                
                let objRecentChat: RecentChat = RecentChat.RecentChatMessageObject(groupID: discRecentChat[MessageKey.groupID]! as! String, context: context)
                //Update Exiting Object
                objRecentChat.caseID        = discRecentChat[MessageKey.groupID] as? String
                objRecentChat.groupID       = discRecentChat[MessageKey.groupID] as? String
                objRecentChat.imageURL      = ""
                objRecentChat.groupMember   = discRecentChat[MessageKey.memberID] as? String
                objRecentChat.lastMessage   = discRecentChat[MessageKey.messageText] as? String
                objRecentChat.messageType   = discRecentChat[MessageKey.messageType] as? String
                objRecentChat.receiverId    = ""
                objRecentChat.senderId      = discRecentChat[MessageKey.senderID] as? String
                objRecentChat.senderName    = discRecentChat[MessageKey.senderName] as? String
                //objRecentChat.clinicID      = discRecentChat[MessageKey.clinicID] as? String
                let date = Date(timeIntervalSince1970: (discRecentChat[MessageKey.timeStamp] as? TimeInterval)!/1000)
                objRecentChat.timeStamp     = date as Date as NSDate
                
                if discRecentChat[MessageKey.badgeCount] != nil {
                    objRecentChat.unreadCount = discRecentChat[MessageKey.badgeCount] as! Int16
                }
            } else {
                
                let objRecentChat: RecentChat! = NSEntityDescription.insertNewObject(forEntityName: "RecentChat", into: context) as! RecentChat
                objRecentChat.caseID        = discRecentChat[MessageKey.groupID] as? String
                objRecentChat.groupID       = discRecentChat[MessageKey.groupID] as? String
                objRecentChat.imageURL      = ""
                objRecentChat.groupMember   = discRecentChat[MessageKey.memberID] as? String
                objRecentChat.lastMessage   = discRecentChat[MessageKey.messageText] as? String
                objRecentChat.messageType   = discRecentChat[MessageKey.messageType] as? String
                objRecentChat.receiverId    = ""
                objRecentChat.senderId      = discRecentChat[MessageKey.senderID] as? String
                objRecentChat.senderName    = discRecentChat[MessageKey.senderName] as? String
                //objRecentChat.clinicID      = discRecentChat[MessageKey.clinicID] as? String
                let date = Date(timeIntervalSince1970: (discRecentChat[MessageKey.timeStamp] as? TimeInterval)!/1000)
                objRecentChat.timeStamp     = date as Date as NSDate
                
                if discRecentChat[MessageKey.badgeCount] != nil && discRecentChat[MessageKey.messageText] != nil {
                    objRecentChat.unreadCount = discRecentChat[MessageKey.badgeCount] as! Int16
                }
            }
        }
        
        //Save context
        if context.hasChanges {
            try? context.save()
        }
    }
    
    @objc class func InsertIsTyping(recentChat:[[String:AnyObject]], context:NSManagedObjectContext) {
        
        for discRecentChat in recentChat {
            
            if discRecentChat[MessageKey.groupID] != nil && discRecentChat[MessageKey.typingText] != nil {
                if RecentChat.isExitMessage(groupID: discRecentChat[MessageKey.groupID]! as! String, context: context) {
                    
                    let objRecentChat: RecentChat = RecentChat.RecentChatMessageObject(groupID: discRecentChat[MessageKey.groupID]! as! String, context: context)
                    //Update Exiting Object
                    objRecentChat.messageType   = discRecentChat[MessageKey.messageType] as? String
                    objRecentChat.isTyping      = discRecentChat[MessageKey.isTyping] as! Bool
                    objRecentChat.typingText    = discRecentChat[MessageKey.typingText] as? String
                }
            }
        }
        
        //Save context
        if context.hasChanges {
            try? context.save()
        }
    }
    
    @objc class func isExitMessage(groupID:String, context:NSManagedObjectContext) -> Bool {
        
        let request = NSFetchRequest<RecentChat>(entityName: NSStringFromClass(RecentChat.self))
        let predicate = NSPredicate(format: "groupID == %@", groupID)
        request.predicate = predicate
        
        let results: [RecentChat] = try! context.fetch(request)
        if results.count > 0 {
            return true
        }
        return false
    }
    
    @objc class func RecentChatMessageObject(groupID:String, context:NSManagedObjectContext) -> RecentChat {
        
        let request = NSFetchRequest<RecentChat>(entityName: NSStringFromClass(RecentChat.self))
        let predicate = NSPredicate(format: "groupID == %@", groupID)
        request.predicate = predicate
        
        let results: [RecentChat] = try! context.fetch(request)
        if results.count > 0 {
            return results[0]
        }
        return RecentChat()
    }
}
