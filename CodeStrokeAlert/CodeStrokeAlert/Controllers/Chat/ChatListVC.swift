//
//  ChatListVC.swift
//  CrownID
//
//  Created by Apple on 05/07/17.
//  Copyright © 2017 Samanvay. All rights reserved.
//

import UIKit
import CoreData

class ChatListVC: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var tblChatList: UITableView!
    
    @objc lazy var lastMessageFetch: NSFetchedResultsController<RecentChat> = {
        return CoreDataClass.shared.fetchedResultsControllerForRecentChat(delegate: self, opponentID: "")
    }()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Call user defind metheds
        self.setLayout()
        self.initObject()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc class func instance() -> ChatListVC {
        return mainStoryBoard.instantiateViewController(withIdentifier: "ChatListVC") as! ChatListVC
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnTapOnPlus(_ sender: UIBarButtonItem) {
        
        let objChatVC = ChatVC.instance()
        objChatVC.CaseID = "CD0001"
        objChatVC.arrayGroupMember = ["1","2","3"]
        objChatVC.userID = "2"
        self.navigationController?.pushViewController(objChatVC, animated: true)
    }
    
    // MARK:- Other Function -
    @objc func configure(_ cell: ChatListCell, at indexPath: IndexPath) {
        // Fetch Quote
        let messages: RecentChat? = lastMessageFetch.object(at: indexPath)
        
        // Configure Cell
        cell.imgViewUserPic.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "Demo10"))
        cell.lblTitle.text = messages?.groupID
        if (messages?.isTyping)! {
            cell.lblLastMsg.textColor = #colorLiteral(red: 0.4078193307, green: 0.4078193307, blue: 0.4078193307, alpha: 1)
            cell.lblLastMsg.text = messages?.typingText
        }else {
            cell.lblLastMsg.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cell.lblLastMsg.text = messages?.lastMessage
        }
        //cell.lblTime.text =  messages?.timeStamp?.toString(format: DateFormatType.isHoursMin)
        
        if messages?.unreadCount == 0 {
            cell.lblMessageCount.isHidden = true
        }else{
            cell.lblMessageCount.isHidden = false
            cell.lblMessageCount.text = String(describing: messages!.unreadCount)
        }
    }
    
    @objc func setLayout() {
    }
    
    @objc func initObject() {
    }
}

class ChatListCell: UITableViewCell {
    
    @IBOutlet weak var imgViewUserPic: UIImageView!
    @IBOutlet weak var lblMessageCount: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblLastMsg: UILabel!
}

extension ChatListVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = lastMessageFetch.sections?[section]
        return (sectionInfo?.numberOfObjects)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:ChatListCell = tableView.dequeueReusableCell(withIdentifier: "ChatListCell", for: indexPath) as! ChatListCell
        
        let messages: RecentChat? = lastMessageFetch.object(at: indexPath)
        cell.imgViewUserPic.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "Demo10"))
        cell.lblTitle.text = messages?.groupID
        if (messages?.isTyping)! {
            cell.lblLastMsg.text = messages?.typingText
        }else {
            cell.lblLastMsg.text = messages?.lastMessage
        }
        cell.lblLastMsg.text = messages?.lastMessage
        //cell.lblTime.text =  messages?.timeStamp?.toString(format: DateFormatType.isHoursMin)
        
        if messages?.unreadCount == 0 {
            cell.lblMessageCount.isHidden = true
        }else{
            cell.lblMessageCount.isHidden = false
            cell.lblMessageCount.text = String(describing: messages!.unreadCount)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let messages: RecentChat? = lastMessageFetch.object(at: indexPath)
        
        let objChatVC = ChatVC.instance()
        objChatVC.CaseID = messages?.groupID
        let arrgroupMember = messages?.groupMember?.components(separatedBy: ",")
        objChatVC.arrayGroupMember = arrgroupMember!
        objChatVC.userID = utility.getUserDefault(kUserID) as! String
        self.navigationController?.pushViewController(objChatVC, animated: true)
    }
}

extension ChatListVC: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tblChatList.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tblChatList.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                self.tblChatList.insertRows(at: [indexPath], with: .fade)
            }
            break
        case .delete:
            if let indexPath = indexPath {
                self.tblChatList.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case .update:
            if let indexPath = indexPath, let cell = tblChatList.cellForRow(at: indexPath) as? ChatListCell {
                configure(cell, at: indexPath)
            }
            break
        case .move:
            if let indexPath = indexPath {
                self.tblChatList.deleteRows(at: [indexPath], with: .fade)
            }
            
            if let newIndexPath = newIndexPath {
                self.tblChatList.insertRows(at: [newIndexPath], with: .fade)
            }
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
    }
}
