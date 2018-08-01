//
//  Constants.swift
//
//
//  Created by Apple on 05/01/17.
//  Copyright © 2017 Openxcell. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

let utility                             = Utility.sharedInstance
let screenSize                          = UIScreen.main.bounds
let currentLanguage                     = Locale.current.languageCode

//Constants
let kApiToken                           = "api_token"
let kUserID                             = "User_ID"
let kClinicID                           = "clinic_id"
let kUserName                           = "UserName"
let kUserPassword                       = "Password"
let kDeviceToken                        = "device_token"

struct Constants {
    
    static let kAppName                 = "Demo"
    static let kFontRegular             = "Helvetica"
    static let kFontBold                = "Helvetica-Bold"
    static let kFontLight               = "Helvetica-Light"
    
    static let kFontHelveticaNeueRegular    = "HelveticaNeue"
    static let kFontHelveticaNeueBold       = "HelveticaNeue-Bold"
    static let kFontHelveticaNeueLight      = "HelveticaNeue-Light"
    static let kFontHelveticaNeueMedium     = "HelveticaNeue-Medium"
    
    static let kEmailRegEx              = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    static let kDeviceType              = "ios"
    static let kItunesUrl               = "itms-apps://itunes.apple.com/app/id1241610910"
    
    static let kAppMainColor            = #colorLiteral(red: 0, green: 0.2749354839, blue: 0.3583019674, alpha: 1)
    static let kAppBlueColor            = utility.RGBColor(r: 3, g: 54, b: 73)
    static let kAppTextGreyColor        = utility.RGBColor(r: 60, g: 60, b: 60)
    static let kAppGreyColor            = utility.RGBColor(r: 67, g: 74, b: 84)
    static let kAppYellowColor          = utility.RGBColor(r: 236, g: 166, b: 44)
    static let kAppTabDisableColor      = utility.RGBColor(r: 192, g: 203, b: 215)
    static let kAppPlaceHolderColor     = utility.RGBColor(r: 170, g: 170, b: 170)
    
    static let kAppTextDarkGreyColor    = utility.RGBColor(r: 23, g: 23, b: 23)
    static let kAppTextLightGreyColor   = utility.RGBColor(r: 131, g: 131, b: 131)
}
