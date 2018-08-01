
//
//  ClinicalAssessmentFourVC.swift
//  CodeStrokeAlert
//
//  Created by Jayesh on 19/06/18.
//  Copyright © 2018 Jayesh. All rights reserved.
//

import UIKit

class ClinicalAssessmentFourVC: UIViewController {
    
    // MARK:- Declarations -
    
    @IBOutlet weak var btnNext: DesignableButton!
    
    @IBOutlet weak var btn18GIVYes: UIButton!
    @IBOutlet weak var btn18GIVNo: UIButton!
    @IBOutlet weak var btn18GIVUnknown: DesignableButton!
    
    // MARK: - View Controller LifeCycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.title = "Clinical Assessment"
        
        let image1 = self.gradientWithFrametoImage(frame: btnNext.frame, colors: [UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1).cgColor, UIColor(red: 255/255, green: 141/255, blue: 41/255, alpha: 1).cgColor])!
        self.btnNext.backgroundColor = UIColor(patternImage: image1)
    }
    
    // MARK: - Action Methods -
    
    @IBAction func btnNextClicked(_ sender: DesignableButton) {
        
        if btn18GIVYes.isSelected {
            UserDefaults.standard.set("true", forKey: "cannula")
        } else if btn18GIVNo.isSelected {
            UserDefaults.standard.set("false", forKey: "cannula")
        } else {
            UserDefaults.standard.set("NULL", forKey: "cannula")
        }
        
        let param = ["facial_droop": ClinicalAssessmentData.savedUser()!.strFacialDroop,
                     "arm_drift": ClinicalAssessmentData.savedUser()!.strArm_Drift,
                     "weak_grip": ClinicalAssessmentData.savedUser()!.strWeak_Grip,
                     "speech_difficulty": ClinicalAssessmentData.savedUser()!.strSpeechDifficulty,
                     "bp_systolic": ClinicalAssessmentTwoData.savedUser()!.strBlood_Pressure,
                     "heart_rate": ClinicalAssessmentTwoData.savedUser()!.strHeart_Rate,
                     "heart_rhythm": ClinicalAssessmentTwoData.savedUser()!.strHeart_Rhythm,
                     "rr": ClinicalAssessmentTwoData.savedUser()!.strRespiratory_Rate,
                     "o2sats": ClinicalAssessmentTwoData.savedUser()!.strOxygen_Saturation,
                     "temp": ClinicalAssessmentTwoData.savedUser()!.strTemperature,
                     "gcs": ClinicalAssessmentTwoData.savedUser()!.strGCS,
                     "blood_glucose": ClinicalAssessmentTwoData.savedUser()!.strBlood_Glucose,
                     "facial_palsy_race": ClinicalAssessmentThreeData.savedUser()!.strFacial_Palsy_Race,
                     "arm_motor_impair": ClinicalAssessmentThreeData.savedUser()!.strArm_Motor_Impair,
                     "leg_motor_impair": ClinicalAssessmentThreeData.savedUser()!.strLeg_Motor_Impair,
                     "head_gaze_deviate": ClinicalAssessmentThreeData.savedUser()!.strHead_Gaze_Deviate,
                     "cannula": UserDefaults.standard.value(forKey: "cannula")!] as [String : Any]
        
        if Reachability.isConnectedToNetwork() {
            DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.async {
                    self.WS_ClinicalAssessment(url: AppURL.baseURL + AppURL.CaseAssessment + "\(UserDefaults.standard.integer(forKey: "case_id"))/", parameter: param)
                }
            }
        } else {
            showAlert("No internet connection")
        }
    }
    
    @IBAction func btn18GIVClicked(_ sender: UIButton) {
        
        self.btn18GIVYes.isSelected = false
        self.btn18GIVNo.isSelected = false
        
        sender.isSelected = true
    }
    
    @IBAction func btnUnknownClicked(_ sender: DesignableButton) {
        
        self.btn18GIVYes.isSelected = false
        self.btn18GIVNo.isSelected = false
    }
    
    // MARK: - Memory Warning -
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation -
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ProfileSummery" {
            
            let destination = segue.destination as! ProfileSummaryVC
            print(destination)
        }
    }
}
