//
//  ValidationFile.swift
//  Pods
//
//  Created by Jayesh on 05/05/16.
//
//

import Foundation

public func checkInternet() ->Bool {
    
    let status = LetsReach().connectionStatus()
    
    switch status {
    case .unknown, .offline:
        return false
    case .online(.wwan), .online(.wiFi):
        return true
    }
}

//MARK: Validation Function

//MARK: Device Token Methods

func setDeviceToken(_ token : String) {
    
    let defaults: UserDefaults = UserDefaults.standard
    let data: Data = NSKeyedArchiver.archivedData(withRootObject: token)
    defaults.set(data, forKey: "deviceToken")
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
            return "Simulator"
        }
    }
    return "Simulator"
}

func removeDeviceToken() {
    
    let defaults: UserDefaults = UserDefaults.standard
    defaults.removeObject(forKey: "deviceToken")
    defaults.synchronize()
}

public func isEmptyString(_ text : String) -> Bool {
    
    if text.trim == "" || text.trim.isEmpty {
        return true
    } else {
        return false
    }
}

public func validatePhoneNumber(value: String) -> Bool {
    
    let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
    let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
    let result =  phoneTest.evaluate(with: value)
    return result
}

public func validateEmailWithString(_ Email: String) -> Bool {
    do {
        let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}", options: .caseInsensitive)
        return !(regex.firstMatch(in: Email, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, Email.characters.count)) != nil)
    } catch {
        return true
    }
}

public func validePassword(_ text : String) ->Bool {
    
    if text.length < 6 || text.length > 16 {
        return true
    } else {
        return false
    }
}
