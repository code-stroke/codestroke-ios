//
//  ThemeColor.swift
//  36five
//
//  Created by Jayesh on 23/11/15.
//  Copyright © 2015 Samanvay. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD
import Alamofire

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

public func Log<T>(_ object: T?, filename: String = #file, line: Int = #line, funcname: String = #function) {
    #if DEBUG
    guard let object = object else { return }
    print("***** \(Date()) \(filename.components(separatedBy: "/").last ?? "") (line: \(line)) :: \(funcname) :: \(object)")
    #endif
}

public func WS_GetVersion() {
    
    let url = "http://codestrokezero.pythonanywhere.com/version/"
    print("\(url)")

    Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<VersionInfo>) in

        if (response.result.value != nil) {
            print(response.result.value!)
            
            if response.result.value!.success {
                
                if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                    
                    if version != response.result.value!.version {
                        
                        let alertController = UIAlertController(title: AppConstants.appName, message: "Your version of Code Stroke Alert is out of date. Please upgrade to the latest version to continue.", preferredStyle:UIAlertControllerStyle.alert)
                        
                        alertController.addAction(UIAlertAction(title: "Update", style: UIAlertActionStyle.default)
                        { action -> Void in
                            openAppStore()
                        })
                        
                        DispatchQueue.main.async {
                            appDelegate.window?.rootViewController!.present(alertController, animated: true, completion: nil) // present the alert
                        }
                    }
                }
            }
        } else {
            
        }
    }
}

func openAppStore() {
    
    if let url = URL(string: "itms-apps://itunes.apple.com/app/id1434636135"),

        UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url, options: [:]) { (opened) in
            
            if(opened) {
                print("App Store Opened")
            }
        }
    } else {
        print("Can't Open URL on Simulator")
    }
}

extension Data {
    public var hexString: String {
        return map { String(format: "%02.2hhx", arguments: [$0]) }.joined()
    }
}

extension String {
    func isContaint(str : String) -> Bool{
        
        if self.lowercased().range(of: str.lowercased()) != nil {
            return true
        }
        return false
    }
}

extension UIColor {
    
    class func navigationBarColor() -> UIColor {
        return UIColor(hex: 0x00AEEF)
    }
    
    class func offWhiteColor() -> UIColor {
        return UIColor(hex : 0xE8E8E8)
    }
    
    class func blackGrayColor() -> UIColor {
        return UIColor(hex : 0x282828)
    }
    
    class func lightBlackColor() -> UIColor {
        return UIColor(hex : 0x9B9B9B)
    }
    
    class func trackRedColor() -> UIColor {
        return UIColor(hex : 0xED1D25)
    }
    
    
    convenience init(hex:Int, alpha:CGFloat = 1.0) {
        self.init(
            red:   CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8)  / 255.0,
            blue:  CGFloat((hex & 0x0000FF) >> 0)  / 255.0,
            alpha: alpha
        )
    }
    
}

extension UIView {
    
    func showHud(_ message: String) {
        SVProgressHUD.show()
        self.isUserInteractionEnabled = false
    }
    
    func hideHUD() {
        SVProgressHUD.dismiss()
        self.isUserInteractionEnabled = true
    }
    
    func dropShadow(color: UIColor, viewShadow: UIView) {
        
        viewShadow.center = self.center
        viewShadow.backgroundColor = UIColor.white
        viewShadow.layer.shadowColor = color.cgColor
        viewShadow.layer.shadowOpacity = 1
        viewShadow.layer.shadowOffset = CGSize.zero
        viewShadow.layer.shadowRadius = 2
        viewShadow.layer.cornerRadius = 5.0
    }
    
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        
        self.layer.add(animation, forKey: nil)
    }
}

extension UIApplication {
    
    class func topViewController(_ viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewController(presented)
        }
        
        return viewController
    }
}

extension UIViewController {
    
    var alertController: UIAlertController? {
        guard let alert = UIApplication.topViewController() as? UIAlertController else { return nil }
        return alert
    }
}

extension UITextField {
    
    func setLeftPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

extension UIViewController {
    
    func showHud(_ message: String) {
        SVProgressHUD.show()
    }
    
    func hideHUD() {
        SVProgressHUD.dismiss()
    }
    
    func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-zA-Z\\s\\x{0600}-\\x{06FF}])(?=.*[0-9\\u06F0-\\u06F9]).{6,}$")
        return passwordTest.evaluate(with: password)
    }
    
    func setView(view: UIView, hidden: Bool) {
        
        UIView.transition(with: view, duration: 0.1, options: .transitionCrossDissolve, animations: { () -> Void in
            view.isHidden = hidden
        }, completion: nil)
    }
    
    func createSessionForApp(userId: String?) {
        
        guard let user_Id = userId else {
            
            print("not found user iD")
            return
        }
        
        UserDefaults.standard.set(user_Id, forKey: "userID")
        UserDefaults.standard.set(true, forKey: "loginSession")
    }
    
    func getCurrentLocale() -> Locale {
        return Locale(identifier: "fa_IR")
    }
    
    func alignmentOfTextField(islanguage:Bool = true) -> NSTextAlignment {
        return islanguage == true ? NSTextAlignment.right : NSTextAlignment.left
    }
    
    func calcAge(birthday: String) -> Int {
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy/MM/dd"
        let birthdayDate = dateFormater.date(from: birthday)
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
        let now = Date()
        let calcAge = calendar.components(.year, from: birthdayDate!, to: now, options: [])
        let age = calcAge.year
        return age!
    }
    
    func localToUTC(date:String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.calendar = NSCalendar.current
        dateFormatter.timeZone = TimeZone.current
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "H:mm:ss"
        return dateFormatter.string(from: dt!)
    }
    
    func UTCToLocal(date:String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "H:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "h:mm a"
        
        return dateFormatter.string(from: dt!)
    }
    
    func getNumberOfSeconds(startDate: Date, endDate: Date) -> Int {
        
        let calendar = NSCalendar.current
        let unitFlags = Set<Calendar.Component>([ .second])
        let datecomponenets = calendar.dateComponents(unitFlags, from: startDate, to: endDate)
        let seconds = datecomponenets.second
        return abs(seconds!)
    }
    
    func stringFromTimeInterval(interval: TimeInterval) -> String {
        
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    func convertEngNumToPersianNum(num: String) -> String {
        
        let arr = num.components(separatedBy: ":")
        var faNumber = ""
        for (_,num1) in arr.enumerated() {
            
            let number = NSNumber(value: Int(num1)!)
            let format = NumberFormatter()
            format.locale = Locale(identifier: "fa_IR")
            if faNumber != "" {
                faNumber.append(":")
                faNumber.append(format.string(from: number)!)
            } else {
                faNumber = format.string(from: number)!
            }
        }
        
        return faNumber
    }
    
    func buttonCenter(scrollView: UIScrollView, button: UIButton) {
        
        let scrollWidth = scrollView.frame.width
        let scrollHeight = scrollView.frame.height
        let desiredXCoor = button.frame.origin.x - ((scrollWidth / 2) - (button.frame.width / 2) )
        let rect = CGRect(x: desiredXCoor, y: 0, width: scrollWidth, height: scrollHeight)
        scrollView.scrollRectToVisible(rect, animated: true)
    }
}

extension DateFormatter {
    
    func setLocal() {
        self.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        self.locale = Locale.init(identifier: "en_US_POSIX")
    }
}

extension UIDatePicker {
    
    public var clampedDate: Date {
        let referenceTimeInterval = self.date.timeIntervalSinceReferenceDate
        let remainingSeconds = referenceTimeInterval.truncatingRemainder(dividingBy: TimeInterval(minuteInterval*60))
        let timeRoundedToInterval = referenceTimeInterval - remainingSeconds
        return Date(timeIntervalSinceReferenceDate: timeRoundedToInterval)
    }
}

extension String {
    
    func numberOfSeconds() -> Int {
        var components: Array = self.components(separatedBy: ":")
        if components.count == 2 {
            let hours = Int(components[0]) ?? 0
            let minutes = Int(components[1]) ?? 0
            return (hours * 3600) + (minutes * 60)
        } else {
            let hours = Int(components[0]) ?? 0
            let minutes = Int(components[1]) ?? 0
            let seconds = Int(components[2]) ?? 0
            return (hours * 3600) + (minutes * 60) + seconds
        }
    }
    
    func date(format: String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        let date = dateFormatter.date(from: self)
        return date
    }
}

extension Date {
    
    var ticks: UInt64 {
        return UInt64((self.timeIntervalSince1970 + 62_135_596_800) * 10_000_000)
    }
    
    var startOfDay: Date {
        
        let calendar = Calendar.current
        let unitFlags = Set<Calendar.Component>([.year, .month, .day])
        let components = calendar.dateComponents(unitFlags, from: self)
        return calendar.date(from: components)!
    }
    
    var endOfDay: Date {
        
        var components = DateComponents()
        components.day = 1
        let date = Calendar.current.date(byAdding: components, to: self.startOfDay)
        return (date?.addingTimeInterval(-1))!
    }
    
    var yesterday: Date {
        let calendar = Calendar.current
        return (calendar as NSCalendar).date(byAdding: .day, value: -1, to: Date(), options: .matchStrictly)!.dateWithNoTime()
    }
    
    public func dateWithNoTime()->Date{
        let calendar = Calendar.current
        let date = calendar.startOfDay(for: self)
        return date
    }
    
    func isGreaterThanDate(_ dateToCompare: Date) -> Bool {
        
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedDescending {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
    
    func isLessThanDate(_ dateToCompare: Date) -> Bool {
        
        //Declare Variables
        var isLess = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedAscending {
            isLess = true
        }
        
        //Return Result
        return isLess
    }
    
    func equalToDate(_ dateToCompare: Date) -> Bool {
        
        //Declare Variables
        var isEqualTo = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedSame {
            isEqualTo = true
        }
        
        //Return Result
        return isEqualTo
    }
}

extension UISearchBar {
    
    func setTextColor(color: UIColor) {
        let svs = subviews.flatMap { $0.subviews }
        guard let tf = (svs.filter { $0 is UITextField }).first as? UITextField else { return }
        tf.textColor = color
    }
}


extension Sequence where Iterator.Element == (key: String, value: Any) {
    var jsonString : String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(data: jsonData, encoding: .utf8)!
        }
        catch {
            return ""
        }
    }
}
extension String {
    var jsonObject : [String: Any]? {
        if let data = self.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]
                
            } catch {
                
            }
        }
        return nil
    }
}

extension UIImageView {
    
    func makeBlurImage(targetImageView:UIImageView?) {
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = targetImageView!.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        targetImageView?.addSubview(blurEffectView)
    }
}

//MARK:- Image Orientation fix

extension UIImage {
    
    func fixOrientation() -> UIImage {
        
        // No-op if the orientation is already correct
        if ( self.imageOrientation == UIImageOrientation.up ) {
            return self;
        }
        
        // We need to calculate the proper transformation to make the image upright.
        // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        if ( self.imageOrientation == UIImageOrientation.down || self.imageOrientation == UIImageOrientation.downMirrored ) {
            transform = transform.translatedBy(x: self.size.width, y: self.size.height)
            transform = transform.rotated(by: CGFloat(Double.pi))
        }
        
        if ( self.imageOrientation == UIImageOrientation.left || self.imageOrientation == UIImageOrientation.leftMirrored ) {
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.rotated(by: CGFloat(Double.pi))
        }
        
        if ( self.imageOrientation == UIImageOrientation.right || self.imageOrientation == UIImageOrientation.rightMirrored ) {
            transform = transform.translatedBy(x: 0, y: self.size.height);
            transform = transform.rotated(by: CGFloat(-Double.pi));
        }
        
        if ( self.imageOrientation == UIImageOrientation.upMirrored || self.imageOrientation == UIImageOrientation.downMirrored ) {
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        }
        
        if ( self.imageOrientation == UIImageOrientation.leftMirrored || self.imageOrientation == UIImageOrientation.rightMirrored ) {
            transform = transform.translatedBy(x: self.size.height, y: 0);
            transform = transform.scaledBy(x: -1, y: 1);
        }
        
        // Now we draw the underlying CGImage into a new context, applying the transform
        // calculated above.
        let ctx: CGContext = CGContext(data: nil, width: Int(self.size.width), height: Int(self.size.height),
                                       bitsPerComponent: self.cgImage!.bitsPerComponent, bytesPerRow: 0,
                                       space: self.cgImage!.colorSpace!,
                                       bitmapInfo: self.cgImage!.bitmapInfo.rawValue)!;
        
        ctx.concatenate(transform)
        
        if ( self.imageOrientation == UIImageOrientation.left ||
            self.imageOrientation == UIImageOrientation.leftMirrored ||
            self.imageOrientation == UIImageOrientation.right ||
            self.imageOrientation == UIImageOrientation.rightMirrored ) {
            ctx.draw(self.cgImage!, in: CGRect(x: 0,y: 0,width: self.size.height,height: self.size.width))
        } else {
            ctx.draw(self.cgImage!, in: CGRect(x: 0,y: 0,width: self.size.width,height: self.size.height))
        }
        
        // And now we just create a new UIImage from the drawing context and return it
        return UIImage(cgImage: ctx.makeImage()!)
    }
}

