//
//  ChatVC.swift
//  CrownID
//
//  Created by Apple on 05/07/17.
//  Copyright © 2017 Samanvay. All rights reserved.
//

import UIKit
import CoreData
import SDWebImage
import IQKeyboardManagerSwift

var TEXT      = "text"
var IMAGE     = "image"
var VIDEO     = "video"
var TYPING    = "isTyping"

let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)

class ChatVC: UIViewController {
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var tblChat: UITableView!
    @IBOutlet weak var inputToolBar: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTyping: UILabel!
    @IBOutlet weak var ctBottomInputToolBar: NSLayoutConstraint!
    
    @objc let textViewMsg = GrowingTextView()
    @objc var imageUploadMessageID = [String]()
    
    @objc var CaseID: String?
    @objc var userID: String!
    @objc var arrayGroupMember = [String]()
    @objc var objMessageDis  =  [String:AnyObject]()
    @objc var objCustomMediaViewer: CustomMediaViewer? = nil
    @objc var timerTyping = Timer()
    
    @objc lazy var messageFetch: NSFetchedResultsController<Messages> = {
        return CoreDataClass.shared.fetchedResultsControllerForMessages(delegate: self, opponentID: self.CaseID!)
    }()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Call user defind metheds
        self.setLayout()
        self.initObject()
        
        self.tblChat.estimatedRowHeight = UIScreen.main.bounds.size.height
        self.tblChat.rowHeight = UITableViewAutomaticDimension
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))
        view.addGestureRecognizer(tapGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        //Add Observe
        FirebaseClass.shared.observeOnMember(casID: self.CaseID)
        
        //Get Last MessageID
        let objMessages: Messages? = CoreDataClass.shared.getLastMessageID(opponentID: self.CaseID!)
        if let messageId = objMessages?.messageId {
            FirebaseClass.shared.getMessages(opponent: self.CaseID!, messageID: messageId)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        IQKeyboardManager.shared.enable = false
        
        //self.lblTitle.text = CaseID
        
        //Add Member
        FirebaseClass.shared.addMembers(caseID: self.CaseID, userID: self.userID)
        
        self.tblChat.reloadData()
        self.doScrollTableToBottom()
        
        if (self.messageFetch.sections?.count)! > 0 {
            //Reset Unread count
            //FirebaseClass.shared.reSetUnreadCount(opponent: self.CaseID)
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        IQKeyboardManager.shared.enable = true
    }
    
    @objc class func instance() -> ChatVC {
        
        return mainStoryBoard.instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK:- Other Function
    
    @objc func setLayout() {
        self.doCreateTextViewFromMessage()
    }
    
    @objc func initObject() {
        FirebaseClass.shared.objMultimedia = self
        CoreDataClass.shared.objTypeingDelegate = self
    }
    
    @objc func doCreateTextViewFromMessage() {
        textViewMsg.delegate = self
        textViewMsg.layer.cornerRadius = 4.0
        textViewMsg.maxHeight = 70
        textViewMsg.trimWhiteSpaceWhenEndEditing = true
        textViewMsg.placeHolder = "Enter your message..."
        textViewMsg.placeHolderColor = UIColor(white: 0.8, alpha: 1.0)
        textViewMsg.placeHolderLeftMargin = 5.0
        textViewMsg.tag = 5000
        textViewMsg.font = UIFont.systemFont(ofSize: 14.0)
        textViewMsg.textColor = utility.RGBColor(r: 100, g: 100, b: 100)
        textViewMsg.backgroundColor = utility.RGBColor(r: 240, g: 240, b: 240)
        inputToolBar.addSubview(textViewMsg)
        textViewMsg.translatesAutoresizingMaskIntoConstraints = false
        inputToolBar.translatesAutoresizingMaskIntoConstraints = false
        let views = ["textView": textViewMsg]
        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-53-[textView]-53-|", options: [], metrics: nil, views: views)
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[textView]-8-|", options: [], metrics: nil, views: views)
        inputToolBar.addConstraints(hConstraints)
        inputToolBar.addConstraints(vConstraints)
        self.view.layoutIfNeeded()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardShow(_ notification: Notification) {
        
        let endFrame = ((notification as NSNotification).userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        if IS_IPHONE_X {
            ctBottomInputToolBar.constant = UIScreen.main.bounds.height - endFrame.origin.y - 35
        } else {
            ctBottomInputToolBar.constant = UIScreen.main.bounds.height - endFrame.origin.y
        }
        
        self.view.layoutIfNeeded()
        self.doScrollTableToBottom()
    }
    
    @objc func keyboardHide(_ notification: Notification) {
        let endFrame = ((notification as NSNotification).userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        ctBottomInputToolBar.constant = UIScreen.main.bounds.height - endFrame.origin.y
        self.view.layoutIfNeeded()
    }
    
    @objc func tapGestureHandler() {
        view.endEditing(true)
    }
    
    @objc func doScrollTableToBottom() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
            let numberOfSections = self.tblChat.numberOfSections
            if numberOfSections > 0 {
                let numberOfRows = self.tblChat.numberOfRows(inSection: numberOfSections-1)
                if numberOfRows > 0 {
                    let indexPath = NSIndexPath(row: numberOfRows-1, section: (numberOfSections-1))
                    self.tblChat.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.bottom, animated: false)
                }
            }
        }
    }
    
    @objc func generateUUID() -> String {
        var result: String? = nil
        let uuid: CFUUID = CFUUIDCreate(nil)
        if uuid != nil {
            result = (CFUUIDCreateString(nil, uuid) as String?)
        }
        return result!
    }
    
    @objc func downloadVideo(objMessages: Messages, indexPath: IndexPath) -> Void {
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let filePathToWrite = "\(paths)/\(String(describing: objMessages.messageUniqueId!)).mov"
        let localUrl = NSURL(fileURLWithPath: filePathToWrite) as URL
        
        FirebaseClass.shared.downloadVideo(localPath: localUrl, videoName: objMessages.messageUniqueId!, indexPath: indexPath) { (url, thubUrl) in
            FirebaseClass.shared.updateDownloadStates(opponent: self.CaseID, messageId: objMessages.messageId!)
            CoreDataClass.shared.UpdateMediaMessag(messageId: objMessages.messageUniqueId!, localUrl: url, isDownload: true)
        }
    }
    
    @objc func downloadImage(objMessages: Messages, indexPath: IndexPath) -> Void {
        self.downloadProgress(progress: 10.0, indexPath: indexPath)
        
        //Download image
        SDWebImageManager.shared().imageDownloader?.downloadImage(with: URL.init(string: objMessages.imageURL!), options: SDWebImageDownloaderOptions.ignoreCachedResponse, progress: { (receivedSize, expectedSize, imageURL) in
            let percentComplete = (Double(receivedSize) * 360.00) / Double(expectedSize)
            if percentComplete > 0 {
                DispatchQueue.main.async {
                    self.downloadProgress(progress: percentComplete, indexPath: indexPath)
                }
            }
            print(percentComplete)
        }, completed: { (image, date, error, succes) in
            if succes {
                SDWebImageManager.shared().saveImage(toCache: image, for: URL.init(string: objMessages.imageURL!))
                self.downloadComplit(indexPath: indexPath, image: image!)
                FirebaseClass.shared.updateDownloadStates(opponent: self.CaseID, messageId: objMessages.messageId!)
                CoreDataClass.shared.UpdateMediaMessag(messageId: objMessages.messageUniqueId!, localUrl: nil, isDownload: true)
            }
        })
    }
    
    @objc func UploadImage(objMessages: Messages, indexPath: IndexPath) -> Void {
        
        if imageUploadMessageID.contains(objMessages.messageUniqueId!) {
            
        } else {
            //Upload Image
            imageUploadMessageID.append(objMessages.messageUniqueId!)
            FirebaseClass.shared.uploadImage(localPath:objMessages.localPath!, imageName:objMessages.messageUniqueId!, indexPath: indexPath, completion: { (url, thubUrl) in
                //Remove Object
                if let index = self.imageUploadMessageID.index(where: {$0 == objMessages.messageUniqueId}) {
                    self.imageUploadMessageID.remove(at: index)
                }
                
                //Send To Forebase
                let objSendMessage = SendMessage()
                objSendMessage.isGroup          = true
                objSendMessage.messageText      = objMessages.message
                objSendMessage.messageType      = objMessages.messageType
                objSendMessage.caseID           = objMessages.caseID
                objSendMessage.groupName        = objMessages.groupID
                objSendMessage.groupMember      = self.arrayGroupMember
                objSendMessage.senderName       = objMessages.senderName
                objSendMessage.senderID         = objMessages.senderId
                objSendMessage.receiverID       = objMessages.receiverId
                objSendMessage.groupID          = objMessages.groupID
                objSendMessage.imageURL         = url
                objSendMessage.imageThumbURL    = thubUrl
                objSendMessage.messageUniqueId  = objMessages.messageUniqueId
                
                FirebaseClass.shared.SendImage(objSendMessage:objSendMessage)
            })
        }
    }
    
    @objc func UploadVideo(objMessages: Messages, indexPath: IndexPath) -> Void {
        
        if imageUploadMessageID.contains(objMessages.messageUniqueId!) {
            
        }else {
            //Upload Image
            imageUploadMessageID.append(objMessages.messageUniqueId!)
            FirebaseClass.shared.uploadVideo(localPath:objMessages.localPath!, videoName:objMessages.messageUniqueId!, indexPath: indexPath, completion: { (url, thubUrl) in
                //Remove Object
                if let index = self.imageUploadMessageID.index(where: {$0 == objMessages.messageUniqueId}) {
                    self.imageUploadMessageID.remove(at: index)
                }
                
                //Send To Forebase
                let objSendMessage = SendMessage()
                objSendMessage.isGroup          = true
                objSendMessage.messageText      = objMessages.message
                objSendMessage.messageType      = objMessages.messageType
                objSendMessage.caseID           = objMessages.caseID
                objSendMessage.groupName        = objMessages.groupID
                objSendMessage.groupMember      = self.arrayGroupMember
                objSendMessage.senderName       = objMessages.senderName
                objSendMessage.senderID         = objMessages.senderId
                objSendMessage.receiverID       = objMessages.receiverId
                objSendMessage.groupID          = objMessages.groupID
                objSendMessage.videoURL         = url
                objSendMessage.imageThumbURL    = thubUrl
                objSendMessage.messageUniqueId  = objMessages.messageUniqueId
                
                FirebaseClass.shared.SendVideo(objSendMessage:objSendMessage)
            })
        }
    }
    
    @objc func stopTyeping() -> Void {
        let objSendMessage = SendMessage()
        objSendMessage.messageType  = TYPING
        objSendMessage.typingText   = ""
        objSendMessage.isTyping     = false
        objSendMessage.groupMember  = self.arrayGroupMember
        objSendMessage.caseID       = self.CaseID
        FirebaseClass.shared.isTyping(objSendMessage: objSendMessage)
    }
    
    // MARK:- Button Method
    
    @IBAction func doBackClicked(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnTapOnAttechment(_ sender: Any) {
        
        self.showActionSheetPhotoPicker { (success, image, mediaUrl, isImage, picker) in
            if success {
                self.objMessageDis[MessageKey.messageUniqueId] = self.generateUUID() as AnyObject
                self.objMessageDis[MessageKey.groupID] = self.CaseID as AnyObject
                self.objMessageDis[MessageKey.messageText] = "image" as AnyObject
                self.objMessageDis[MessageKey.messageType] = IMAGE as AnyObject
                self.objMessageDis[MessageKey.groupID] = self.CaseID as AnyObject
                self.objMessageDis[MessageKey.groupName] = self.CaseID as AnyObject
                self.objMessageDis[MessageKey.senderID] = self.userID as AnyObject
                self.objMessageDis[MessageKey.senderName] = LoginUserData.savedUser()!.strFirstName as AnyObject
                self.objMessageDis[MessageKey.memberID] = (self.arrayGroupMember.map{String($0)}).joined(separator: ",") as AnyObject
                self.objMessageDis[MessageKey.receiverID] = self.CaseID as AnyObject
                let timestamp = ((NSDate().timeIntervalSince1970) * 1000)
                self.objMessageDis[MessageKey.timeStamp] = timestamp as AnyObject
                
                if !isImage! {
                    self.objMessageDis[MessageKey.localPath] = mediaUrl?.relativeString as AnyObject
                    self.objMessageDis[MessageKey.messageText] = "video" as AnyObject
                    self.objMessageDis[MessageKey.messageType] = VIDEO as AnyObject
                    
                    //Add Message
                    CoreDataClass.shared.insertIntoVideoMessage(array: [self.objMessageDis as Dictionary<String, AnyObject>])
                } else {
                    let fileManager = FileManager.default
                    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
                    let filePathToWrite = "\(paths)/\(self.generateUUID()).jpg"
                    let imageData: NSData = UIImageJPEGRepresentation(image!, 0.3)! as NSData
                    fileManager.createFile(atPath: filePathToWrite, contents: imageData as Data, attributes: nil)
                    let tempurl = NSURL(fileURLWithPath: filePathToWrite) as URL
                    self.objMessageDis[MessageKey.localPath] = tempurl.relativeString as AnyObject
                    
                    //Add in Message
                    CoreDataClass.shared.insertIntoImageMessage(array: [self.objMessageDis as Dictionary<String, AnyObject>])
                }
            }
        }
    }
    
    @IBAction func sendMessag(_ sender: Any) {
        //self.stopTyeping()
     
        for obj in appDelegate.arrForGroupMembers {
            if self.arrayGroupMember.contains(obj) {
                //Already in array
            }else{
                self.arrayGroupMember.append(obj)
            }
        }
        
        self.textViewMsg.text = self.textViewMsg.text.trimmingCharacters(in: .whitespacesAndNewlines)
        if self.textViewMsg.text.count > 0 {
            let objSendMessage = SendMessage()
            objSendMessage.isGroup      = true
            objSendMessage.messageText  = self.textViewMsg.text
            objSendMessage.messageType  = TEXT
            objSendMessage.caseID       = self.CaseID
            objSendMessage.groupName    = self.CaseID
            objSendMessage.senderName   = LoginUserData.savedUser()!.strFirstName
            objSendMessage.senderID     = "\(UserData.savedUser()!.login_user_id)"
            objSendMessage.groupMember  = self.arrayGroupMember 
            objSendMessage.receiverID   = self.CaseID
            objSendMessage.groupID      = self.CaseID
            FirebaseClass.shared.SendMessage(objSendMessage: objSendMessage)
            self.textViewMsg.text = ""
        }
    }
    
    @objc func btnDownloadImageTap(sender : UIButton) {
        
        let center: CGPoint = sender.center
        let rootViewPoint: CGPoint = sender.superview!.convert(center, to: tblChat)
        let indexPath: IndexPath? = tblChat.indexPathForRow(at: rootViewPoint)
        
        let messages: Messages? = messageFetch.object(at: indexPath!)
        
        if let cell = tblChat.cellForRow(at: indexPath!) as? ReceivedImageCell {
            cell.progress.isHidden = false
            cell.btnDownload.isHidden = true
        }
        
        //Download Image
        self.downloadImage(objMessages: messages!, indexPath: indexPath!)
    }
    
    @objc func btnDownloadVideoTap(sender : UIButton) {
        let center: CGPoint = sender.center
        let rootViewPoint: CGPoint = sender.superview!.convert(center, to: tblChat)
        let indexPath: IndexPath? = tblChat.indexPathForRow(at: rootViewPoint)
        
        let messages: Messages? = messageFetch.object(at: indexPath!)
        
        if let cell = tblChat.cellForRow(at: indexPath!) as? ReceivedVideoCell {
            cell.progress.isHidden = false
            cell.btnDownload.isHidden = true
        }
        
        //Download Image
        self.downloadVideo(objMessages: messages!, indexPath: indexPath!)
    }
    
    @objc func btnOpenImageTap(sender : UIButton) {
        let center: CGPoint = sender.center
        let rootViewPoint: CGPoint = sender.superview!.convert(center, to: tblChat)
        let indexPath: IndexPath? = tblChat.indexPathForRow(at: rootViewPoint)
        
        let messages: Messages? = messageFetch.object(at: indexPath!)
        if let cell = tblChat.cellForRow(at: indexPath!) as? ReceivedImageCell {
            if messages?.localPath == nil || messages?.localPath == "" {
                objCustomMediaViewer = CustomMediaViewer.init(controller: self, pathURL: URL.init(string:(messages?.imageURL!)!)!, isForVideo: false)
                objCustomMediaViewer?.showMediaOnTheView(theView: cell.imageReceived)
            }else {
                objCustomMediaViewer = CustomMediaViewer.init(controller: self, pathURL: URL.init(string:(messages?.localPath!)!)!, isForVideo: false)
                objCustomMediaViewer?.showMediaOnTheView(theView: cell.imageReceived)
            }
        } else {
            if let cell = tblChat.cellForRow(at: indexPath!) as? SentImageCell {
                if messages?.localPath == nil || messages?.localPath == "" {
                    objCustomMediaViewer = CustomMediaViewer.init(controller: self, pathURL: URL.init(string:(messages?.imageURL!)!)!, isForVideo: false)
                    objCustomMediaViewer?.showMediaOnTheView(theView: cell.imagSent)
                }else {
                    objCustomMediaViewer = CustomMediaViewer.init(controller: self, pathURL: URL.init(string:(messages?.localPath!)!)!, isForVideo: false)
                    objCustomMediaViewer?.showMediaOnTheView(theView: cell.imagSent)
                }
            }
        }
    }
    
    @objc func btnPlayTap(sender : UIButton) {
        let center: CGPoint = sender.center
        let rootViewPoint: CGPoint = sender.superview!.convert(center, to: tblChat)
        let indexPath: IndexPath? = tblChat.indexPathForRow(at: rootViewPoint)
        
        let messages: Messages? = messageFetch.object(at: indexPath!)
        if let cell = tblChat.cellForRow(at: indexPath!) as? ReceivedVideoCell {
            if messages?.localPath == nil || messages?.localPath == "" {
                objCustomMediaViewer = CustomMediaViewer.init(controller: self, pathURL: URL.init(string:(messages?.videoUrl!)!)!, isForVideo: true)
                objCustomMediaViewer?.showMediaOnTheView(theView: cell.imageReceived)
            } else {
                if cell.imageReceived != nil {
                    objCustomMediaViewer = CustomMediaViewer.init(controller: self, pathURL: URL.init(string:(messages?.localPath!)!)!, isForVideo: true)
                    objCustomMediaViewer?.showMediaOnTheView(theView: cell.imageReceived)
                }else {
                    print("Image Nil")
                }
            }
        } else {
            if let cell = tblChat.cellForRow(at: indexPath!) as? SentVideoCell {
                if messages?.localPath == nil || messages?.localPath == "" {
                    objCustomMediaViewer = CustomMediaViewer.init(controller: self, pathURL: URL.init(string:(messages?.videoUrl!)!)!, isForVideo: true)
                    objCustomMediaViewer?.showMediaOnTheView(theView: cell.imagSent)
                }else {
                    if cell.imagSent != nil {
                        objCustomMediaViewer = CustomMediaViewer.init(controller: self, pathURL: URL.init(string:(messages?.localPath!)!)!, isForVideo: true)
                        objCustomMediaViewer?.showMediaOnTheView(theView: cell.imagSent)
                    }else {
                        print("Image Nil")
                    }
                }
            }
        }
    }
    
    @objc func btnRetryTap(sender : UIButton) {
        let center: CGPoint = sender.center
        let rootViewPoint: CGPoint = sender.superview!.convert(center, to: tblChat)
        let indexPath: IndexPath? = tblChat.indexPathForRow(at: rootViewPoint)
        
        let messages: Messages? = messageFetch.object(at: indexPath!)
        if let cell = tblChat.cellForRow(at: indexPath!) as? SentImageCell {
            cell.progress.isHidden = false
        }
        
        //Upload image
        self.UploadImage(objMessages: messages!, indexPath: indexPath!)
    }
}

class ReceivedMessageCell: UITableViewCell {
    
    @IBOutlet weak var imgBg: UIImageView!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblName: UILabel!
}

class SentMessageCell: UITableViewCell {
    
    @IBOutlet weak var imgBg: UIImageView!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var imgViewReadStatus: UIImageView!
}

class SentImageCell: UITableViewCell {
    
    @IBOutlet weak var imgBg: UIImageView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var imagSent: UIImageView!
    @IBOutlet weak var imgViewReadStatus: UIImageView!
    @IBOutlet weak var progress: KDCircularProgress!
    @IBOutlet weak var btnRetry: UIButton!
    @IBOutlet weak var btnOpenImage: UIButton!
    
}

class ReceivedImageCell: UITableViewCell {
    
    @IBOutlet weak var imgBg: UIImageView!
    @IBOutlet weak var imageReceived: UIImageView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var progress: KDCircularProgress!
    @IBOutlet weak var btnDownload: UIButton!
    @IBOutlet weak var btnOpenImage: UIButton!
}

class SentVideoCell: UITableViewCell {
    
    @IBOutlet weak var imgBg: UIImageView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var imagSent: UIImageView!
    @IBOutlet weak var imgViewReadStatus: UIImageView!
    @IBOutlet weak var progress: KDCircularProgress!
    @IBOutlet weak var btnRetry: UIButton!
    @IBOutlet weak var btnPlay: UIButton!
}

class ReceivedVideoCell: UITableViewCell {
    
    @IBOutlet weak var imgBg: UIImageView!
    @IBOutlet weak var imageReceived: UIImageView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var progress: KDCircularProgress!
    @IBOutlet weak var btnDownload: UIButton!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnPlayOnline: UIButton!
}

extension ChatVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let count = self.messageFetch.sections?.count {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = messageFetch.sections?[section]
        return (sectionInfo?.numberOfObjects)!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let theSection = messageFetch.sections?[section]
        let viewHeader1 = UIView(frame: CGRect(x: 0, y: 10, width: UIScreen.main.bounds.size.width, height: 25))
        let lblDate = UILabel(frame: CGRect(x: (UIScreen.main.bounds.size.width - 80) / 2, y: 5, width: 80, height: 18))
        lblDate.backgroundColor = UIColor.lightGray
        lblDate.font = UIFont.systemFont(ofSize: 12)
        lblDate.layer.masksToBounds = true
        lblDate.layer.cornerRadius = 10.0
        lblDate.layer.borderColor = UIColor.white.cgColor
        lblDate.textColor = UIColor.white
        lblDate.textAlignment = .center
        viewHeader1.addSubview(lblDate)
        viewHeader1.backgroundColor = UIColor.clear
        
        //Section Name
        let date = Date(timeIntervalSince1970: Double(theSection!.name)!)
        lblDate.text =  date.toString(format: DateFormatType.serverDate)
        return viewHeader1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let theSection = messageFetch.sections?[section]
        
        //Section Name
        let date = Date(timeIntervalSince1970: Double(theSection!.name)!)
        return date.toString(format: DateFormatType.serverDate)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var returnCell: UITableViewCell = UITableViewCell()
        
        let messages: Messages? = messageFetch.object(at: indexPath)
        let isOutgoing: Bool? = (messages?.senderId == self.userID) ? false : true
        
        if messages?.messageType == TEXT {
            if !isOutgoing! {
                let cell:SentMessageCell = tableView.dequeueReusableCell(withIdentifier: "SentMessageCell", for: indexPath) as! SentMessageCell
                let strMessage = messages?.message
                cell.lblMessage.text = strMessage
                cell.lblTime.text = messages?.timeStamp?.toString(format: DateFormatType.isHoursMin)
                cell.imgBg.image = UIImage(named: "chat-sender-bg")?.stretchableImage(withLeftCapWidth: 15, topCapHeight: 15)
                if let isRead = messages?.isRead {
                    if isRead {
                        cell.imgViewReadStatus.image = UIImage.init(named: "double-check-read")
                    } else {
                        cell.imgViewReadStatus.image = UIImage.init(named: "Double_check")
                    }
                }
                
                returnCell = cell
            } else {
                let cell:ReceivedMessageCell = tableView.dequeueReusableCell(withIdentifier: "ReceivedMessageCell", for: indexPath) as! ReceivedMessageCell
                let strMessage = messages?.message
                cell.lblMessage.text = strMessage
                cell.lblName.text = messages?.senderName
                cell.lblTime.text =  messages?.timeStamp?.toString(format: DateFormatType.isHoursMin)
                cell.imgBg.image = UIImage(named: "chat-receiver-bg")?.stretchableImage(withLeftCapWidth: 30, topCapHeight: 20)
                
                returnCell = cell
            }
        } else if messages?.messageType == IMAGE {
            if !isOutgoing! {
                let cell:SentImageCell = tableView.dequeueReusableCell(withIdentifier: "SentImageCell", for: indexPath) as! SentImageCell
                cell.lblTime.text = messages?.timeStamp?.toString(format: DateFormatType.isHoursMin)
                cell.imgBg.image = UIImage(named: "imageChatSend")?.stretchableImage(withLeftCapWidth: 15, topCapHeight: 15)
                cell.btnRetry.addTarget(self, action: #selector(self.btnRetryTap), for: .touchUpInside)
                cell.btnRetry.isHidden = true
                
                cell.btnOpenImage.addTarget(self, action: #selector(self.btnOpenImageTap), for: .touchUpInside)
                cell.btnOpenImage.isHidden = true
                
                if (messages?.isUpload)! {
                    cell.progress.isHidden = true
                    cell.btnOpenImage.isHidden = false
                    if messages?.localPath == nil || messages?.localPath == ""{
                        cell.imagSent.sd_setImage(with: URL(string:(messages?.imageURL)!), placeholderImage: UIImage.init(named: "crown-logo"))
                    } else {
                        cell.imagSent.sd_setImage(with: URL(string:(messages?.localPath)!), placeholderImage: UIImage.init(named: "crown-logo"))
                    }
                    
                } else {
                    cell.progress.isHidden = false
                    cell.imagSent.sd_setImage(with: URL(string:(messages?.localPath)!), placeholderImage: UIImage.init(named: "crown-logo"))
                    self.UploadImage(objMessages: messages!, indexPath: indexPath)
                }
                returnCell = cell
            } else {
                let cell:ReceivedImageCell = tableView.dequeueReusableCell(withIdentifier: "ReceivedImageCell", for: indexPath) as! ReceivedImageCell
                cell.lblName.text = messages?.senderName
                cell.lblTime.text =  messages?.timeStamp?.toString(format: DateFormatType.isHoursMin)
                cell.imgBg.image = UIImage(named: "imageChatRecive")?.stretchableImage(withLeftCapWidth: 30, topCapHeight: 20)
                cell.progress.isHidden = true
                cell.btnDownload.addTarget(self, action: #selector(self.btnDownloadImageTap), for: .touchUpInside)
                cell.btnOpenImage.addTarget(self, action: #selector(self.btnOpenImageTap), for: .touchUpInside)
                cell.btnOpenImage.isHidden = true
                
                if (messages?.isDownload)! {
                    cell.btnDownload.isHidden = true
                    cell.btnOpenImage.isHidden = false
                    
                    let img = SDImageCache.shared().imageFromCache(forKey: messages?.imageURL)
                    cell.imageReceived.image = nil
                    if let image = img {
                        cell.imageReceived.image = image
                    } else {
                        cell.imageReceived.sd_setImage(with: URL(string:(messages?.imageThumbURL)!), placeholderImage:img)
                    }
                    
                } else {
                    cell.imageReceived.sd_setImage(with: URL(string:(messages?.imageThumbURL)!), placeholderImage: UIImage.init(named: "crown-logo"))
                    cell.btnDownload.isHidden = false
                }
                
                returnCell = cell
            }
        } else if messages?.messageType == VIDEO {
            if !isOutgoing! {
                let cell:SentVideoCell = tableView.dequeueReusableCell(withIdentifier: "SentVideoCell", for: indexPath) as! SentVideoCell
                cell.lblTime.text = messages?.timeStamp?.toString(format: DateFormatType.isHoursMin)
                cell.imgBg.image = UIImage(named: "imageChatSend")?.stretchableImage(withLeftCapWidth: 15, topCapHeight: 15)
                cell.btnRetry.addTarget(self, action: #selector(self.btnRetryTap), for: .touchUpInside)
                cell.btnRetry.isHidden = true
                cell.btnPlay.isHidden = true
                cell.btnPlay.addTarget(self, action: #selector(self.btnPlayTap), for: .touchUpInside)
                
                if (messages?.isUpload)! {
                    cell.progress.isHidden = true
                    cell.btnPlay.isHidden = false
                    if messages?.localPath == nil || messages?.localPath == "" {
                        cell.imagSent.sd_setImage(with: URL(string:(messages?.imageThumbURL)!), placeholderImage: UIImage.init(named: "crown-logo"))
                    }else {
                        cell.imagSent.image = FirebaseClass.shared.videoThumImage(localPath: (messages?.localPath)!)
                    }
                    
                }else{
                    cell.progress.isHidden = false
                    if messages?.localPath == nil ||  messages?.localPath == "" {
                        cell.imagSent.image = FirebaseClass.shared.videoThumImage(localPath: (messages?.videoUrl)!)
                    }else {
                        cell.imagSent.image = FirebaseClass.shared.videoThumImage(localPath: (messages?.localPath)!)
                        self.UploadVideo(objMessages: messages!, indexPath: indexPath)
                    }
                }
                returnCell = cell
            }else {
                let cell:ReceivedVideoCell = tableView.dequeueReusableCell(withIdentifier: "ReceivedVideoCell", for: indexPath) as! ReceivedVideoCell
                cell.lblName.text = messages?.senderName
                cell.lblTime.text =  messages?.timeStamp?.toString(format: DateFormatType.isHoursMin)
                cell.imgBg.image = UIImage(named: "imageChatRecive")?.stretchableImage(withLeftCapWidth: 30, topCapHeight: 20)
                cell.progress.isHidden = true
                cell.btnPlay.isHidden = true
                cell.btnPlay.addTarget(self, action: #selector(self.btnPlayTap), for: .touchUpInside)
                cell.btnDownload.addTarget(self, action: #selector(self.btnDownloadVideoTap), for: .touchUpInside)
                
                cell.btnPlayOnline.addTarget(self, action: #selector(self.btnPlayTap), for: .touchUpInside)
                cell.btnPlayOnline.isHidden = false
                
                if (messages?.isDownload)! {
                    cell.btnDownload.isHidden = true
                    cell.btnPlay.isHidden = false
                    cell.btnPlayOnline.isHidden = true
                    
                    if messages?.localPath == nil || messages?.localPath == "" {
                        cell.imageReceived.sd_setImage(with: URL(string:(messages?.imageThumbURL)!), placeholderImage: UIImage.init(named: "crown-logo"))
                    }else {
                        cell.imageReceived.image = FirebaseClass.shared.videoThumImage(localPath: (messages?.localPath)!)
                    }
                }else{
                    cell.imageReceived.sd_setImage(with: URL(string:(messages?.imageThumbURL)!), placeholderImage: UIImage.init(named: "crown-logo"))
                    cell.btnDownload.isHidden = false
                }
                
                returnCell = cell
            }
        }
        
        return returnCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("call")
    }
}

extension ChatVC: GrowingTextViewDelegate {
    
    func textViewDidChangeHeight(_ textView: GrowingTextView, height: CGFloat) {
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveLinear], animations: { () -> Void in
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func textViewGrowingDidChange(_ textView: GrowingTextView) {
        
        timerTyping.invalidate()
        //        timerTyping = Timer.scheduledTimer(timeInterval:2.0, target: self, selector: #selector(self.stopTyeping), userInfo: nil, repeats: false)
        //
        //        let objSendMessage = SendMessage()
        //        objSendMessage.messageType  = TYPING
        //        objSendMessage.typingText   = "\(String(describing: "Firstname")) is typing..."
        //        objSendMessage.isTyping     = true
        //        objSendMessage.groupMember  = self.arrayGroupMember
        //        objSendMessage.caseID       = self.CaseID
        //        FirebaseClass.shared.isTyping(objSendMessage: objSendMessage)
    }
    
    func textViewGrowingDidEndEditing(_ textView: GrowingTextView) {
        //self.stopTyeping()
    }
}

extension ChatVC: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if newIndexPath != nil {
                //Reset Unread counto
                //FirebaseClass.shared.reSetUnreadCount(opponent: self.CaseID)
                
                self.tblChat.reloadData()
                self.doScrollTableToBottom()
            }   
            break;
        case .delete:
            if let indexPath = indexPath {
                self.tblChat.deleteRows(at: [indexPath], with: .fade)
            }
            break;
        case .update:
            self.tblChat.reloadData()
            break;
        case .move:
            break;
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
    }
}

extension ChatVC: TypeingDelegate {
    
    @objc func isTypeing(typeingText: String) {
        //        self.lblTyping.text = typeingText
    }
}
extension ChatVC: Multimedia {
    
    @objc func uploadProgress(progress: Double, indexPath:IndexPath) {
        
        if let cell = tblChat.cellForRow(at: indexPath) as? SentImageCell {
            cell.progress.angle = progress
        }else {
            if let cell = tblChat.cellForRow(at: indexPath) as? SentVideoCell {
                cell.progress.angle = progress
            }
        }
    }
    
    @objc func uploadComplit(indexPath:IndexPath) {
        if let cell = tblChat.cellForRow(at: indexPath) as? SentImageCell {
            cell.progress.isHidden = true
        }else {
            if let cell = tblChat.cellForRow(at: indexPath) as? SentVideoCell {
                cell.progress.isHidden = true
            }
        }
    }
    
    @objc func uploadFailed(indexPath:IndexPath) {
        if let cell = tblChat.cellForRow(at: indexPath) as? SentImageCell {
            cell.progress.isHidden = true
            cell.btnRetry.isHidden = false
        }else {
            if let cell = tblChat.cellForRow(at: indexPath) as? SentVideoCell {
                cell.progress.isHidden = true
                cell.btnRetry.isHidden = false
            }
        }
    }
    
    //Download Methods
    @objc func downloadProgress(progress: Double, indexPath:IndexPath) {
        if let cell = tblChat.cellForRow(at: indexPath) as? ReceivedImageCell {
            cell.progress.angle = progress
        }else {
            if let cell = tblChat.cellForRow(at: indexPath) as? ReceivedVideoCell {
                cell.progress.isHidden = false
                cell.progress.angle = progress
                cell.btnDownload.isHidden = true
            }
        }
    }
    
    @objc func downloadComplit(indexPath:IndexPath, image:UIImage) {
        if let cell = tblChat.cellForRow(at: indexPath) as? ReceivedImageCell {
            cell.progress.isHidden = true
            cell.btnDownload.isHidden = true
            cell.imageReceived.image = image
        }else {
            if let cell = tblChat.cellForRow(at: indexPath) as? ReceivedVideoCell {
                cell.progress.isHidden = true
                cell.btnDownload.isHidden = true
                cell.imageReceived.image = image
            }
        }
    }
    
    @objc func downloadFaild(indexPath:IndexPath) {
        if let cell = tblChat.cellForRow(at: indexPath) as? ReceivedImageCell {
            cell.progress.isHidden = true
            cell.btnDownload.isHidden = false
        }else {
            if let cell = tblChat.cellForRow(at: indexPath) as? ReceivedVideoCell {
                cell.progress.isHidden = true
                cell.btnDownload.isHidden = false
            }
        }
    }
}
