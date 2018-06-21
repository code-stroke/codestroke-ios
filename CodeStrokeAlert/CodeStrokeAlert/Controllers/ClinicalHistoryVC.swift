//
//  ClinicalHistoryVC.swift
//  CodeStrokeAlert
//
//  Created by Jayesh on 19/06/18.
//  Copyright © 2018 Jayesh. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Clinical History"
        
        let image1 = self.gradientWithFrametoImage(frame: btnNext.frame, colors: [UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1).cgColor, UIColor(red: 255/255, green: 141/255, blue: 41/255, alpha: 1).cgColor])!
        self.btnNext.backgroundColor = UIColor(patternImage: image1)
    }

    // MARK: - Action Methods -
    
    @IBAction func btnNextClicked(_ sender: DesignableButton) {
        
        if isEmptyString(self.txtPostMedicalHistory.text!) && self.btnIHD.isSelected == false && self.btnDM.isSelected == false && self.btnStroke.isSelected == false && self.btnEpilepsy.isSelected == false && self.btnAF.isSelected == false && self.btnOther.isSelected == false {
            showAlert("Please enter post medical history or select any one option")
        } else if isEmptyString(self.txtMedications.text!) {
            showAlert("Please enter medications")
        } else if isEmptyString(self.txtLastDate.text!) {
            showAlert("Please select last date")
        } else if isEmptyString(self.txtSituation.text!) {
            showAlert("Please enter situation (HOPC)")
        } else if isEmptyString(self.txtWeight.text!) {
            showAlert("Please enter weight")
        } else {
            self.performSegue(withIdentifier: "ClinicalAssessment", sender: self)
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
            }
        }
        
        let actionController = RMDateSelectionViewController(style: style, title: "Please select date", message: nil, select: selectAction, andCancel: cancelAction)!
        actionController.datePicker.datePickerMode = .date
        
        appDelegate.window?.rootViewController!.present(actionController, animated: true, completion: nil)
    }
}
