import Foundation
import UIKit
import EVReflection
import Alamofire

let kUserInfo = "SavedUserInfo"
let kCases = "SavedCaseInfo"

class UserInfo: EVObject {
    
    var shift_id: Int                               = 0
    var status: String                              = ""
    var message: String                             = ""
    var user_id: String                             = ""
    var name: String                                = ""
    var family: String                              = ""
    var email: String                               = ""
    var team: String                                = ""
    var birthday: String                            = ""
    var gender: String                              = ""
    var mobile: String                              = ""
    var device_token: String                        = ""
    var token_36five: String                        = ""
    var token_state: String                         = ""
    var token_message: String                       = ""
    var company_id: String                          = ""
    
    func save() {
        
        let defaults: UserDefaults = UserDefaults.standard
        let data: NSData = NSKeyedArchiver.archivedData(withRootObject: self) as NSData
        defaults.set(data, forKey: kUserInfo)
        defaults.synchronize()
    }
    
    class func savedUser() -> UserInfo? {
        
        let defaults: UserDefaults = UserDefaults.standard
        let data = defaults.object(forKey: kUserInfo) as? NSData
        
        if data != nil {
            
            if let userinfo = NSKeyedUnarchiver.unarchiveObject(with: data! as Data) as? UserInfo {
                return userinfo
            }
            else {
                return nil
            }
        }
        return nil
    }
    
    class func clearUser() {
        
        let defaults: UserDefaults = UserDefaults.standard
        defaults.removeObject(forKey: kUserInfo)
        defaults.synchronize()
    }
}

class CaseModel: EVObject {
    
    var case_id: Int                    = 0
    var success: Bool                   = false
}

class DefaultModel: EVObject {
    
    var message: String                 = ""
    var success: Bool                   = false
}

class CaseListModel: EVObject {
    
    var result: [CaseList]?
    var message: String                 = ""
    var success: Bool                   = false
}

class CaseList: EVObject {
    
    var address: String                 = ""
    var case_id: Int                    = 0
    var dob: String                     = ""
    var first_name: String              = ""
    var gender: String                  = ""
    var last_name: String               = ""
    var last_well: String               = ""
    var medicare_no: String             = ""
    var nok: String                     = ""
    var nok_phone: String               = ""
    var status: String                  = ""
    var status_time: String             = ""
    
    func save() {
        
        let defaults: UserDefaults = UserDefaults.standard
        let data: NSData = NSKeyedArchiver.archivedData(withRootObject: self) as NSData
        defaults.set(data, forKey: kCases)
        defaults.synchronize()
    }
    
    class func savedUser() -> CaseList? {
        
        let defaults: UserDefaults = UserDefaults.standard
        let data = defaults.object(forKey: kCases) as? NSData
        
        if data != nil {
            
            if let userinfo = NSKeyedUnarchiver.unarchiveObject(with: data! as Data) as? CaseList {
                return userinfo
            }
            else {
                return nil
            }
        }
        return nil
    }
    
    class func clearUser() {
        
        let defaults: UserDefaults = UserDefaults.standard
        defaults.removeObject(forKey: kCases)
        defaults.synchronize()
    }
}

class EDModel: EVObject {
    
    var result: [EDData]?
    var message: String                 = ""
    var success: Bool                   = false
}

class EDData: EVObject {
    
    var case_id: Int                    = 0
    var location: String                = ""
    var primary_survey: Int             = 0
    var registered: Int                 = 0
    var triaged: Int                    = 0
}

class CaseHistoryModel: EVObject {
    
    var result: [CaseHistoryData]?
    var message: String                 = ""
    var success: Bool                   = false
}

class CaseHistoryData: EVObject {
    
    var anticoags: Bool                 = false
    var anticoags_last_dose: String     = ""
    var case_id: Int                    = 0
    var hopc: String                    = ""
    var last_meal: String               = ""
    var meds: String                    = ""
    var pmhx: String                    = ""
    var weight: Float                   = 0.0
}
