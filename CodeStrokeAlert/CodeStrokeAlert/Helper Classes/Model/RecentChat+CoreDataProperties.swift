//
//  RecentChat+CoreDataProperties.swift
//  CodeStrokeAlert
//
//  Created by Apple on 29/07/18.
//  Copyright © 2018 Jayesh. All rights reserved.
//
//

import Foundation
import CoreData


extension RecentChat {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecentChat> {
        return NSFetchRequest<RecentChat>(entityName: "RecentChat")
    }

    @NSManaged public var caseID: String?
    @NSManaged public var groupID: String?
    @NSManaged public var groupMember: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var isGroup: String?
    @NSManaged public var isTyping: Bool
    @NSManaged public var lastMessage: String?
    @NSManaged public var lastMessageId: String?
    @NSManaged public var messageType: String?
    @NSManaged public var receiverId: String?
    @NSManaged public var senderId: String?
    @NSManaged public var senderName: String?
    @NSManaged public var timeStamp: NSDate?
    @NSManaged public var typingText: String?
    @NSManaged public var unreadCount: Int16

}
