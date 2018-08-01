//
//  SendMessage.swift
//  CrownID
//
//  Created by Jayesh on 8/14/17.
//  Copyright © 2017 Samanvay. All rights reserved.
//

import UIKit

class SendMessage: NSObject {
    
    @objc var senderName : String?
    @objc var senderID : String?
    @objc var receiverID : String?
    @objc var receiverName : String?
    @objc var caseID : String?
    @objc var messageText : String?
    @objc var messageType : String?
    @objc var badgeCount : String?
    var isGroup : Bool?
    @objc var groupMember = [String]()
    @objc var groupName : String?
    @objc var groupID : String?
    @objc var imageURL : String?
    @objc var imageThumbURL : String?
    @objc var videoURL : String?
    @objc var messageUniqueId : String?
    var isTyping : Bool?
    @objc var typingText : String?
}
