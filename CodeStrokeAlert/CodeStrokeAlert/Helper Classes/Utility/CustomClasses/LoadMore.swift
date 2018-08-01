//
//  LoadMore.swift
//  Pulse Health
//
//  Created by Jayesh on 2/27/17.
//  Copyright © 2017 Samanvay. All rights reserved.
//

import UIKit

var lblFooterTitle = UILabel()
var footerView = UIView()

class LoadMore: NSObject {
    
    // MARK: - GLobal Loader (LoadMore)
    @objc class func showLoadingInTable(tbl: UITableView, text:String) {
        self.setLoadingFooter()
        lblFooterTitle.text = text
        tbl.tableFooterView = footerView
    }
    
    @objc class func hideLoadingInTable(tbl: UITableView) {
        tbl.tableFooterView = nil
    }
    
    @objc class func setLoadingFooter() {
        footerView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 44)
        lblFooterTitle.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 44)
        lblFooterTitle.textAlignment = .center
        lblFooterTitle.backgroundColor = UIColor.clear
        footerView.addSubview(lblFooterTitle)
        
        let activity = UIActivityIndicatorView()
        activity.frame = CGRect(x: 10, y: (footerView.frame.size.height - 20)/2, width: 20, height: 20)
        activity.color = UIColor.black
        activity.tintColor = UIColor.black
        activity.startAnimating()
        footerView.addSubview(activity)
        
    }
}
