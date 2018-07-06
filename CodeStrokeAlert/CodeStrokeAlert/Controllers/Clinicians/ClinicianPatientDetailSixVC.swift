//
//  ClinicianPatientDetailSixVC.swift
//  CodeStrokeAlert
//
//  Created by Jayesh on 27/06/18.
//  Copyright © 2018 Jayesh. All rights reserved.
//

import UIKit

class ClinicianPatientDetailSixVC: UIViewController {
    
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
    
    @IBOutlet weak var lblThrombolysis1: UILabel!
    @IBOutlet weak var lblThrombolysis2: UILabel!
    @IBOutlet weak var lblThrombolysis3: UILabel!
    @IBOutlet weak var lblThrombolysis4: UILabel!
    
    @IBOutlet weak var btnNueHeadYes: UIButton!
    @IBOutlet weak var btnNueHeadNo: UIButton!
    
    @IBOutlet weak var btnUnControlledHTNYes: UIButton!
    @IBOutlet weak var btnUnControlledHTNNo: UIButton!
    
    @IBOutlet weak var btnHistoryOfICHYes: UIButton!
    @IBOutlet weak var btnHistoryOfICHNo: UIButton!
    
    @IBOutlet weak var btnKnownIntracranialYes: UIButton!
    @IBOutlet weak var btnKnownIntracraniaNo: UIButton!
    
    @IBOutlet weak var btnActiveBleedingYes: UIButton!
    @IBOutlet weak var btnActiveBleedingNo: UIButton!
    
    @IBOutlet weak var btnEndocarditisYes: UIButton!
    @IBOutlet weak var btnEndocarditisNo: UIButton!
    
    @IBOutlet weak var btnKnownBleedingDiathesisYes: UIButton!
    @IBOutlet weak var btnKnownBleedingDiathesisNo: UIButton!
    
    @IBOutlet weak var btnAbnormalBloodGlucoseYes: UIButton!
    @IBOutlet weak var btnAbnormalBloodGlucoseNo: UIButton!
    
    @IBOutlet weak var btnRapidlyImprovingYes: UIButton!
    @IBOutlet weak var btnRapidlyImprovingNo: UIButton!
    
    @IBOutlet weak var btnRecentTraumaSurgeryYes: UIButton!
    @IBOutlet weak var btnRecentTraumaSurgeryNo: UIButton!
    
    @IBOutlet weak var btnRecentActiveBleedingYes: UIButton!
    @IBOutlet weak var btnRecentActiveBleedingNo: UIButton!
    
    @IBOutlet weak var btnSeizureAtOnsetYes: UIButton!
    @IBOutlet weak var btnSeizureAtOnsetNo: UIButton!
    
    @IBOutlet weak var btnRecenntArterialPunctureYes: UIButton!
    @IBOutlet weak var btnRecenntArterialPunctureNo: UIButton!
    
    @IBOutlet weak var bntRecentLumbarPunctureYes: UIButton!
    @IBOutlet weak var bntRecentLumbarPunctureNo: UIButton!
    
    @IBOutlet weak var btnPostACSPericarditisYes: UIButton!
    @IBOutlet weak var btnPostACSPericarditisNo: UIButton!
    
    @IBOutlet weak var btnPregnantYes: UIButton!
    @IBOutlet weak var btnPregnantNo: UIButton!
    
    @IBOutlet weak var btnTimeWhenThrombolysisYes: UIButton!
    @IBOutlet weak var btnTimeWhenThrombolysisNNo: UIButton!
    
    @IBOutlet weak var btnECRYes: UIButton!
    @IBOutlet weak var btnECRNo: UIButton!
    
    @IBOutlet weak var btnSurgicalManagementYes: UIButton!
    @IBOutlet weak var btnSurgicalManagementNo: UIButton!
    
    @IBOutlet weak var btnConservativeManagementYes: UIButton!
    @IBOutlet weak var btnConservativeManagementNo: UIButton!
    
    @IBOutlet weak var btnSubmit: UIButton!
    
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
                    self.WS_Management(url: AppURL.baseURL + AppURL.Clinician_Management + "\(CaseList.savedUser()!.case_id)/", parameter: [:], isGet: true)
                }
            }
        } else {
            showAlert("No internet connection")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.buttonCenter(scrollView: scrlView, button: self.btnManagement)
    }
    
    // MARK: - Action Methods -
    
    @IBAction func btnTypeClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func btnSubmitClicked(_ sender: UIButton) {
        
        let param = ["thrombolysis": self.lblThrombolysis1.text!,
                     "new_trauma_haemorrhage": self.btnNueHeadYes.isSelected ? true : self.btnNueHeadNo.isSelected ? false : 0,
                     "uncontrolled_htn": self.btnUnControlledHTNYes.isSelected ? true : self.btnUnControlledHTNNo.isSelected ? false : 0,
                     "history_ich": self.btnHistoryOfICHYes.isSelected ? true : self.btnHistoryOfICHNo.isSelected ? false : 0,
                     "known_intracranial": self.btnKnownIntracranialYes.isSelected ? true : self.btnKnownIntracraniaNo.isSelected ? false : 0,
                     "active_bleed": self.btnActiveBleedingYes.isSelected ? true : self.btnActiveBleedingNo.isSelected ? false : 0,
                     "endocarditis": self.btnEndocarditisYes.isSelected ? true : self.btnEndocarditisNo.isSelected ? false : 0,
                     "bleeding_diathesis": self.btnKnownBleedingDiathesisYes.isSelected ? true : self.btnKnownBleedingDiathesisNo.isSelected ? false : 0,
                     "abnormal_blood_glucose": self.btnAbnormalBloodGlucoseYes.isSelected ? true : self.btnAbnormalBloodGlucoseNo.isSelected ? false : 0,
                     "rapidly_improving": self.btnRapidlyImprovingYes.isSelected ? true : self.btnRapidlyImprovingNo.isSelected ? false : 0,
                     "recent_trauma_surgery": self.btnRecentTraumaSurgeryYes.isSelected ? true : self.btnRecentTraumaSurgeryNo.isSelected ? false : 0,
                     "recent_active_bleed": self.btnRecentActiveBleedingYes.isSelected ? true : self.btnRecentActiveBleedingNo.isSelected ? false : 0,
                     "seizure_onset": self.btnSeizureAtOnsetYes.isSelected ? true : self.btnSeizureAtOnsetNo.isSelected ? false : 0,
                     "recent_arterial_puncture": self.btnRecenntArterialPunctureYes.isSelected ? true : self.btnRecenntArterialPunctureYes.isSelected ? false : 0,
                     "recent_lumbar_puncture": self.bntRecentLumbarPunctureYes.isSelected ? true : self.bntRecentLumbarPunctureNo.isSelected ? false : 0,
                     "post_acs_pericarditis": self.btnPostACSPericarditisYes.isSelected ? true : self.btnPostACSPericarditisNo.isSelected ? false : 0,
                     "pregnant": self.btnPregnantYes.isSelected ? true : self.btnPregnantNo.isSelected ? false : 0,
                     "thrombolysis_time_given": self.btnTimeWhenThrombolysisYes.isSelected ? true : self.btnTimeWhenThrombolysisNNo.isSelected ? false : 0,
                     "ecr": self.btnECRYes.isSelected ? true : self.btnECRNo.isSelected ? false : 0,
                     "surgical_rx": self.btnSurgicalManagementYes.isSelected ? true : self.btnSurgicalManagementNo.isSelected ? false : 0,
                     "conservative_rx": self.btnConservativeManagementYes.isSelected ? true : self.btnConservativeManagementNo.isSelected ? false : 0] as [String : Any]
        
        if Reachability.isConnectedToNetwork() {
            DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.async {
                    self.WS_Management(url: AppURL.baseURL + AppURL.Clinician_Management + "\(CaseList.savedUser()!.case_id)/", parameter: param, isGet: false)
                }
            }
        } else {
            showAlert("No internet connection")
        }
    }
    
    @IBAction func btnCaseCompletedClicked(_ sender: UIButton) {
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
    
    func clearSelectionButtons(btn1: UIButton, btn2: UIButton) {
        
        btn1.isSelected = false
        btn2.isSelected = false
    }
    
    // MARK: - Memory Warning -
    
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
