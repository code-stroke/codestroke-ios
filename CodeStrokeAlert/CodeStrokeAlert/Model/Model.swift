import Foundation
import UIKit
import EVReflection
import Alamofire

let kUserInfo = "SavedUserInfo"
let kCases = "SavedCaseInfo"
let kUserIds = "UserIDs"

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

class UserData: EVObject {
    
    var status: Int                     = 0
    var message: String                 = ""
    var login_user_id: Int              = 0
    var data: [AllUserIds]?
    
    func save() {
        
        let defaults: UserDefaults = UserDefaults.standard
        let data: NSData = NSKeyedArchiver.archivedData(withRootObject: self) as NSData
        defaults.set(data, forKey: kUserIds)
        defaults.synchronize()
    }
    
    class func savedUser() -> UserData? {
        
        let defaults: UserDefaults = UserDefaults.standard
        let data = defaults.object(forKey: kUserIds) as? NSData
        
        if data != nil {
            
            if let userinfo = NSKeyedUnarchiver.unarchiveObject(with: data! as Data) as? UserData {
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
        defaults.removeObject(forKey: kUserIds)
        defaults.synchronize()
    }
}

class AllUserIds: EVObject {
    
    var user_id: Int                    = 0
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
    var eta: String                     = ""
    var initial_location_lat: String    = ""
    var incoming_timestamp: String      = ""
    var initial_location_long: String   = ""
    var active_timestamp: String        = ""
    var completed_timestamp: String     = ""
    
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

class HospitalData: EVObject {
    
    var hospital_name: String           = ""
    var hospital_city: String           = ""
    var hospital_state: String          = ""
    var hospital_coords: String         = ""
    var hospital_url: String            = ""
    var hospital_id: Int                = 0
    var highest_assigned_id: Int        = 0
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

class ClinicianAssessmentModel: EVObject {
    
    var result: [ClinicianAssessmentData]?
    var message: String                 = ""
    var success: Bool                   = false
}

class ClinicianAssessmentData: EVObject {
    
    var facial_droop: String            = ""
    var arm_drift: String               = ""
    var weak_grip: String               = ""
    var speech_difficulty: String       = ""
    var bp_systolic: Int                = 0
    var bp_diastolic: Int               = 0
    var heart_rate: Int                 = 0
    var heart_rhythm: String            = ""
    var rr: Int                         = 0
    var o2sats: Int                     = 0
    var temp: Int                       = 0
    var gcs: Int                        = 0
    var blood_glucose: Int              = 0
    var facial_palsy_race: Int          = 0
    var arm_motor_impair: Int           = 0
    var leg_motor_impair: Int           = 0
    var head_gaze_deviate: Int          = 0
    var hemiparesis: String             = ""
    var cannula: Bool                   = false
    var conscious_level: Int            = 0
    var month_age: Int                  = 0
    var blink_squeeze: Int              = 0
    var horizontal_gaze: Int            = 0
    var visual_fields: Int              = 0
    var facial_palsy_nihss: Int         = 0
    var left_arm_drift: Int             = 0
    var right_arm_drift: Int            = 0
    var left_leg_drift: Int             = 0
    var right_leg_drift: Int            = 0
    var limb_ataxia: Int                = 0
    var sensation: Int                  = 0
    var aphasia: Int                    = 0
    var dysarthria: Int                 = 0
    var neglect: Int                    = 0
    var rankin_conscious: Int           = 0
    var likely_lvo: Bool                = false
    var case_id: Int                    = 0
}

class RadiologyModel: EVObject {
    
    var result: [RadiologyData]?
    var message: String                 = ""
    var success: Bool                   = false
}

class RadiologyData: EVObject {
    
    var case_id: Int                    = 0
    var arrived_to_ct: Bool             = false
    var ct1: Bool                       = false
    var ct2: Bool                       = false
    var ct3: Bool                       = false
    var ct4: Bool                       = false
    var ct_complete: Bool               = false
    var cta_ctp_complete: Bool          = false
    var do_cta_ctp: Bool                = false
    var ich_found: Bool                 = false
    var large_vessel_occlusion: Bool    = false
    var ct_available: Bool              = false
    var ct_available_loc: String        = ""
}

class ManagementModel: EVObject {
    
    var result: [ManagementData]?
    var message: String                 = ""
    var success: Bool                   = false
}

class ManagementData: EVObject {
    
    var case_id: Int                    = 0
    var thrombolysis: Bool              = false
    var new_trauma_haemorrhage: Bool    = false
    var uncontrolled_htn: Bool          = false
    var history_ich: Bool               = false
    var known_intracranial: Bool        = false
    var active_bleed: Bool              = false
    var endocarditis: Bool              = false
    var bleeding_diathesis: Bool        = false
    var abnormal_blood_glucose: Bool    = false
    var rapidly_improving: Bool         = false
    var recent_trauma_surgery: Bool     = false
    var recent_active_bleed: Bool       = false
    var seizure_onset: Bool             = false
    var recent_arterial_puncture: Bool  = false
    var recent_lumbar_puncture: Bool    = false
    var post_acs_pericarditis: Bool     = false
    var pregnant: Bool                  = false
    var ecr: Bool                       = false
    var surgical_rx: Bool               = false
    var conservative_rx: Bool           = false
    var thrombolysis_time_given: Date   = Date()
    var dob: String                     = ""
    var last_well: String               = ""
    var ich_found: Bool                 = false
    var large_vessel_occlusion: Bool    = false
}
