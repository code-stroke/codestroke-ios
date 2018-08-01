//
//  LanguageManager.swift
//  Where
//
//  Created by Ketan on 4/10/17.
//  Copyright © 2017 kETANpATEL. All rights reserved.
//

import UIKit

class LanguageManager: NSObject {

    static let sharedInstance = LanguageManager()
    
    func getTranslationForKey(_ key: String, value:String) -> String {
        let languageCode: String? = UserDefaults.standard.string(forKey: "APP_CURRENT_LANGUAGE")?.lowercased()
        let bundlePath: String? = Bundle.main.path(forResource: languageCode, ofType: "lproj")
        let languageBundle = Bundle(path: bundlePath!)
        var translatedString = languageBundle?.localizedString(forKey: key, value: value, table: nil)
        
        if (translatedString?.characters.count ?? 0) < 1 {
            translatedString = NSLocalizedString(key, comment: value)
        }
        return translatedString!
    }
    
    func setLanuageAs(lan: String) {
        
        UserDefaults.standard.setValue(lan.lowercased(), forKey: "APP_CURRENT_LANGUAGE")
        UserDefaults.standard.synchronize()
    }
    
    func getCurrentLanuage() -> String {
        
        let languageCode: String? = UserDefaults.standard.string(forKey: "APP_CURRENT_LANGUAGE")?.lowercased()
        
        if (languageCode != nil) {
            return languageCode!
        }
        else {
            return ""
        }
    }
}
