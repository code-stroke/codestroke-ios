//
//  Messages+CoreDataProperties.swift
//  CodeStrokeAlert
//
//  Created by Apple on 29/07/18.
//  Copyright © 2018 Jayesh. All rights reserved.
//
//

import Foundation
import CoreData


extension Messages {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Messages> {
        return NSFetchRequest<Messages>(entityName: "Messages")
    }
    
    @NSManaged public var caseID: String?
    @NSManaged public var groupID: String?
    @NSManaged public var groupMember: String?
    @NSManaged public var imageThumbURL: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var isDownload: Bool
    @NSManaged public var isGroup: Bool
    @NSManaged public var isRead: Bool
    @NSManaged public var isUpload: Bool
    @NSManaged public var localPath: String?
    @NSManaged public var message: String?
    @NSManaged public var messageId: String?
    @NSManaged public var messageType: String?
    @NSManaged public var messageUniqueId: String?
    @NSManaged public var receiverId: String?
    @NSManaged public var sectionIdentifier: String?
    @NSManaged public var senderId: String?
    @NSManaged public var senderName: String?
    @NSManaged public var timeStamp: Date?
    @NSManaged public var videoUrl: String?
    
}
