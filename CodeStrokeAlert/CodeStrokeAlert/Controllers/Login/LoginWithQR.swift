//
//  LoginWithQR.swift
//  CodeStrokeAlert
//
//  Created by Jayesh on 18/06/18.
//  Copyright © 2018 Jayesh. All rights reserved.
//

import UIKit

class LoginWithQR: UIViewController {

    // MARK:- Declarations -
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    
    // MARK:- ViewController LifeCycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Login"
        
        let image1 = self.gradientWithFrametoImage(frame: btnLogin.frame, colors: [UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1).cgColor, UIColor(red: 255/255, green: 141/255, blue: 41/255, alpha: 1).cgColor])!
        self.btnLogin.backgroundColor = UIColor(patternImage: image1)
        
        self.txtUsername.setLeftPaddingPoints(28)
        self.txtPassword.setLeftPaddingPoints(28)
    }
    
    // MARK:- Action Methods -
    
    @IBAction func btnLoginClicked(_ sender: UIButton) {
        
        if isEmptyString(self.txtUsername.text!) {
            showAlert("Enter paramedic/clinician to login")
        } else {
            
            if self.txtUsername.text! == "paramedic" {
                appDelegate.goToParamedicDeshBordView()
            } else if self.txtUsername.text! == "clinician" {
                appDelegate.goToClinicianDeshBordView()
            } else {
                showAlert("Enter paramedic/clinician to login")
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
