//
//  ClinicianPatientDetailVC.swift
//  CodeStrokeAlert
//
//  Created by Jayesh on 27/06/18.
//  Copyright © 2018 Jayesh. All rights reserved.
//

import UIKit

class ClinicianPatientDetailVC: UIViewController {
    
    // MARK: - Declarations -
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var btnPrimarySurvey: UIButton!
    @IBOutlet weak var btnRegistered: UIButton!
    @IBOutlet weak var btnTriggered: UIButton!
    @IBOutlet weak var txtLocation: UITextField!
    
    var cashDetail = CaseList()
    
    // MARK: - View Controller Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image1 = self.gradientWithFrametoImage(frame: btnSubmit.frame, colors: [UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1).cgColor, UIColor(red: 255/255, green: 141/255, blue: 41/255, alpha: 1).cgColor])!
        self.btnSubmit.backgroundColor = UIColor(patternImage: image1)
    }
    
    // MARK: - Action Methods -
    
    @IBAction func btnCurrentLocationClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func btnRegisterTriagedPrimaryClicked(_ sender: UIButton) {
        
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }
    
    @IBAction func btnSubmitClicked(_ sender: UIButton) {
        
        let param = ["location": "",
                     "registered": self.btnRegistered.isSelected ? 1 : 0,
                     "triaged": self.btnTriggered.isSelected ? 1 : 0,
                     "primary_survey": self.btnPrimarySurvey.isSelected ? 1 : 0,
                     "signoff_first_name": LoginUserData.savedUser()!.strFirstName,
                     "signoff_last_name": LoginUserData.savedUser()!.strLastName,
                     "signoff_role": LoginUserData.savedUser()!.strUserRole] as [String : Any]
        
        if Reachability.isConnectedToNetwork() {
            DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.async {
                    self.WS_ED_Details(url: AppURL.baseURL + AppURL.ED + "\(CaseList.savedUser()!.case_id)/", parameter: param, isGet: false)
                }
            }
        } else {
            showAlert("No internet connection")
        }
    }
    
    // MARK: - Custom Methods -
    
    func WS_ED_Details_Call() {
        
        if Reachability.isConnectedToNetwork() {
            DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.async {
                    self.WS_ED_Details(url: AppURL.baseURL + AppURL.ED + "\(CaseList.savedUser()!.case_id)/", parameter: [:], isGet: true)
                }
            }
        } else {
            showAlert("No internet connection")
        }
    }
    
    // MARK: - Memory Warning -
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation -
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ClinicianPatientDetailTwo" {
            
            let destination = segue.destination as! ClinicianPatientDetailTwoVC
            print(destination)
        }
    }
}
