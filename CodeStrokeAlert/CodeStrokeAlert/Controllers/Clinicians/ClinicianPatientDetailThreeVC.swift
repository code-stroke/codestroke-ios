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
    
    @IBOutlet weak var viewShadow: UIView!
    
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
        
        self.viewShadow.dropShadow(color: UIColor.init(red: 0.0/255.0, green: 90.0/255.0, blue: 192.0/255.0, alpha: 0.44), viewShadow: self.viewShadow)
        
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
                    self.WS_Clinician_Details(url: AppURL.baseURL + AppURL.Clinician + "\(CaseList.savedUser()!.case_id)/", parameter: [:], isGet: true)
                }
            }
        } else {
            showAlert("No internet connection")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.buttonCenter(scrollView: scrlView, button: self.btnClinicalHistory)
    }
    
    // MARK: - Action Methods -
    
    @IBAction func btnTypeClicked(_ sender: UIButton) {
        
    }
    
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
                     "last_meal": self.txtLastMeal.text!] as [String : Any]
        
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
                
                f.dateFormat = "yyyy-MM-dd hh:mm:ss"
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
