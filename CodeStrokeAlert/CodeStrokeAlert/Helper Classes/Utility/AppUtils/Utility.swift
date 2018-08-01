//
//  Utility.swift
//  Airbuk
//
//  Created by Apple on 05/04/17.
//  Copyright © 2017 Openxcell. All rights reserved.
//

import UIKit
import FirebaseAnalytics

enum FirebaseEvent: String {
    
    case home = "Home"
    case buyerForm = "Buyer_form"
    case flyerForm = "Flyer_form"
    case calendar = "Calendar"
    case chat = "Chat"
    case chatList = "Chat_list"
    case notificationList = "Notification_list"
    case orderList = "Order_list"
    case buyerOrderConfirm = "Buyer_order_confirm"
    case profile = "Profile"
    case signup = "Signup"
    case payment = "Payment"
    case userLastRequest = "User_last_request"
}

class Utility: NSObject {
    
    @objc static let sharedInstance = Utility()
    
    @objc func RGBColor(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1.0)
    }
    
    @objc func convertDateToString (date: Date, originalFormat: String, convertFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = convertFormat
        let dateObj = dateFormatter.string(from: date)
        return dateObj
    }
    
    @objc func setStringForModel(strValue: Any?) -> String {
        
        if let id = strValue as? NSNull {
            print("Got a null id. Check it out: \(id)")
            return ""
        } else if let id = strValue as? NSNumber {
            let stringTemp = String(describing: id)
            if stringTemp.isValidString() {
                return stringTemp
            }
            else{
                return ""
            }
        } else if let id = strValue as? String {
            if id.isValidString() {
                return id
            } else{
                return ""
            }
        }
        return ""
    }
    
    @objc func setAttributedString(withCaption: String, captionFontSize: CGFloat, withTitle: String, titleFontSize: CGFloat) -> NSMutableAttributedString {
        let strReturn = NSMutableAttributedString()
        strReturn.append(withCaption.withAttributes([NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): Constants.kAppGreyColor, NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): UIFont(name: Constants.kFontRegular, size: 11.0)!]))
        let color = Constants.kAppBlueColor
        strReturn.append(withTitle.withAttributes([NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): color, NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): UIFont(name: Constants.kFontBold, size: 11.0)!]))
        return strReturn
    }
    
    @objc func setUserDefault(_ obj: Any, _ key: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(obj, forKey: key)
        userDefaults.synchronize()
    }
    
    @objc func getUserDefault(_ key: String) -> Any? {
        let userDefaults = UserDefaults.standard
        if let tmpValue = userDefaults.object(forKey: key) {
            return tmpValue
        } else {
            return nil
        }
    }
    
    @objc func getUserDefaultBool(_ key: String) -> Bool {
        let userDefaults = UserDefaults.standard
        if let flag = userDefaults.object(forKey: key) {
            return flag as! Bool
        }
        return false
    }
    
    func logFirebaseAnalyticScreenEvent(name: FirebaseEvent) {
    }
}
