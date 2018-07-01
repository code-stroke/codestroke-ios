//
//  Constans.swift
//  36five
//
//  Created by Jayesh on 18/11/15.
//  Copyright © 2015 Samanvay. All rights reserved.
//

import Foundation
import UIKit

#if os(iOS)
    import CoreTelephony
#endif

let IS_IPAD = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad
let IS_IPHONE = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone
let IS_RETINA = UIScreen.main.scale >= 2.0
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let SCREEN_MAX_LENGTH = max(SCREEN_WIDTH, SCREEN_HEIGHT)
let SCREEN_MIN_LENGTH = min(SCREEN_WIDTH, SCREEN_HEIGHT)

let IS_IPHONE_4_OR_LESS = IS_IPHONE && SCREEN_MAX_LENGTH < 568.0
let IS_IPHONE_5 = IS_IPHONE && SCREEN_MAX_LENGTH == 568.0
let IS_IPHONE_6 = IS_IPHONE && SCREEN_MAX_LENGTH == 667.0
let IS_IPHONE_6P = IS_IPHONE && SCREEN_MAX_LENGTH == 736.0
let IS_IPHONE_X = IS_IPHONE && SCREEN_MAX_LENGTH == 812.0

struct Platform {
    
    static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
}

public extension UIDevice {
    public var type: Model {
        var systemInfo = utsname()
        uname(&systemInfo)
        let modelCode = withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                ptr in String.init(validatingUTF8: ptr)
                
            }
        }
        var modelMap : [ String : Model ] = [
            "i386"      : .simulator,
            "x86_64"    : .simulator,
            "iPod1,1"   : .iPod1,
            "iPod2,1"   : .iPod2,
            "iPod3,1"   : .iPod3,
            "iPod4,1"   : .iPod4,
            "iPod5,1"   : .iPod5,
            "iPad2,1"   : .iPad2,
            "iPad2,2"   : .iPad2,
            "iPad2,3"   : .iPad2,
            "iPad2,4"   : .iPad2,
            "iPad2,5"   : .iPadMini1,
            "iPad2,6"   : .iPadMini1,
            "iPad2,7"   : .iPadMini1,
            "iPhone3,1" : .iPhone4,
            "iPhone3,2" : .iPhone4,
            "iPhone3,3" : .iPhone4,
            "iPhone4,1" : .iPhone4S,
            "iPhone5,1" : .iPhone5,
            "iPhone5,2" : .iPhone5,
            "iPhone5,3" : .iPhone5C,
            "iPhone5,4" : .iPhone5C,
            "iPad3,1"   : .iPad3,
            "iPad3,2"   : .iPad3,
            "iPad3,3"   : .iPad3,
            "iPad3,4"   : .iPad4,
            "iPad3,5"   : .iPad4,
            "iPad3,6"   : .iPad4,
            "iPhone6,1" : .iPhone5S,
            "iPhone6,2" : .iPhone5S,
            "iPad4,2"   : .iPadAir1,
            "iPad5,4"   : .iPadAir2,
            "iPad4,4"   : .iPadMini2,
            "iPad4,5"   : .iPadMini2,
            "iPad4,6"   : .iPadMini2,
            "iPad4,7"   : .iPadMini3,
            "iPad4,8"   : .iPadMini3,
            "iPad4,9"   : .iPadMini3,
            "iPad6,3"   : .iPadPro9_7,
            "iPad6,4"   : .iPadPro9_7_cell,
            "iPad6,12"  : .iPad5,
            "iPad6,7"   : .iPadPro12_9,
            "iPad6,8"   : .iPadPro12_9_cell,
            "iPad7,1"   : .iPadPro2_12_9,
            "iPad7,2"   : .iPadPro2_12_9_cell,
            "iPhone7,1" : .iPhone6plus,
            "iPhone7,2" : .iPhone6,
            "iPhone8,1" : .iPhone6S,
            "iPhone8,2" : .iPhone6Splus,
            "iPhone8,4" : .iPhoneSE,
            "iPhone9,1" : .iPhone7,
            "iPhone9,2" : .iPhone7plus,
            "iPhone9,3" : .iPhone7,
            "iPhone9,4" : .iPhone7plus,
            "iPhone10,1" : .iPhone8,
            "iPhone10,2" : .iPhone8plus,
            "iPhone10,3" : .iPhoneX,
            "iPhone10,4" : .iPhone8,
            "iPhone10,5" : .iPhone8plus,
            "iPhone10,6" : .iPhoneX
        ]
        
        if let model = modelMap[String.init(validatingUTF8: modelCode!)!] {
            if model == .simulator {
                if let simModelCode = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
                    if let simModel = modelMap[String.init(validatingUTF8: simModelCode)!] {
                        return simModel
                    }
                }
            }
            return model
        }
        return Model.unrecognized
    }
}

public enum Model : String {
    case simulator     = "simulator/sandbox",
    iPod1              = "iPod 1",
    iPod2              = "iPod 2",
    iPod3              = "iPod 3",
    iPod4              = "iPod 4",
    iPod5              = "iPod 5",
    iPad2              = "iPad 2",
    iPad3              = "iPad 3",
    iPad4              = "iPad 4",
    iPad5              = "iPad 5",
    iPhone4            = "iPhone 4",
    iPhone4S           = "iPhone 4S",
    iPhone5            = "iPhone 5",
    iPhone5S           = "iPhone 5S",
    iPhone5C           = "iPhone 5C",
    iPadMini1          = "iPad Mini 1",
    iPadMini2          = "iPad Mini 2",
    iPadMini3          = "iPad Mini 3",
    iPadAir1           = "iPad Air 1",
    iPadAir2           = "iPad Air 2",
    iPadPro9_7         = "iPad Pro 9.7\"",
    iPadPro9_7_cell    = "iPad Pro 9.7\" cellular",
    iPadPro12_9        = "iPad Pro 12.9\"",
    iPadPro12_9_cell   = "iPad Pro 12.9\" cellular",
    iPadPro2_12_9      = "iPad Pro 2 12.9\"",
    iPadPro2_12_9_cell = "iPad Pro 2 12.9\" cellular",
    iPhone6            = "iPhone 6",
    iPhone6plus        = "iPhone 6 Plus",
    iPhone6S           = "iPhone 6S",
    iPhone6Splus       = "iPhone 6S Plus",
    iPhoneSE           = "iPhone SE",
    iPhone7            = "iPhone 7",
    iPhone7plus        = "iPhone 7 Plus",
    iPhone8            = "iPhone 8",
    iPhone8plus        = "iPhone 8 Plus",
    iPhoneX            = "iPhone X",
    unrecognized       = "?unrecognized?"
}

struct AppConstants {
    
    static var userDeviceToken: String?
    static let appName = "Code Stroke Alert"
    static let normalFormat = "yyyy-MM-dd"
    static let appDelegate = UIApplication.shared.delegate as? AppDelegate
    typealias appDict = Dictionary<String,Any>
}

typealias blockComplition = () -> ()

func showAlert(_ message: String) {
    
    if message.length > 0 {
        DispatchQueue.main.async(execute: {
            appDelegate.window!.makeToast(message: message , duration: 2, position: HRToastPositionCenter as AnyObject )
        })
    }
}

func showSpecialAlert(_ message: String) {
    
    if message.length > 0 {
        DispatchQueue.main.async(execute: {
            appDelegate.window!.makeToast(message: message , duration: 2, position: HRToastPositionTop as AnyObject )
        })
    }
}

func setDeviceToken(_ token : String) {
    
    let defaults: UserDefaults = UserDefaults.standard
    let data: Data = NSKeyedArchiver.archivedData(withRootObject: token)
    defaults.set(data, forKey: "deviceToken")
    defaults.synchronize()
}

func removeDeviceToken() {
    
    let defaults: UserDefaults = UserDefaults.standard
    defaults.removeObject(forKey: "deviceToken")
    defaults.synchronize()
}

func getDeviceToken() -> String {
    
    let defaults: UserDefaults = UserDefaults.standard
    let data = defaults.object(forKey: "deviceToken") as? Data
    if data != nil {
        if let str = NSKeyedUnarchiver.unarchiveObject(with: data!) as? String {
            return str
        }
        else {
            return "11"
        }
    }
    return "11"
}

func topMostController() -> UIViewController {
    
    var top = UIApplication.shared.keyWindow?.rootViewController
    
    while ((top?.presentedViewController) != nil) {
        top = top?.presentedViewController
    }
    
    return top!
}

func setGredianInImage(imgView : UIView,frame: CGRect, startX:Int, startY:Int, endX:Int, endY:Int) {
    
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = frame
    gradientLayer.colors = [ UIColor(red: 34/255, green: 49/255, blue: 63/255, alpha: 0.0).cgColor, UIColor(red: 34/255, green: 49/255, blue: 63/255, alpha: 0.2).cgColor, UIColor(red: 34/255, green: 49/255, blue: 63/255, alpha: 0.7).cgColor, UIColor(red: 34/255, green: 49/255, blue: 63/255, alpha: 0.8).cgColor]
    gradientLayer.startPoint = CGPoint(x: startX, y: startY)
    gradientLayer.endPoint = CGPoint(x: endX, y: endY)
    imgView.layer.addSublayer(gradientLayer)
}
