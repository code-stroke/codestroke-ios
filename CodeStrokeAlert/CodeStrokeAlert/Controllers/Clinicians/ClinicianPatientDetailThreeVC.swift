//
//  ClinicianPatientDetailThreeVC.swift
//  CodeStrokeAlert
//
//  Created by Jayesh on 27/06/18.
//  Copyright © 2018 Jayesh. All rights reserved.
//

import UIKit

class ClinicianPatientDetailThreeVC: UIViewController {
    
    // MARK: - Declarations -
    
    @IBOutlet weak var txtPastMedicalHistory: UITextField!
    @IBOutlet weak var txtMedication: UITextField!
    @IBOutlet weak var txtLastDose: DesignableTextField!
    @IBOutlet weak var txtSituation: UITextField!
    @IBOutlet weak var txtWeight: UITextField!
    @IBOutlet weak var txtLastMeal: UITextField!
    
    @IBOutlet weak var btnAnticoagulantsYes: UIButton!
    @IBOutlet weak var btnAnticoagulantsNo: UIButton!
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    var strLastDoseDate: String = ""
    
    // MARK: - View Controller Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let image1 = self.gradientWithFrametoImage(frame: btnSubmit.frame, colors: [UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1).cgColor, UIColor(red: 255/255, green: 141/255, blue: 41/255, alpha: 1).cgColor])!
        self.btnSubmit.backgroundColor = UIColor(patternImage: image1)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    // MARK: - Action Methods -
    
    @IBAction func btnSubmitClicked(_ sender: UIButton) {
        
        var strWeight = "0"
        
        if isEmptyString(self.txtWeight.text!) {
            strWeight = "0"
        } else {
            strWeight = self.txtWeight.text!.trim
        }
        
        let param = ["pmhx": self.txtPastMedicalHistory.text!,
                     "anticoags_last_dose": self.strLastDoseDate,
                     "meds": self.txtMedication.text!,
                     "anticoags": self.btnAnticoagulantsYes.isSelected ? true : false,
                     "hopc": self.txtSituation.text!,
                     "weight": Float(strWeight)!,
                     "last_meal": self.txtLastMeal.text!,
                     "signoff_first_name": LoginUserData.savedUser()!.strFirstName,
                     "signoff_last_name": LoginUserData.savedUser()!.strLastName,
                     "signoff_role": LoginUserData.savedUser()!.strUserRole] as [String : Any]
        
        if Reachability.isConnectedToNetwork() {
            DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.async {
                    self.WS_Clinician_Details(url: AppURL.baseURL + AppURL.Clinician + "\(CaseList.savedUser()!.case_id)/", parameter: param, isGet: false)
                }
            }
        } else {
            showAlert("No internet connection")
        }
    }
    
    // MARK: - Custom Methods -
    
    func WS_Clinician_Details_Call() {
        
        if Reachability.isConnectedToNetwork() {
            DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.async {
                    self.WS_Clinician_Details(url: AppURL.baseURL + AppURL.Clinician + "\(CaseList.savedUser()!.case_id)/", parameter: [:], isGet: true)
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
        
        if segue.identifier == "ClinicianPatientDetailFour" {
            
            let destination = segue.destination as! ClinicianPatientDetailFourVC
            print(destination)
        }
    }
}

// MARK: - UITextField Delegate -

extension ClinicianPatientDetailThreeVC: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        self.openDatePicker()
        return false
    }
}

// MARK: - Extension for DatePicker -

extension ClinicianPatientDetailThreeVC {
    
    func openDatePicker() {
        
        self.view.endEditing(true)
        let style = RMActionControllerStyle.white
        
        let cancelAction = RMAction<UIDatePicker>(title: "Cancel", style: RMActionStyle.cancel) { _ in
            
            print("Date selection was canceled")
        }
        
        let selectAction = RMAction<UIDatePicker>(title: "Select", style: RMActionStyle.done) { controller in
            
            if let pickerController = controller as? RMDateSelectionViewController {
                
                let f = DateFormatter()
                f.dateFormat = "dd MMMM yyyy"
                let formattedDate: String = f.string(from: pickerController.datePicker.date)
                self.txtLastDose.text = formattedDate
                
                f.setLocal()
                self.strLastDoseDate = f.string(from: pickerController.datePicker.date)
            }
        }
        
        let actionController = RMDateSelectionViewController(style: style, title: "Please select date", message: nil, select: selectAction, andCancel: cancelAction)!
        actionController.datePicker.datePickerMode = .dateAndTime
        
        appDelegate.window?.rootViewController!.present(actionController, animated: true, completion: {
            self.view.endEditing(true)
        })
    }
}
