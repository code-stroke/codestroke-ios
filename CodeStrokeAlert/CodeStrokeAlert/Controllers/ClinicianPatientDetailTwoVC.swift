//
//  ClinicianPatientDetailTwoVC.swift
//  CodeStrokeAlert
//
//  Created by Jayesh on 27/06/18.
//  Copyright © 2018 Jayesh. All rights reserved.
//

import UIKit

class ClinicianPatientDetailTwoVC: UIViewController {
    
    // MARK: - Declarations -
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLastSeen: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblCaseType: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblETA: UILabel!
    
    @IBOutlet weak var btnED: UIButton!
    @IBOutlet weak var btnPatientDetail: UIButton!
    @IBOutlet weak var btnClinicalHistory: UIButton!
    @IBOutlet weak var btnClinicalAssessment: UIButton!
    @IBOutlet weak var btnRadiology: UIButton!
    @IBOutlet weak var btnManagement: UIButton!
    @IBOutlet weak var scrlView: UIScrollView!
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtSurname: UITextField!
    @IBOutlet weak var txtDOB: DesignableTextField!
    @IBOutlet weak var txtAddress: UITextField!
    
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var btnUnspecifies: UIButton!
    
    @IBOutlet weak var txtLastSeen: UITextField!
    @IBOutlet weak var txtNextKin: UITextField!
    @IBOutlet weak var txtNOKContact: UITextField!
    @IBOutlet weak var txtMedicare: UITextField!
    
    var strDOB: String = ""
    var strLastSeen: String = ""
    
    // MARK: - View Controller Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.lblName.text = "\(CaseList.savedUser()!.first_name == "unknown" ? "" : CaseList.savedUser()!.first_name) \(CaseList.savedUser()!.last_name == "unknown" ? "" : CaseList.savedUser()!.last_name)"
        self.lblLastSeen.text = CaseList.savedUser()!.last_well
        let strDOB = self.calcAge(birthday: CaseList.savedUser()!.dob)
        self.lblAge.text = "\(strDOB)"
        self.lblCaseType.text = CaseList.savedUser()!.status
        self.lblGender.text = CaseList.savedUser()!.gender == "f" ? "Female" : "Male"
        self.lblETA.text = CaseList.savedUser()!.status_time
        
        self.btnED.layer.cornerRadius = 5
        self.btnPatientDetail.layer.cornerRadius = 5
        self.btnClinicalHistory.layer.cornerRadius = 5
        self.btnClinicalAssessment.layer.cornerRadius = 5
        self.btnRadiology.layer.cornerRadius = 5
        self.btnManagement.layer.cornerRadius = 5
        
        let image1 = self.gradientWithFrametoImage(frame: btnSubmit.frame, colors: [UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1).cgColor, UIColor(red: 255/255, green: 141/255, blue: 41/255, alpha: 1).cgColor])!
        self.btnSubmit.backgroundColor = UIColor(patternImage: image1)
        
        if Reachability.isConnectedToNetwork() {
            DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.async {
                    self.WS_Case_Details(url: AppURL.baseURL + AppURL.CaseList + "\(CaseList.savedUser()!.case_id)/", parameter: [:], isGet: true)
                }
            }
        } else {
            showAlert("No internet connection")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.buttonCenter(scrollView: scrlView, button: self.btnPatientDetail)
    }
    
    // MARK: - Action Methods -
    
    @IBAction func btnTypeClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func btnGenderClicked(_ sender: UIButton) {
        
        self.btnFemale.isSelected = false
        self.btnMale.isSelected = false
        self.btnUnspecifies.isSelected = false
        
        sender.isSelected = true
    }
    
    @IBAction func btnSubmitClicked(_ sender: UIButton) {
        
        if isEmptyString(self.txtFirstName.text!) {
            showAlert("Please enter firstname")
        } else if isEmptyString(self.txtSurname.text!) {
            showAlert("Please enter surname")
        } else if isEmptyString(self.txtDOB.text!) {
            showAlert("Please select dob")
        } else if isEmptyString(self.txtAddress.text!) {
            showAlert("Please enter address")
        } else if isEmptyString(self.txtNextKin.text!) {
            showAlert("Please enter next to KIN")
        } else if isEmptyString(self.txtNOKContact.text!) {
            showAlert("Please enter NOK Telephone")
        } else {
            
            let param = ["first_name": self.txtFirstName.text!,
                         "last_name": self.txtSurname.text!,
                         "dob": self.strDOB,
                         "address": self.txtAddress.text!,
                         "gender": self.btnUnspecifies.isSelected ? "u" : (self.btnMale.isSelected ? "m" : "f"),
                         "last_well": self.strLastSeen,
                         "nok": self.txtNextKin.text!,
                         "nok_phone": self.txtNOKContact.text!,
                         "medicare_no": self.txtMedicare.text!,
                         "hospital_id": "1"]
            
            if Reachability.isConnectedToNetwork() {
                DispatchQueue.global(qos: .background).async {
                    DispatchQueue.main.async {
                        self.WS_Case_Details(url: AppURL.baseURL + AppURL.CaseList + "\(CaseList.savedUser()!.case_id)/", parameter: param, isGet: false)
                    }
                }
            } else {
                showAlert("No internet connection")
            }
        }
    }

    // MARK: - Custom Methods -
    
    func clearSelection() {
        
        self.btnED.backgroundColor = UIColor.init(red: 212.0/255.0, green: 215.0/255.0, blue: 220.0/255.0, alpha: 1.0)
        self.btnPatientDetail.backgroundColor = UIColor.init(red: 212.0/255.0, green: 215.0/255.0, blue: 220.0/255.0, alpha: 1.0)
        self.btnClinicalHistory.backgroundColor = UIColor.init(red: 212.0/255.0, green: 215.0/255.0, blue: 220.0/255.0, alpha: 1.0)
        self.btnClinicalAssessment.backgroundColor = UIColor.init(red: 212.0/255.0, green: 215.0/255.0, blue: 220.0/255.0, alpha: 1.0)
        self.btnRadiology.backgroundColor = UIColor.init(red: 212.0/255.0, green: 215.0/255.0, blue: 220.0/255.0, alpha: 1.0)
        self.btnManagement.backgroundColor = UIColor.init(red: 212.0/255.0, green: 215.0/255.0, blue: 220.0/255.0, alpha: 1.0)
    }
    
    // MARK: - Memory Warning -
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation -
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ClinicianPatientDetailThree" {
            
            let destination = segue.destination as! ClinicianPatientDetailThreeVC
            print(destination)
        }
    }
}

// MARK: - UITextField Delegate -

extension ClinicianPatientDetailTwoVC: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == txtDOB {
            
            self.txtLastSeen.isSelected = false
            self.txtDOB.isSelected = true
            self.openDatePicker()
            return false
        } else if textField == txtLastSeen {
            
            self.txtLastSeen.isSelected = true
            self.txtDOB.isSelected = false
            self.openDatePicker()
            return false
        }
        return true
    }
}

// MARK: - Extension for DatePicker -

extension ClinicianPatientDetailTwoVC {
    
    func openDatePicker() {
        
        self.view.endEditing(true)
        let style = RMActionControllerStyle.white
        
        let cancelAction = RMAction<UIDatePicker>(title: "Cancel", style: RMActionStyle.cancel) { _ in
            
            print("Date selection was canceled")
        }
        
        let selectAction = RMAction<UIDatePicker>(title: "Select", style: RMActionStyle.done) { controller in
            
            if let pickerController = controller as? RMDateSelectionViewController {
                
                let f = DateFormatter()
                
                if self.txtLastSeen.isSelected == true {

                    f.dateFormat = "yyyy-MM-dd hh:mm:ss"
                    self.strLastSeen = f.string(from: pickerController.datePicker.date)
                    self.txtLastSeen.text = self.strLastSeen
                    
                } else {
                    f.dateFormat = "MMM dd, yyyy"
                    let formattedDate: String = f.string(from: pickerController.datePicker.date)
                    self.txtDOB.text = formattedDate
                    
                    f.dateFormat = "yyyy-MM-dd"
                    self.strDOB = f.string(from: pickerController.datePicker.date)
                }
            }
        }
        
        let actionController = RMDateSelectionViewController(style: style, title: "Please select date", message: nil, select: selectAction, andCancel: cancelAction)!
        
        if self.txtLastSeen.isSelected == true {
            actionController.datePicker.datePickerMode = .dateAndTime
        } else {
            actionController.datePicker.set18YearValidation()
            actionController.datePicker.datePickerMode = .date
        }
        
        appDelegate.window?.rootViewController!.present(actionController, animated: true, completion: {
            self.view.endEditing(true)
        })
    }
}
