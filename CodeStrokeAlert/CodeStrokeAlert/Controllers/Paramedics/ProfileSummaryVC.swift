//
//  ProfileSummaryVC.swift
//  CodeStrokeAlert
//
//  Created by Jayesh on 19/06/18.
//  Copyright © 2018 Jayesh. All rights reserved.
//

import UIKit

class ProfileSummaryVC: UIViewController {
    
    @IBOutlet weak var height_Detail: NSLayoutConstraint!
    @IBOutlet weak var height_History: NSLayoutConstraint!
    @IBOutlet weak var height_Mass: NSLayoutConstraint!
    @IBOutlet weak var height_Vitals: NSLayoutConstraint!
    @IBOutlet weak var height_Race: NSLayoutConstraint!
    @IBOutlet weak var height_18GIV: NSLayoutConstraint!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblLastSeen: UILabel!
    @IBOutlet weak var lblNok: UILabel!
    @IBOutlet weak var lblNOKContact: UILabel!
    
    @IBOutlet weak var lblPastMedicalHistory: UILabel!
    @IBOutlet weak var lblMedication: UILabel!
    @IBOutlet weak var lblAnticoagulants: UILabel!
    @IBOutlet weak var lblLastDose: UILabel!
    @IBOutlet weak var lblSituation: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    
    @IBOutlet weak var lblFacialDroop: UILabel!
    @IBOutlet weak var lblArmDrift: UILabel!
    @IBOutlet weak var lblWeakGrip: UILabel!
    @IBOutlet weak var lblSpeechDifficulty: UILabel!
    
    @IBOutlet weak var lblBloodPressure: UILabel!
    @IBOutlet weak var lblHeartRate: UILabel!
    @IBOutlet weak var lblHearRhythm: UILabel!
    @IBOutlet weak var lblRespiratoryRate: UILabel!
    @IBOutlet weak var lblOxygenSaturation: UILabel!
    @IBOutlet weak var lblTemperature: UILabel!
    @IBOutlet weak var lblBloodGlucose: UILabel!
    @IBOutlet weak var lblGCS: UILabel!
    
    @IBOutlet weak var btnRace: UIButton!
    @IBOutlet weak var btn18GIV: UIButton!
    
    // MARK:- ViewController LifeCycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.title = "Profile Summary"
        
        self.lblName.text = PatientDetailData.savedUser()!.strName
        self.lblAge.text = PatientDetailData.savedUser()!.strAge
        self.lblGender.text = PatientDetailData.savedUser()!.strGender
        self.lblAddress.text = PatientDetailData.savedUser()!.strAddress
        self.lblLastSeen.text = PatientDetailData.savedUser()!.strLastSeen
        self.lblNok.text = PatientDetailData.savedUser()!.strNok
        self.lblNOKContact.text = PatientDetailData.savedUser()!.strNOKContact
        
        self.lblPastMedicalHistory.text = ClinicalHistoryData.savedUser()!.strPostMedicalHistory
        self.lblMedication.text = ClinicalHistoryData.savedUser()!.strMedications
        self.lblAnticoagulants.text = "\(ClinicalHistoryData.savedUser()!.strAnticoagulants)"
        self.lblLastDose.text = ClinicalHistoryData.savedUser()!.strLastDostDate
        self.lblSituation.text = ClinicalHistoryData.savedUser()!.strSituation
        self.lblWeight.text = "\(ClinicalHistoryData.savedUser()!.strWeight)"
        
        self.lblFacialDroop.text = ClinicalAssessmentData.savedUser()!.strFacialDroop
        self.lblArmDrift.text = ClinicalAssessmentData.savedUser()!.strArm_Drift
        self.lblWeakGrip.text = ClinicalAssessmentData.savedUser()!.strWeak_Grip
        self.lblSpeechDifficulty.text = ClinicalAssessmentData.savedUser()!.strSpeechDifficulty
        
        self.lblBloodPressure.text = ClinicalAssessmentTwoData.savedUser()!.strBlood_Pressure
        self.lblHeartRate.text = ClinicalAssessmentTwoData.savedUser()!.strHeart_Rate
        self.lblHearRhythm.text = ClinicalAssessmentTwoData.savedUser()!.strHeart_Rhythm
        self.lblRespiratoryRate.text = ClinicalAssessmentTwoData.savedUser()!.strRespiratory_Rate
        self.lblOxygenSaturation.text = ClinicalAssessmentTwoData.savedUser()!.strOxygen_Saturation
        self.lblTemperature.text = ClinicalAssessmentTwoData.savedUser()!.strTemperature
        self.lblBloodGlucose.text = ClinicalAssessmentTwoData.savedUser()!.strBlood_Glucose
        self.lblGCS.text = ClinicalAssessmentTwoData.savedUser()!.strGCS
        
        let strRace = Int(ClinicalAssessmentThreeData.savedUser()!.strArm_Motor_Impair)! + Int(ClinicalAssessmentThreeData.savedUser()!.strLeg_Motor_Impair)! + Int(ClinicalAssessmentThreeData.savedUser()!.strFacial_Palsy_Race)! + Int(ClinicalAssessmentThreeData.savedUser()!.strHead_Gaze_Deviate)!
        
        self.btnRace.setTitle("\(strRace)", for: .normal)
        
        let strCannula = UserDefaults.standard.value(forKey: "cannula") as! String
        
        self.btn18GIV.setTitle(strCannula, for: .normal)
    }
    
    // MARK:- Action Methods -
    
    @IBAction func btnProfileItemClicked(_ sender: DesignableButton) {
        
        if sender.isSelected == false {
            
            sender.isSelected = true
            
            if sender.tag == 1 {
                UIView.animate(withDuration: 0.22) {
                    self.height_Detail.constant = 285
                    self.view.layoutIfNeeded()
                }
            } else if sender.tag == 2 {
                UIView.animate(withDuration: 0.22) {
                    self.height_History.constant = 250
                    self.view.layoutIfNeeded()
                }
            } else if sender.tag == 3 {
                UIView.animate(withDuration: 0.22) {
                    self.height_Mass.constant = 180
                    self.view.layoutIfNeeded()
                }
            } else if sender.tag == 4 {
                UIView.animate(withDuration: 0.22) {
                    self.height_Vitals.constant = 310
                    self.view.layoutIfNeeded()
                }
            }
            
        } else {
            
            sender.isSelected = false
            
            if sender.tag == 1 {
                UIView.animate(withDuration: 0.22) {
                    self.height_Detail.constant = 50
                    self.view.layoutIfNeeded()
                }
            } else if sender.tag == 2 {
                UIView.animate(withDuration: 0.22) {
                    self.height_History.constant = 50
                    self.view.layoutIfNeeded()
                }
            } else if sender.tag == 3 {
                UIView.animate(withDuration: 0.22) {
                    self.height_Mass.constant = 50
                    self.view.layoutIfNeeded()
                }
            } else if sender.tag == 4 {
                UIView.animate(withDuration: 0.22) {
                    self.height_Vitals.constant = 50
                    self.view.layoutIfNeeded()
                }
            } else if sender.tag == 5 {
                UIView.animate(withDuration: 0.22) {
                    self.height_Race.constant = 50
                    self.view.layoutIfNeeded()
                }
            } else if sender.tag == 6 {
                UIView.animate(withDuration: 0.22) {
                    self.height_18GIV.constant = 50
                    self.view.layoutIfNeeded()
                }
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
