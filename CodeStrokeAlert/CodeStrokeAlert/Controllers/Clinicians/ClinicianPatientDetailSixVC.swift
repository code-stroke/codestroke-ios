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
    }
    
    // MARK: - Action Methods -
    
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
    
    @IBAction func btnNueHeadTraumaClickek(_ sender: UIButton) {
        
        self.clearSelectionButtons(btn1: btnNueHeadNo, btn2: btnNueHeadYes)
        sender.isSelected = true
    }
    
    @IBAction func btnUnControlledHTNClickek(_ sender: UIButton) {
        
        self.clearSelectionButtons(btn1: btnUnControlledHTNNo, btn2: btnUnControlledHTNYes)
        sender.isSelected = true
    }
    
    @IBAction func btnHistoryOfICHClickek(_ sender: UIButton) {
        
        self.clearSelectionButtons(btn1: btnHistoryOfICHNo, btn2: btnHistoryOfICHYes)
        sender.isSelected = true
    }
    
    @IBAction func btnKnownIntracranialClickek(_ sender: UIButton) {
        
        self.clearSelectionButtons(btn1: btnKnownIntracraniaNo, btn2: btnKnownIntracranialYes)
        sender.isSelected = true
    }
    
    @IBAction func btnActiveBleedingClicked(_ sender: UIButton) {
        
        self.clearSelectionButtons(btn1: btnActiveBleedingNo, btn2: btnActiveBleedingYes)
        sender.isSelected = true
    }
    
    @IBAction func btnEndocarditisClicked(_ sender: UIButton) {
        
        self.clearSelectionButtons(btn1: btnEndocarditisYes, btn2: btnEndocarditisNo)
        sender.isSelected = true
    }
    
    @IBAction func btnKnownBleedingDiathesisClicked(_ sender: UIButton) {
        
        self.clearSelectionButtons(btn1: btnKnownBleedingDiathesisNo, btn2: btnKnownBleedingDiathesisYes)
        sender.isSelected = true
    }
    
    @IBAction func btnAbnormalBloodGlucoseClicked(_ sender: UIButton) {
        
        self.clearSelectionButtons(btn1: btnAbnormalBloodGlucoseNo, btn2: btnAbnormalBloodGlucoseYes)
        sender.isSelected = true
    }

    @IBAction func btnRapidlyImprovingClicked(_ sender: UIButton) {
        
        self.clearSelectionButtons(btn1: btnRapidlyImprovingNo, btn2: btnRapidlyImprovingYes)
        sender.isSelected = true
    }
    
    @IBAction func btnRecentTraumaOrSurgeryClicked(_ sender: UIButton) {
        
        self.clearSelectionButtons(btn1: btnRecentTraumaSurgeryNo, btn2: btnRecentTraumaSurgeryYes)
        sender.isSelected = true
    }
    
    @IBAction func btnRecentActiveBleedingClicked(_ sender: UIButton) {
        
        self.clearSelectionButtons(btn1: btnRecentActiveBleedingNo, btn2: btnRecentActiveBleedingYes)
        sender.isSelected = true
    }
    
    @IBAction func btnSeizureAtOnsetClicked(_ sender: UIButton) {
        
        self.clearSelectionButtons(btn1: btnSeizureAtOnsetNo, btn2: btnSeizureAtOnsetYes)
        sender.isSelected = true
    }
    
    @IBAction func btnRecentArterialPunctureClicked(_ sender: UIButton) {
        
        self.clearSelectionButtons(btn1: btnRecenntArterialPunctureNo, btn2: btnRecenntArterialPunctureYes)
        sender.isSelected = true
    }
    
    @IBAction func btnRecentLumbarPuntureClicked(_ sender: UIButton) {
        
        self.clearSelectionButtons(btn1: bntRecentLumbarPunctureYes, btn2: bntRecentLumbarPunctureNo)
        sender.isSelected = true
    }
    
    @IBAction func btnPostACSPericarditisClicked(_ sender: UIButton) {
        
        self.clearSelectionButtons(btn1: btnPostACSPericarditisNo, btn2: btnPostACSPericarditisYes)
        sender.isSelected = true
    }
    
    @IBAction func btnPregnantClicked(_ sender: UIButton) {
        
        self.clearSelectionButtons(btn1: btnPregnantNo, btn2: btnPregnantYes)
        sender.isSelected = true
    }
    
    @IBAction func btnTimeWhenThrombolysisGivenClicked(_ sender: UIButton) {
        
        self.clearSelectionButtons(btn1: btnTimeWhenThrombolysisNNo, btn2: btnTimeWhenThrombolysisYes)
        sender.isSelected = true
    }
    
    @IBAction func btnECSClicked(_ sender: UIButton) {
        
        self.clearSelectionButtons(btn1: btnECRNo, btn2: btnECRYes)
        sender.isSelected = true
    }
    
    @IBAction func btnSurgicalManagementClicked(_ sender: UIButton) {
        
        self.clearSelectionButtons(btn1: btnSurgicalManagementNo, btn2: btnSurgicalManagementYes)
        sender.isSelected = true
    }
    
    @IBAction func btnConservativeManagementClicked(_ sender: UIButton) {
        
        self.clearSelectionButtons(btn1: btnConservativeManagementNo, btn2: btnConservativeManagementYes)
        sender.isSelected = true
    }
    
    // MARK: - Custom Methods -
    
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
