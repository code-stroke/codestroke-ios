//
//  FirebaseClass.swift
//  CrownID
//
//  Created by Jayesh on 7/31/17.
//  Copyright © 2017 Samanvay. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import AVFoundation

var MESSAGES_DIRECTORY      = "MESSAGE"
var RECENT_CHAT_DIRECTORY   = "RECENTCHAT/"
var USER_DIRECTORY          = "USERS/"
var NOTIFICATION_QUEUE      = "queue/tasks"

let kFirebaseServerValueTimestamp = ServerValue.timestamp() as! [String: Any]

struct MessageKey {
    static let messageText          = "messageText"
    static let typingText           = "typingText"
    static let senderName           = "senderName"
    static let senderID             = "senderID"
    static let messageType          = "messageType"
    static let timeStamp            = "timeStamp"
    static let messageId            = "messageId"
    static let badgeCount           = "badgeCount"
    static let groupName            = "groupName"
    static let groupID              = "groupID"
    static let memberID             = "memberID"
    static let receiverID           = "receiverID"
    static let receiverName         = "receiverName"
    static let localPath            = "localPath"
    static let messageUniqueId      = "messageUniqueId"
    static let imageURL             = "imageURL"
    static let imageThumbURL        = "imageThumbURL"
    static let videoUrl             = "videoUrl"
    static let isUpload             = "isUpload"
    static let isDownload           = "isDownload"
    static let isTyping             = "isTyping"
    static let isRead               = "isRead"
}

protocol Multimedia {
    //Upload Methods
    func uploadProgress(progress: Double, indexPath:IndexPath)
    func uploadComplit(indexPath:IndexPath)
    func uploadFailed(indexPath:IndexPath)
    
    //Download Methods
    func downloadProgress(progress: Double, indexPath:IndexPath)
    func downloadComplit(indexPath:IndexPath, image:UIImage)
    func downloadFaild(indexPath:IndexPath)
}

class FirebaseClass: NSObject {
    
    @objc static var shared = FirebaseClass()
    var objMultimedia:Multimedia?
    @objc var userID: String?
    
    @objc var ref: DatabaseReference!
    @objc var storageRef: StorageReference!
    var messageHandle: DatabaseHandle!
    
    // MARK:- init Function
    @objc func setupFirebase() {
        //if isLogin() {
        //init DatabaseReference
        self.userID = "1"
        ref = Database.database().reference()
        let storage = Storage.storage()
        storageRef = storage.reference()
        
        //Firbase Login
        self.firebaseLogin()
        
        //Add Observe
        self.observeOnChat()
        //}
    }
    
    // MARK:- Other Function
    @objc func isLogin() -> Bool {
        if let username = utility.getUserDefault(kUserName) {
            if (username as! String) != "" {
                //Assign User ID
                self.userID = String(describing: "1")
                return true
            }else{
                return false
            }
        }else{
            return false
        }
    }
    
    @objc func firebaseLogin() -> Void {
        Auth.auth().signInAnonymously { (objUser, isError) in
            if (isError == nil) {
                print(objUser!)
                
                //Add user date in Firebase
                self.addUserData()
                
            }else{
                print(isError!)
            }
        }
    }
    
    @objc func addUserData() {
        
        var objUserDis              =  [String:String]()
        objUserDis["First Name"]    = "Jayesh"
        objUserDis["Last Name"]     = "Mardiya"
        objUserDis["UserID"]        = "1"
        objUserDis["Image thumb"]   = ""
        objUserDis["Image"]         = ""
        objUserDis["role"]          = "Patient"
        ref.child(USER_DIRECTORY).child("1").setValue(objUserDis)
        utility.setUserDefault(objUserDis["UserID"]!, kUserID)
        utility.setUserDefault("\(objUserDis["First Name"]!) \(objUserDis["Last Name"]!)", kUserName)
    }
    
    @objc class func generatePhotoThumbnail(_ image: UIImage) -> UIImage {
        
        let size: CGSize = image.size
        var croppedSize: CGSize
        let ratio: CGFloat = 10.0
        var offsetX: CGFloat = 0.0
        var offsetY: CGFloat = 0.0
        if size.width > size.height {
            offsetX = (size.height - size.width) / 2
            croppedSize = CGSize(width: size.height, height: size.height)
        }
        else {
            offsetY = (size.width - size.height) / 2
            croppedSize = CGSize(width: size.width, height: size.width)
        }
        
        // Crop the image before resize
        let clippedRect = CGRect(x: offsetX * -1, y: offsetY * -1, width: croppedSize.width, height: croppedSize.height)
        let imageRef: CGImage? = image.cgImage?.cropping(to: clippedRect)
        
        // Resize the image
        let rect = CGRect(x: 0.0, y: 0.0, width: ratio, height: ratio)
        UIGraphicsBeginImageContext(rect.size)
        UIImage(cgImage: imageRef!).draw(in: rect)
        let thumbnail: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return thumbnail!
    }
    
    //Generate conversation Id
    @objc func conversationId(forUser loginUserId: String, andOtherUser otherUserId: String) -> String {
        print("Login user id :- \(loginUserId)")
        print("other user id:- \(otherUserId)")
        
        let arrayForconversationId: [Any] = [loginUserId, otherUserId]
        let arrayforSortedValues: [Any] = (arrayForconversationId as NSArray).sortedArray(using: [NSSortDescriptor(key: "doubleValue", ascending: true)])
        print("Sorted:- \(arrayforSortedValues)")
        let conversationId: String = "\(arrayforSortedValues[0])_\(arrayforSortedValues[1])"
        
        return conversationId
    }
    
    // MARK:- Get Messages Function
    @objc func getLast20Messages(opponent:String!) -> Void {
        ref.child("MESSAGE").child(opponent).queryLimited(toLast: 20).observeSingleEvent(of: DataEventType.value, with: { (objDataSnapshot) in
            print(objDataSnapshot)
            print(objDataSnapshot.childrenCount)
            if objDataSnapshot.exists() {
                for snapshot in objDataSnapshot.children.allObjects {
                    let snapshotObj = snapshot as! DataSnapshot
                    CoreDataClass.shared.insertIntoMessage(array:[snapshotObj.value as! [String:AnyObject]])
                }
            }
        })
    }
    
    @objc func getMessages(opponent:String!, messageID:String!) -> Void {
        ref.child(MESSAGES_DIRECTORY).child(opponent).queryEnding(atValue: messageID).observeSingleEvent(of: DataEventType.value, with: { (objDataSnapshot) in
            print(objDataSnapshot)
            print(objDataSnapshot.childrenCount)
            if objDataSnapshot.exists() {
                for snapshot in objDataSnapshot.children.allObjects {
                    let snapshotObj = snapshot as! DataSnapshot
                    CoreDataClass.shared.insertIntoMessage(array:[snapshotObj.value as! [String:AnyObject]])
                }
            }
        })
    }
    
    // MARK:- isTyping Function
    @objc func isTyping(objSendMessage: SendMessage) -> Void {
        
        var objMessageDis  =  [String:Any]()
        objMessageDis[MessageKey.typingText]    = objSendMessage.typingText
        objMessageDis[MessageKey.isTyping]      = objSendMessage.isTyping
        objMessageDis[MessageKey.messageType]      = objSendMessage.messageType
        
        //Add or update isTyping
        for i in 0..<objSendMessage.groupMember.count {
            if objSendMessage.groupMember[i] != self.userID! {
                self.ref.child(RECENT_CHAT_DIRECTORY).child(objSendMessage.groupMember[i]).child(objSendMessage.caseID!).updateChildValues(objMessageDis)
            }
        }
    }
    
    // MARK:- isTyping Function
    @objc func isRead(objSendMessage: Messages) -> Void {
        
        var objMessageDis  =  [String:Any]()
        objMessageDis[MessageKey.isRead]    = true
        
        //Add or update isTyping
        self.ref.child(MESSAGES_DIRECTORY).child("CD0001").child(objSendMessage.messageId!).updateChildValues(objMessageDis)
        
    }
    
    // MARK:- Add observe Function
    @objc func observeOnChat() -> Void {
        
        //Get List of Recent Chat
        ref.child(RECENT_CHAT_DIRECTORY).child(self.userID!).observeSingleEvent(of:DataEventType.value, with: { (objDataSnapshot) in
            print(objDataSnapshot)
        })
        
        //Add observe for add new Record
        ref.child(RECENT_CHAT_DIRECTORY).child(self.userID!).observe(DataEventType.childAdded, with: { (objDataSnapshot) in
            print(objDataSnapshot)
            if objDataSnapshot.exists() {
                CoreDataClass.shared.insertIntoRecentChat(array: [objDataSnapshot.value as! [String:AnyObject]])
            }
        }) { (Error) in
            
        }
        
        //Add observe for add update Record
        ref.child(RECENT_CHAT_DIRECTORY).child(self.userID!).observe(DataEventType.childChanged, with: { (objDataSnapshot) in
            print(objDataSnapshot)
            if objDataSnapshot.exists() {
                CoreDataClass.shared.insertIntoRecentChat(array: [objDataSnapshot.value as! [String:AnyObject]])
            }
        }) { (Error) in
            
        }
    }
    
    @objc func observeOnMessages(otherUserID:String!, isGroup:Bool) -> Void {
        
        //Get List of Last 20 Messages with add observer
        if isGroup {
            messageHandle =  ref.child(MESSAGES_DIRECTORY).child(otherUserID).queryLimited(toLast: 20).observe(DataEventType.childAdded, with: { (objDataSnapshot) in
                print(objDataSnapshot)
                
            })
        }else{
            messageHandle =  ref.child(MESSAGES_DIRECTORY).child(self.conversationId(forUser: self.userID!, andOtherUser:otherUserID)).queryLimited(toLast: 20).observe(DataEventType.childAdded, with: { (objDataSnapshot) in
            })
        }
    }
    
    // MARK:- remove observe Function
    @objc func RemoveobserveOnMessages(opponent:String!, isGroup:Bool) -> Void {
        //remove observe on Messages
        if isGroup {
            ref.child(MESSAGES_DIRECTORY).child(opponent).queryLimited(toLast: 20).removeObserver(withHandle: messageHandle)
        }else{
            ref.child(MESSAGES_DIRECTORY).child(self.conversationId(forUser: self.userID!, andOtherUser:opponent)).queryLimited(toLast: 20).removeObserver(withHandle: messageHandle)
        }
        messageHandle = nil
    }
    
    @objc func notificationQueue(disMsg:[String:Any]) -> Void {
        //Add Messahe in Queue
        let referenceNode:DatabaseReference = self.ref.child(NOTIFICATION_QUEUE).childByAutoId()
        referenceNode.runTransactionBlock { (MutableData) -> TransactionResult in
            MutableData.value = disMsg
            return TransactionResult.success(withValue: MutableData)
        }
    }
    
    @objc func AddOrUpdateUnreadCount(opponent:String!, userID:String) -> Void {
        //Add Messahe in Queue
        let referenceNode:DatabaseReference = self.ref.child(RECENT_CHAT_DIRECTORY).child(userID).child(opponent).child(MessageKey.badgeCount)
        referenceNode.runTransactionBlock { (MutableData) -> TransactionResult in
            
            let number = MutableData.value as? NSNumber
            if number != nil {
                MutableData.value = NSNumber.init(value: (number?.intValue)! + 1)
            }else{
                MutableData.value = NSNumber.init(value: 1)
            }
            return TransactionResult.success(withValue: MutableData)
        }
    }
    
    @objc func reSetUnreadCount(opponent:String!) -> Void {
        let referenceNode:DatabaseReference = self.ref.child(RECENT_CHAT_DIRECTORY).child(self.userID!).child(opponent).child(MessageKey.badgeCount)
        
        referenceNode.runTransactionBlock { (MutableData) -> TransactionResult in
            MutableData.value = NSNumber.init(value: 0)
            return TransactionResult.success(withValue: MutableData)
        }
    }
    
    @objc func updateDownloadStates(opponent:String!, messageId:String) -> Void {
        //Update Message node
        let referenceNode:DatabaseReference = self.ref.child(MESSAGES_DIRECTORY).child(opponent!).child(messageId).child(MessageKey.isDownload)
        
        referenceNode.runTransactionBlock { (MutableData) -> TransactionResult in
            MutableData.value = true
            return TransactionResult.success(withValue: MutableData)
        }
        
        //Update on RecentChat
        let referenceNodeForRecentChat:DatabaseReference = self.ref.child(RECENT_CHAT_DIRECTORY).child(self.userID!).child(opponent).child(MessageKey.isDownload)
        
        referenceNodeForRecentChat.runTransactionBlock { (MutableData) -> TransactionResult in
            MutableData.value = true
            return TransactionResult.success(withValue: MutableData)
        }
    }
    
    // MARK:- send messages Function
    @objc func SendMessage(objSendMessage: SendMessage) -> Void {
        
        var objMessageDis  =  [String:Any]()
        objMessageDis[MessageKey.messageText]    = objSendMessage.messageText
        objMessageDis[MessageKey.senderName]     = objSendMessage.senderName
        objMessageDis[MessageKey.senderID]       = objSendMessage.senderID
        objMessageDis[MessageKey.messageType]    = objSendMessage.messageType
        objMessageDis[MessageKey.timeStamp]      = kFirebaseServerValueTimestamp
        objMessageDis[MessageKey.isRead]         = false
        
        let addMessageHandle: DatabaseReference! = ref.child(MESSAGES_DIRECTORY).child(objSendMessage.caseID!).childByAutoId()
        objMessageDis[MessageKey.messageId] = addMessageHandle.key
        
        if objSendMessage.isGroup! {
            objMessageDis[MessageKey.groupID]         = objSendMessage.groupID
            objMessageDis[MessageKey.groupName]       = objSendMessage.groupName
            objMessageDis[MessageKey.memberID]        = (objSendMessage.groupMember.map{String($0)}).joined(separator: ",")
            
            for i in 0..<objSendMessage.groupMember.count {
                self.ref.child(RECENT_CHAT_DIRECTORY).child(objSendMessage.groupMember[i]).child(objSendMessage.caseID!).updateChildValues(objMessageDis)
            }
            
            //Add values in message
            addMessageHandle.setValue(objMessageDis)
            
            //Add or update UnreadCount
            for i in 0..<objSendMessage.groupMember.count {
                if objSendMessage.groupMember[i] != self.userID! {
                    self.AddOrUpdateUnreadCount(opponent: objSendMessage.caseID!, userID: objSendMessage.groupMember[i])
                }
            }
            
        }else {
            objMessageDis[MessageKey.receiverID]         = objSendMessage.receiverID
            objMessageDis[MessageKey.receiverName]       = objSendMessage.receiverName
            //Add on My RecentChat
            self.ref.child(RECENT_CHAT_DIRECTORY).child(self.userID!).child(objSendMessage.receiverID!).setValue(objMessageDis)
            
            //Add values in message
            addMessageHandle.setValue(objMessageDis)
            
            //Add on opponent RecentChat
            self.ref.child(RECENT_CHAT_DIRECTORY).child(objSendMessage.receiverID!).child(self.userID!).setValue(objMessageDis)
            
            //Add or update UnreadCount
            self.AddOrUpdateUnreadCount(opponent: objSendMessage.receiverID, userID: self.userID!)
        }
        
        //Add Message in Queue
        self.notificationQueue(disMsg: objMessageDis)
    }
    
    // MARK:- send Image Function
    @objc func SendImage(objSendMessage: SendMessage) -> Void {
        var objMessageDis  =  [String:Any]()
        objMessageDis[MessageKey.messageText]    = objSendMessage.messageText
        objMessageDis[MessageKey.senderName]     = objSendMessage.senderName
        objMessageDis[MessageKey.senderID]       = objSendMessage.senderID
        objMessageDis[MessageKey.messageType]    = objSendMessage.messageType
        objMessageDis[MessageKey.timeStamp]      = kFirebaseServerValueTimestamp
        objMessageDis[MessageKey.imageURL]       = objSendMessage.imageURL
        objMessageDis[MessageKey.imageThumbURL]  = objSendMessage.imageThumbURL
        objMessageDis[MessageKey.messageUniqueId] = objSendMessage.messageUniqueId
        objMessageDis[MessageKey.isDownload]       = false
        
        let addMessageHandle: DatabaseReference! = ref.child(MESSAGES_DIRECTORY).child(objSendMessage.caseID!).childByAutoId()
        objMessageDis[MessageKey.messageId] = addMessageHandle.key
        
        if objSendMessage.isGroup! {
            objMessageDis[MessageKey.groupID]         = objSendMessage.groupID
            objMessageDis[MessageKey.groupName]       = objSendMessage.groupName
            objMessageDis[MessageKey.memberID]        = (objSendMessage.groupMember.map{String($0)}).joined(separator: ",")
            
            for i in 0..<objSendMessage.groupMember.count {
                self.ref.child(RECENT_CHAT_DIRECTORY).child(objSendMessage.groupMember[i]).child(objSendMessage.caseID!).updateChildValues(objMessageDis)
            }
            
            //Add values in message
            addMessageHandle.setValue(objMessageDis)
            
            //Add or update UnreadCount
            for i in 0..<objSendMessage.groupMember.count {
                if objSendMessage.groupMember[i] != self.userID! {
                    self.AddOrUpdateUnreadCount(opponent: objSendMessage.caseID!, userID: objSendMessage.groupMember[i])
                }
            }
            
        }else {
            objMessageDis[MessageKey.receiverID]         = objSendMessage.receiverID
            objMessageDis[MessageKey.receiverName]       = objSendMessage.receiverName
            //Add on My RecentChat
            self.ref.child(RECENT_CHAT_DIRECTORY).child(self.userID!).child(objSendMessage.receiverID!).setValue(objMessageDis)
            
            //Add values in message
            addMessageHandle.setValue(objMessageDis)
            
            //Add on opponent RecentChat
            self.ref.child(RECENT_CHAT_DIRECTORY).child(objSendMessage.receiverID!).child(self.userID!).setValue(objMessageDis)
            
            //Add or update UnreadCount
            self.AddOrUpdateUnreadCount(opponent: objSendMessage.receiverID, userID: self.userID!)
        }
        
        //Add Message in Queue
        self.notificationQueue(disMsg: objMessageDis)
    }
    
    // MARK:- send Image Function
    @objc func SendVideo(objSendMessage: SendMessage) -> Void {
        var objMessageDis  =  [String:Any]()
        objMessageDis[MessageKey.messageText]    = objSendMessage.messageText
        objMessageDis[MessageKey.senderName]     = objSendMessage.senderName
        objMessageDis[MessageKey.senderID]       = objSendMessage.senderID
        objMessageDis[MessageKey.messageType]    = objSendMessage.messageType
        objMessageDis[MessageKey.timeStamp]      = kFirebaseServerValueTimestamp
        objMessageDis[MessageKey.videoUrl]       = objSendMessage.videoURL
        objMessageDis[MessageKey.imageThumbURL]  = objSendMessage.imageThumbURL
        objMessageDis[MessageKey.messageUniqueId] = objSendMessage.messageUniqueId
        objMessageDis[MessageKey.isDownload]       = false
        
        let addMessageHandle: DatabaseReference! = ref.child(MESSAGES_DIRECTORY).child(objSendMessage.caseID!).childByAutoId()
        objMessageDis[MessageKey.messageId] = addMessageHandle.key
        
        if objSendMessage.isGroup! {
            objMessageDis[MessageKey.groupID]         = objSendMessage.groupID
            objMessageDis[MessageKey.groupName]       = objSendMessage.groupName
            objMessageDis[MessageKey.memberID]        = (objSendMessage.groupMember.map{String($0)}).joined(separator: ",")
            
            for i in 0..<objSendMessage.groupMember.count {
                self.ref.child(RECENT_CHAT_DIRECTORY).child(objSendMessage.groupMember[i]).child(objSendMessage.caseID!).updateChildValues(objMessageDis)
            }
            
            //Add values in message
            addMessageHandle.setValue(objMessageDis)
            
            //Add or update UnreadCount
            for i in 0..<objSendMessage.groupMember.count {
                if objSendMessage.groupMember[i] != self.userID! {
                    self.AddOrUpdateUnreadCount(opponent: objSendMessage.caseID!, userID: objSendMessage.groupMember[i])
                }
            }
            
        }else {
            objMessageDis[MessageKey.receiverID]         = objSendMessage.receiverID
            objMessageDis[MessageKey.receiverName]       = objSendMessage.receiverName
            //Add on My RecentChat
            self.ref.child(RECENT_CHAT_DIRECTORY).child(self.userID!).child(objSendMessage.receiverID!).setValue(objMessageDis)
            
            //Add values in message
            addMessageHandle.setValue(objMessageDis)
            
            //Add on opponent RecentChat
            self.ref.child(RECENT_CHAT_DIRECTORY).child(objSendMessage.receiverID!).child(self.userID!).setValue(objMessageDis)
            
            //Add or update UnreadCount
            self.AddOrUpdateUnreadCount(opponent: objSendMessage.receiverID, userID: self.userID!)
        }
        
        //Add Message in Queue
        self.notificationQueue(disMsg: objMessageDis)
    }
    
    @objc func uploadImage(localPath:String, imageName:String, indexPath: IndexPath, completion:@escaping (_ url: String?, _ thumUrl: String?) -> Void) {
        
        // Local file you want to upload
        let localFile = URL(string:localPath)!
        
        // Create the file metadata
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let filePath = "image/\(imageName).jpg"
        
        // Upload file and metadata to the object 'images/mountains.jpg'
        let uploadTask :StorageUploadTask = self.storageRef.child(filePath).putFile(from: localFile, metadata: metadata) { (StorageMetadata, error) in
            if error != nil {
                print("error")
                completion(nil, nil)
            } else{
                
                let ref = self.storageRef.child(filePath)
                ref.downloadURL(completion: { (url1, error) in
                    let imageURl = URL.init(string: localPath)
                    let image    = UIImage(contentsOfFile:(imageURl?.path)!)
                    let thumImage = FirebaseClass.generatePhotoThumbnail(image!)
                    let thumFilePath = "image/thumb/\(imageName).jpg"
                    
                    let imageData: NSData = UIImagePNGRepresentation(thumImage)! as NSData
                    self.storageRef.child(thumFilePath).putData(imageData as Data, metadata: metadata, completion: { (thumStorageMetadata, thumError) in
                        if error != nil {
                            print("error")
                            completion(nil, nil)
                        } else{
                            
                            let ref = self.storageRef.child(filePath)
                            
                            // get the download URL
                            ref.downloadURL { url2, error in
                                if let error = error {
                                    print(error)
                                } else {
                                    completion("\(String(describing: url1!))", "\(String(describing: url2!))")
                                }
                            }
                        }
                    })
                    
                })
            }
        }
        
        uploadTask.observe(.progress) { snapshot in
            // Upload reported progress
            let percentComplete = 360 * Double(snapshot.progress!.completedUnitCount)
                / Double(snapshot.progress!.totalUnitCount)
            if percentComplete > 0 {
                self.objMultimedia?.uploadProgress(progress: percentComplete, indexPath: indexPath)
            }
            
            print(percentComplete)
        }
        
        uploadTask.observe(.success) { snapshot in
            self.objMultimedia?.uploadComplit(indexPath:indexPath)
        }
        
        uploadTask.observe(.failure) { snapshot in
            if let error = snapshot.error as NSError? {
                switch (StorageErrorCode(rawValue: error.code)!) {
                case .objectNotFound:
                    // File doesn't exist
                    break
                case .unauthorized:
                    // User doesn't have permission to access file
                    break
                case .cancelled:
                    // User canceled the upload
                    break
                case .unknown:
                    // Unknown error occurred, inspect the server response
                    break
                default:
                    // A separate error occurred. This is a good place to retry the upload.
                    break
                }
                self.objMultimedia?.uploadFailed(indexPath:indexPath)
            }
        }
    }
    
    @objc func videoThumImage(localPath:String) -> UIImage? {
        do {
            let asset = AVURLAsset(url: URL(string:localPath)! , options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
            let thumbnail = UIImage(cgImage: cgImage)
            
            return thumbnail
        } catch let error {
            
            print("*** Error generating thumbnail: \(error.localizedDescription)")
            return UIImage.init(named: "crown-logo")
        }
    }
    
    @objc func uploadVideo(localPath:String, videoName:String, indexPath: IndexPath, completion:@escaping (_ url: String?, _ thumUrl: String?) -> Void) {
        
        // Local file you want to upload
        let localFile = URL(string:localPath)!
        
        // Create the file metadata
        let metadata = StorageMetadata()
        metadata.contentType = "video/mov"
        
        let filePath = "video/\(videoName).mov"
        
        // Upload file and metadata to the object 'images/mountains.jpg'
        let uploadTask :StorageUploadTask = self.storageRef.child(filePath).putFile(from: localFile, metadata: metadata) { (StorageMetadata, error) in
            if error != nil {
                print("error")
                completion(nil, nil)
            } else{
                
                let thumImage = FirebaseClass.generatePhotoThumbnail(self.videoThumImage(localPath: localPath)!)
                let thumFilePath = "video/thumb/\(videoName).jpg"
                let imageData: NSData = UIImagePNGRepresentation(thumImage)! as NSData
                
                self.storageRef.child(thumFilePath).putData(imageData as Data, metadata: metadata, completion: { (thumStorageMetadata, thumError) in
                    if error != nil {
                        print("error")
                        completion(nil, nil)
                    } else{
                        let ref = self.storageRef.child(filePath)
                        
                        // get the download URL
                        ref.downloadURL { url, error in
                            if let error = error {
                                print(error)
                            } else {
                                completion(filePath, thumFilePath)
                            }
                        }
                    }
                })
            }
        }
        
        uploadTask.observe(.progress) { snapshot in
            // Upload reported progress
            let percentComplete = 360 * Double(snapshot.progress!.completedUnitCount)
                / Double(snapshot.progress!.totalUnitCount)
            if percentComplete > 0 {
                self.objMultimedia?.uploadProgress(progress: percentComplete, indexPath: indexPath)
            }
            
            print(percentComplete)
        }
        
        uploadTask.observe(.success) { snapshot in
            self.objMultimedia?.uploadComplit(indexPath:indexPath)
        }
        
        uploadTask.observe(.failure) { snapshot in
            if let error = snapshot.error as NSError? {
                switch (StorageErrorCode(rawValue: error.code)!) {
                case .objectNotFound:
                    // File doesn't exist
                    break
                case .unauthorized:
                    // User doesn't have permission to access file
                    break
                case .cancelled:
                    // User canceled the upload
                    break
                case .unknown:
                    // Unknown error occurred, inspect the server response
                    break
                default:
                    // A separate error occurred. This is a good place to retry the upload.
                    break
                }
                self.objMultimedia?.uploadFailed(indexPath:indexPath)
            }
        }
    }
    
    @objc func downloadVideo(localPath:URL, videoName:String, indexPath: IndexPath, completion:@escaping (_ url: String?, _ thumUrl: String?) -> Void) {
        
        // Start the download (in this case writing to a file)
        let downloadTask = self.storageRef.child("video/\(videoName).mov").write(toFile:localPath) { (url, error) in
            if error != nil {
                print("error")
                completion(nil, nil)
            } else{
                completion(url?.relativeString, nil)
            }
        }
        
        downloadTask.observe(.progress) { snapshot in
            // Download reported progress
            let percentComplete = 360 * Double(snapshot.progress!.completedUnitCount)
                / Double(snapshot.progress!.totalUnitCount)
            if percentComplete > 0 {
                self.objMultimedia?.downloadProgress(progress: percentComplete, indexPath: indexPath)
            }
        }
        
        downloadTask.observe(.success) { snapshot in
            
        }
        
        // Errors only occur in the "Failure" case
        downloadTask.observe(.failure) { snapshot in
            guard let errorCode = (snapshot.error as NSError?)?.code else {
                return
            }
            guard let error = StorageErrorCode(rawValue: errorCode) else {
                return
            }
            switch (error) {
            case .objectNotFound:
                // File doesn't exist
                break
            case .unauthorized:
                // User doesn't have permission to access file
                break
            case .cancelled:
                // User cancelled the download
                break
                
            case .unknown:
                // Unknown error occurred, inspect the server response
                break
            default:
                // Another error occurred. This is a good place to retry the download.
                break
            }
            self.objMultimedia?.downloadFaild(indexPath:indexPath)
        }
    }
}
