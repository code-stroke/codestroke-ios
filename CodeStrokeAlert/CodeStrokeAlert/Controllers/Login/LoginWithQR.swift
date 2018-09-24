//
//  LoginWithQR.swift
//  CodeStrokeAlert
//
//  Created by Jayesh on 18/06/18.
//  Copyright © 2018 Jayesh. All rights reserved.
//

import UIKit
import EVReflection

let kLoginUserData = "LoginUserData"

class LoginUserData: EVObject {
    
    var strFirstName: String            = ""
    var strLastName: String             = ""
    var strUserRole: String             = ""
    var strUserType: String             = ""
    var userID: Int                     = 0
    var strTitle: String?
    
    func save() {
        
        let defaults: UserDefaults = UserDefaults.standard
        let data: NSData = NSKeyedArchiver.archivedData(withRootObject: self) as NSData
        defaults.set(data, forKey: kLoginUserData)
        defaults.synchronize()
    }
    
    class func savedUser() -> LoginUserData? {
        
        let defaults: UserDefaults = UserDefaults.standard
        let data = defaults.object(forKey: kLoginUserData) as? NSData
        
        if data != nil {
            
            if let userinfo = NSKeyedUnarchiver.unarchiveObject(with: data! as Data) as? LoginUserData {
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
        defaults.removeObject(forKey: kLoginUserData)
        defaults.synchronize()
    }
}

class LoginWithQR: UIViewController {
    
    // MARK:- Declarations -
    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtRole: UITextField!
    @IBOutlet weak var txtUserType: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var stackUserRole: UIStackView!
    
    var arrUsreType = ["Paramedic", "Clinician"]
    var strSelectedUserType: String = ""
    var strSelectedUserRole: String = ""
    var strSelectedWSUserRole: String = ""
    var loginUserData = LoginUserData()
    
    // MARK:- ViewController LifeCycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Login"

        let image1 = self.gradientWithFrametoImage(frame: btnLogin.frame, colors: [UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1).cgColor, UIColor(red: 255/255, green: 141/255, blue: 41/255, alpha: 1).cgColor])!
        self.btnLogin.backgroundColor = UIColor(patternImage: image1)
        
        if LoginUserData.savedUser() != nil {
            self.txtFirstName.text = LoginUserData.savedUser()!.strFirstName
            self.txtLastName.text = LoginUserData.savedUser()!.strLastName
            self.txtUserType.text = LoginUserData.savedUser()!.strUserType
            self.txtRole.text = LoginUserData.savedUser()!.strUserRole
            
            self.strSelectedUserType = self.txtUserType.text!
            
            if LoginUserData.savedUser()!.strUserType == "Clinician" {
                self.stackUserRole.isHidden = false
                self.strSelectedUserRole = self.txtRole.text!
                
                if self.strSelectedUserRole == "Admin" {
                    self.strSelectedWSUserRole = "admin"
                } else if self.strSelectedUserRole == "Anaesthetist" {
                    self.strSelectedWSUserRole = "anaesthetist"
                } else if self.strSelectedUserRole == "Angiography Nurse" {
                    self.strSelectedWSUserRole = "angio_nurse"
                } else if self.strSelectedUserRole == "ED Clinician" {
                    self.strSelectedWSUserRole = "ed_clinician"
                } else if self.strSelectedUserRole == "Neurointerventionalist" {
                    self.strSelectedWSUserRole = "neuroint"
                } else if self.strSelectedUserRole == "Paramedic" {
                    self.strSelectedWSUserRole = "paramedic"
                } else if self.strSelectedUserRole == "Radiographer" {
                    self.strSelectedWSUserRole = "radiographer"
                } else if self.strSelectedUserRole == "Radiologist" {
                    self.strSelectedWSUserRole = "radiologist"
                } else if self.strSelectedUserRole == "Stroke Team" {
                    self.strSelectedWSUserRole = "stroke_team"
                } else if self.strSelectedUserRole == "Stroke Ward" {
                    self.strSelectedWSUserRole = "stroke_ward"
                }
            }
        }
    }
    
    // MARK:- Action Methods -
    
    @IBAction func btnUserTypeClicked(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        let actionsheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        actionsheet.addAction(UIAlertAction(title: "Paramedic", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            self.txtUserType.text = "Paramedic"
            self.strSelectedUserType = "Paramedic"
            self.stackUserRole.isHidden = true
        }))
        
        actionsheet.addAction(UIAlertAction(title: "Clinician", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            self.txtUserType.text = "Clinician"
            self.strSelectedUserType = "Clinician"
            self.txtRole.text = ""
            self.strSelectedUserRole = ""
            self.strSelectedWSUserRole = ""
            self.stackUserRole.isHidden = false
        }))
        
        self.present(actionsheet, animated: true, completion: nil)
    }
    
    @IBAction func btnUserRoleClicked(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        let actionsheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        actionsheet.addAction(UIAlertAction(title: "Admin", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            self.txtRole.text = "Admin"
            self.strSelectedUserRole = "Admin"
            self.strSelectedWSUserRole = "admin"
        }))
        
        actionsheet.addAction(UIAlertAction(title: "Anaesthetist", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            self.txtRole.text = "Anaesthetist"
            self.strSelectedUserRole = "Anaesthetist"
            self.strSelectedWSUserRole = "anaesthetist"
        }))
        
        actionsheet.addAction(UIAlertAction(title: "Angiography Nurse", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            self.txtRole.text = "Angiography Nurse"
            self.strSelectedUserRole = "Angiography Nurse"
            self.strSelectedWSUserRole = "angio_nurse"
        }))
        
        actionsheet.addAction(UIAlertAction(title: "ED Clinician", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            self.txtRole.text = "ED Clinician"
            self.strSelectedUserRole = "ED Clinician"
            self.strSelectedWSUserRole = "ed_clinician"
        }))
        
        actionsheet.addAction(UIAlertAction(title: "Neurointerventionalist", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            self.txtRole.text = "Neurointerventionalist"
            self.strSelectedUserRole = "Neurointerventionalist"
            self.strSelectedWSUserRole = "neuroint"
        }))
        
        actionsheet.addAction(UIAlertAction(title: "Paramedic", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            self.txtRole.text = "Paramedic"
            self.strSelectedUserRole = "Paramedic"
            self.strSelectedWSUserRole = "paramedic"
        }))
        
        actionsheet.addAction(UIAlertAction(title: "Radiographer", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            self.txtRole.text = "Radiographer"
            self.strSelectedUserRole = "Radiographer"
            self.strSelectedWSUserRole = "radiographer"
        }))
        
        actionsheet.addAction(UIAlertAction(title: "Radiologist", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            self.txtRole.text = "Radiologist"
            self.strSelectedUserRole = "Radiologist"
            self.strSelectedWSUserRole = "radiologist"
        }))
        
        actionsheet.addAction(UIAlertAction(title: "Stroke Team", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            self.txtRole.text = "Stroke Team"
            self.strSelectedUserRole = "Stroke Team"
            self.strSelectedWSUserRole = "stroke_team"
        }))
        
        actionsheet.addAction(UIAlertAction(title: "Stroke Ward", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            self.txtRole.text = "Stroke Ward"
            self.strSelectedUserRole = "Stroke Ward"
            self.strSelectedWSUserRole = "stroke_ward"
        }))
        
        self.present(actionsheet, animated: true, completion: nil)
    }
    
    @IBAction func btnLoginClicked(_ sender: UIButton) {
        
        if isEmptyString(self.txtFirstName.text!) {
            showAlert("Enter Firstname")
        } else if isEmptyString(self.txtLastName.text!) {
            showAlert("Enter Lastname")
        } else if isEmptyString(self.txtUserType.text!) {
            showAlert("Select User Type")
        } else {
            if strSelectedUserType == "Clinician" {
                if isEmptyString(self.txtRole.text!) {
                    showAlert("Enter Role")
                } else {
                    loginUserData.strFirstName = self.txtFirstName.text!
                    loginUserData.strLastName = self.txtLastName.text!
                    loginUserData.strUserRole = self.txtRole.text!
                    loginUserData.strUserType = self.txtUserType.text!
                    loginUserData.userID = 0
                    
                    let param = ["first_name": self.txtFirstName.text!,
                                 "last_name": self.txtLastName.text!,
                                 "user_role": self.txtRole.text!,
                                 "user_type": self.txtUserType.text!,
                                 "user_token": getDeviceToken()]
                    
                    if Reachability.isConnectedToNetwork() {
                        DispatchQueue.global(qos: .background).async {
                            DispatchQueue.main.async {
                                self.WS_Login(url: "http://52.15.42.249/user/create.php", parameter: param)
                            }
                        }
                    } else {
                        showAlert("No internet connection")
                    }
                }
            } else {
                loginUserData.strFirstName = self.txtFirstName.text!
                loginUserData.strLastName = self.txtLastName.text!
                loginUserData.strUserRole = ""
                loginUserData.strUserType = self.txtUserType.text!
                loginUserData.save()
                appDelegate.goToParamedicDeshBordView()
            }
        }
    }
    
    // MARK:- Memory Warning -
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation -
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}
