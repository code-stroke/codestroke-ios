//
//  ClinicalHistoryVC.swift
//  CodeStrokeAlert
//
//  Created by Jayesh on 19/06/18.
//  Copyright © 2018 Jayesh. All rights reserved.
//

import UIKit
import EVReflection

let kClinicalHistoryData = "ClinicalHistoryData"

class ClinicalHistoryData: EVObject {
    
    var strPostMedicalHistory: String           = ""
    var strMedications: String                  = ""
    var strAnticoagulants: Bool                 = false
    var strLastDostDate: String                 = ""
    var strSituation: String                    = ""
    var strWeight: Float                        = 0.0
    
    func save() {
        
        let defaults: UserDefaults = UserDefaults.standard
        let data: NSData = NSKeyedArchiver.archivedData(withRootObject: self) as NSData
        defaults.set(data, forKey: kClinicalHistoryData)
        defaults.synchronize()
    }
    
    class func savedUser() -> ClinicalHistoryData? {
        
        let defaults: UserDefaults = UserDefaults.standard
        let data = defaults.object(forKey: kClinicalHistoryData) as? NSData
        
        if data != nil {
            
            if let userinfo = NSKeyedUnarchiver.unarchiveObject(with: data! as Data) as? ClinicalHistoryData {
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
        defaults.removeObject(forKey: kClinicalHistoryData)
        defaults.synchronize()
    }
}

class ClinicalHistoryVC: UIViewController {
    
    @IBOutlet weak var btnNext: DesignableButton!
    @IBOutlet weak var txtPostMedicalHistory: UITextField!
    @IBOutlet weak var txtMedications: UITextField!
    
    @IBOutlet weak var btnIHD: UIButton!
    @IBOutlet weak var btnDM: UIButton!
    @IBOutlet weak var btnStroke: UIButton!
    @IBOutlet weak var btnEpilepsy: UIButton!
    @IBOutlet weak var btnAF: UIButton!
    @IBOutlet weak var btnOther: UIButton!
    
    @IBOutlet weak var btnAnticoagulantsYes: UIButton!
    @IBOutlet weak var btnAnticoagulantsNo: UIButton!
    
    @IBOutlet weak var btnApixaban: UIButton!
    @IBOutlet weak var btnRivaroxaban: UIButton!
    @IBOutlet weak var btnWarfarin: UIButton!
    @IBOutlet weak var btnDabigatran: UIButton!
    @IBOutlet weak var btnHeparin: UIButton!
    
    @IBOutlet weak var txtLastDate: DesignableTextField!
    @IBOutlet weak var txtSituation: UITextField!
    @IBOutlet weak var txtWeight: UITextField!
    
    var strLastMealDate: String = ""
    var clinicalHistoryData = ClinicalHistoryData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Clinical History"
        
        let image1 = self.gradientWithFrametoImage(frame: btnNext.frame, colors: [UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1).cgColor, UIColor(red: 255/255, green: 141/255, blue: 41/255, alpha: 1).cgColor])!
        self.btnNext.backgroundColor = UIColor(patternImage: image1)
    }
    
    // MARK: - Action Methods -
    
    @IBAction func btnNextClicked(_ sender: DesignableButton) {
        
        var strPostMdHistory = ""
        
        if !isEmptyString(self.txtPostMedicalHistory.text!) {
            strPostMdHistory = self.txtPostMedicalHistory.text!.trim
            strPostMdHistory.append(",")
        }
        
        if btnIHD.isSelected {
            strPostMdHistory.append("IHD,")
        } else if btnDM.isSelected {
            strPostMdHistory.append("DM,")
        } else if btnStroke.isSelected {
            strPostMdHistory.append("Stroke,")
        } else if btnEpilepsy.isSelected {
            strPostMdHistory.append("Epilepsy,")
        } else if btnAF.isSelected {
            strPostMdHistory.append("AF,")
        } else if btnOther.isSelected {
            strPostMdHistory.append("Other neurological conditions")
        }
        
        if strPostMdHistory.last == "," {
            strPostMdHistory = String(strPostMdHistory.dropLast())
        }
        
        var strMedication = ""
        
        if isEmptyString(self.txtMedications.text!) {
            strMedication = ""
        } else {
            strMedication = self.txtMedications.text!.trim
        }
        
        var strSituation = ""
        
        if isEmptyString(self.txtSituation.text!) {
            strSituation = ""
        } else {
            strSituation = self.txtSituation.text!.trim
        }
        
        var strWeight = "0"
        
        if isEmptyString(self.txtWeight.text!) {
            strWeight = "0"
        } else {
            strWeight = self.txtWeight.text!.trim
        }
        
        clinicalHistoryData.strPostMedicalHistory = strPostMdHistory
        clinicalHistoryData.strMedications = strMedication
        clinicalHistoryData.strAnticoagulants = self.btnAnticoagulantsYes.isSelected ? true : false
        clinicalHistoryData.strLastDostDate = strLastMealDate
        clinicalHistoryData.strSituation = strSituation
        clinicalHistoryData.strWeight = Float(strWeight)!
        
        clinicalHistoryData.save()
        print(ClinicalHistoryData.savedUser()!)
        
        let param = ["pmhx": strPostMdHistory,
                     "meds": strMedication,
                     "anticoags": self.btnAnticoagulantsYes.isSelected ? true : false,
                     "hopc": strSituation,
                     "weight": Float(strWeight)!,
                     "last_meal": self.strLastMealDate] as [String : Any]
        
        if Reachability.isConnectedToNetwork() {
            DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.async {
                    self.WS_ClinicalHistory(url: AppURL.baseURL + AppURL.CaseHistory + "\(UserDefaults.standard.integer(forKey: "case_id"))/", parameter: param)
                }
            }
        } else {
            showAlert("No internet connection")
        }
    }
    
    @IBAction func btnPostMedicalHistoryClicked(_ sender: UIButton) {
        
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }
    
    @IBAction func btnAnnticoagulantsClicked(_ sender: UIButton) {
        
        self.btnAnticoagulantsYes.isSelected = false
        self.btnAnticoagulantsNo.isSelected = false
        sender.isSelected = true
    }
    
    @IBAction func btnMedicationClicked(_ sender: UIButton) {
        
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }
    
    // MARK: - Memory Warning -
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation -
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ClinicalAssessment" {
            
            let destination = segue.destination as! ClinicalAssessmentVC
            print(destination)
        }
    }
}

// MARK: - UITextField Delegate -

extension ClinicalHistoryVC: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        self.openDatePicker()
        return false
    }
}

// MARK: - Extension for DatePicker -

extension ClinicalHistoryVC {
    
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
                self.txtLastDate.text = formattedDate
                
                f.setLocal()
                self.strLastMealDate = f.string(from: pickerController.datePicker.date)
            }
        }
        
        let actionController = RMDateSelectionViewController(style: style, title: "Please select date", message: nil, select: selectAction, andCancel: cancelAction)!
        actionController.datePicker.datePickerMode = .dateAndTime
        
        appDelegate.window?.rootViewController!.present(actionController, animated: true, completion: {
            self.view.endEditing(true)
        })
    }
}
