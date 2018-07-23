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
    
    var arrUsreType = ["Paramedic", "Clinician"]
    var strSelectedUserType: String = ""
    var loginUserData = LoginUserData()
    
    // MARK:- ViewController LifeCycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Login"
        
        let image1 = self.gradientWithFrametoImage(frame: btnLogin.frame, colors: [UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1).cgColor, UIColor(red: 255/255, green: 141/255, blue: 41/255, alpha: 1).cgColor])!
        self.btnLogin.backgroundColor = UIColor(patternImage: image1)
    }
    
    // MARK:- Action Methods -
    
    @IBAction func btnUserTypeClicked(_ sender: UIButton) {
        
        let actionsheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        actionsheet.addAction(UIAlertAction(title: "Paramedic", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            self.txtUserType.text = "Paramedic"
            self.strSelectedUserType = "Paramedic"
            self.txtRole.isHidden = true
        }))
        
        actionsheet.addAction(UIAlertAction(title: "Clinician", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            self.txtUserType.text = "Clinician"
            self.strSelectedUserType = "Clinician"
            self.txtRole.isHidden = false
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
                    loginUserData.save()
                    appDelegate.goToClinicianDeshBordView()
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
