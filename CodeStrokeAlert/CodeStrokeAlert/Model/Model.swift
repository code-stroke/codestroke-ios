import Foundation
import UIKit
import EVReflection
import Alamofire

let kUserInfo = "SavedUserInfo"
let kUserSecurity = "SavedUserSecurity"

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
