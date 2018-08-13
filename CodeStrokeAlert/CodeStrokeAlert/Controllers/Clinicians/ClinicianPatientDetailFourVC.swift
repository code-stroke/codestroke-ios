//
//  ClinicianPatientDetailFourVC.swift
//  CodeStrokeAlert
//
//  Created by Jayesh on 27/06/18.
//  Copyright © 2018 Jayesh. All rights reserved.
//

import UIKit

class ClinicianPatientDetailFourVC: UIViewController {
    
    // MARK: - Declarations -
    
    @IBOutlet weak var btnFacialDropYes: UIButton!
    @IBOutlet weak var btnFacialDropNo: UIButton!
    @IBOutlet weak var btnFacialDropUnknown: UIButton!
    
    @IBOutlet weak var btnArmDriftYes: UIButton!
    @IBOutlet weak var btnArmDriftNo: UIButton!
    @IBOutlet weak var btnArmDriftUnknown: UIButton!
    
    @IBOutlet weak var btnWeakGripYes: UIButton!
    @IBOutlet weak var btnWeakGripNo: UIButton!
    @IBOutlet weak var btnWeakGripUnknown: UIButton!
    
    @IBOutlet weak var btnSpeechDifficultyYes: UIButton!
    @IBOutlet weak var btnSpeechDifficultyNo: UIButton!
    @IBOutlet weak var btnSpeechDifficultyUnknown: UIButton!
    
    @IBOutlet weak var txtWeight: UITextField!
    @IBOutlet weak var txtHeartRate: UITextField!
    @IBOutlet weak var txtRespiratoryRate: UITextField!
    @IBOutlet weak var txtOxygenSaturation: UITextField!
    @IBOutlet weak var txtTemperature: UITextField!
    @IBOutlet weak var txtBloodGlucose: UITextField!
    @IBOutlet weak var txtGCS: UITextField!
    
    @IBOutlet weak var btnRegular: UIButton!
    @IBOutlet weak var btnIrregular: UIButton!
    
    @IBOutlet weak var txtHeadAndGazeDeviation: DesignableTextField!
    @IBOutlet weak var txtArmMotorImpairment: DesignableTextField!
    @IBOutlet weak var txtLegMotorImpairment: DesignableTextField!
    @IBOutlet weak var txtFacialPalsy: DesignableTextField!
    
    @IBOutlet weak var btn18GIVYes: UIButton!
    @IBOutlet weak var btn18GIVNo: UIButton!
    
    @IBOutlet weak var segmentHemiparesis: UISegmentedControl!
    
    @IBOutlet weak var txtLevelOfConsciousness: DesignableTextField!
    @IBOutlet weak var txtMonthAndAge: DesignableTextField!
    @IBOutlet weak var txtBlinkEye: DesignableTextField!
    @IBOutlet weak var txtHorizontalGaze: DesignableTextField!
    @IBOutlet weak var txtVisualFields: DesignableTextField!
    @IBOutlet weak var txtNIHSS_Facial_Palsy: DesignableTextField!
    @IBOutlet weak var txtLeftArmDrift: DesignableTextField!
    @IBOutlet weak var txtRightArmDrift: DesignableTextField!
    @IBOutlet weak var txtLeftLegDrift: DesignableTextField!
    @IBOutlet weak var txtRightLegDrift: DesignableTextField!
    @IBOutlet weak var txtLimbAtaxia: DesignableTextField!
    @IBOutlet weak var txtSensation: DesignableTextField!
    @IBOutlet weak var txtAlphasia: DesignableTextField!
    @IBOutlet weak var txtDysarthria: DesignableTextField!
    @IBOutlet weak var txtExtinction: DesignableTextField!
    
    @IBOutlet weak var txtLevelOfConsciousness_Rankin: DesignableTextField!
    
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnLikelyLVO: UIButton!
    
    var selected_FacialPalsy = 0
    var selected_ArmMotorImp = 0
    var selected_LegMotorImp = 0
    var selected_HeadGaze = 0
    var selected_LevelCons = 0
    var selected_MonthAge = 0
    var selected_BlinnkEye = 0
    var selected_HorizontalGaze = 0
    var selected_VisualPalsy = 0
    var selected_FacialPalsy_NIHSS = 0
    var selected_LeftArmDrift = 0
    var selected_LeftLegDrift = 0
    var selected_RightArmDrift = 0
    var selected_RightLegDrift = 0
    var selected_LimbAtaxia = 0
    var selected_Sensation = 0
    var selected_Aphasia = 0
    var selected_Dysarthria = 0
    var selected_Extinction = 0
    var selected_LevelCons_Rankin = 0
    var isLikelyLVO: Bool = false
    
    let arrFacialPalsy          = [["title": "Absent", "value": "0"],["title": "Mild", "value": "1"],["title": "Mod-Severe", "value": "2"]]
    let arrArmMoterImp          = [["title": "Normal-Mild", "value": "0"],["title": "Mod", "value": "1"],["title": "Severe", "value": "2"]]
    let arrLegMoterImp          = [["title": "Normal-Mild", "value": "0"],["title": "Mod", "value": "1"],["title": "Severe", "value": "2"]]
    let arrHeadGaze             = [["title": "Absent", "value": "0"],["title": "Present", "value": "1"]]
    let arrLevelCons            = [["title": "Alert", "value": "0"],["title": "Minor Stimulation", "value": "1"],["title": "Repeated Stimulation", "value": "2"],["title": "Movement to pain", "value": "3"],["title": "Posture or unresponsive", "value": "4"]]
    let arrMonthAge             = [["title": "Both Correct", "value": "0"],["title": "1 Correct", "value": "1"],["title": "0 Correct", "value": "2"]]
    let arrBlinkEye             = [["title": "Both Correct", "value": "0"],["title": "1 Correct", "value": "1"],["title": "0 Correct", "value": "2"]]
    let arrHorizontalGaze       = [["title": "Normal", "value": "0"],["title": "Partial palsy", "value": "1"],["title": "Forced gaze palsy", "value": "2"]]
    let arrVisualPalsy          = [["title": "No loss", "value": "0"],["title": "Partial hemianopia", "value": "1"],["title": "Complete hemianopia", "value": "2"],["title": "Bilateral hemianopia", "value": "3"]]
    let arrFacialPalsy_NIHSS    = [["title": "Normal", "value": "0"],["title": "Minor paralysis", "value": "1"],["title": "Partial paralysis", "value": "2"],["title": "Unilateral/Bilateral complete paralysis", "value": "3"]]
    let arrLeftArmDrift         = [["title": "No drift for 10 seconds", "value": "0"],["title": "Mild drift", "value": "1"],["title": "Drift/some effort against gravity", "value": "2"],["title": "No effort against gravity", "value": "3"],["title": "No movement", "value": "4"]]
    let arrRightArmDrift         = [["title": "No drift for 10 seconds", "value": "0"],["title": "Mild drift", "value": "1"],["title": "Drift/some effort against gravity", "value": "2"],["title": "No effort against gravity", "value": "3"],["title": "No movement", "value": "4"]]
    let arrLeftLegDrift         = [["title": "No drift for 10 seconds", "value": "0"],["title": "Mild drift", "value": "1"],["title": "Drift/some effort against gravity", "value": "2"],["title": "No effort against gravity", "value": "3"],["title": "No movement", "value": "4"]]
    let arrRightLegDrift         = [["title": "No drift for 10 seconds", "value": "0"],["title": "Mild drift", "value": "1"],["title": "Drift/some effort against gravity", "value": "2"],["title": "No effort against gravity", "value": "3"],["title": "No movement", "value": "4"]]
    let arrLimbAtaxia            = [["title": "No ataxia/paralysed/amputation/ unable to understand", "value": "0"],["title": "1 limb", "value": "1"],["title": "2 limbs", "value": "2"]]
    let arrSensation             = [["title": "Normal", "value": "0"],["title": "Mild-moderate loss", "value": "1"],["title": "Complete loss/unresponsive", "value": "2"]]
    let arrAphasia          = [["title": "Normal", "value": "0"],["title": "Mild-moderate", "value": "1"],["title": "Severe(fragmentary expression, unable to identify)", "value": "2"],["title": "Mute/global aphasia/unresponsive", "value": "3"]]
    let arrDysarthria            = [["title": "Normal/intubated", "value": "0"],["title": "Mild-moderate", "value": "1"],["title": "Severe/mute", "value": "2"]]
    let arrExtinction            = [["title": "Normal", "value": "0"],["title": "Inattention to 1 modality/bilaterally", "value": "1"],["title": "Profound neglet/more than 1 modality", "value": "2"]]
    let arrLevelCons_Rankin      = [["title": "No symptoms", "value": "0"],["title": "No disability despite symptoms", "value": "1"],["title": "Slite disability but independent with", "value": "2"],["title": "Moderate disability but able to walk", "value": "3"],["title": "Moderate to severe disability requiring", "value": "4"],["title": "Bidridden", "value": "5"]]
    
    
    
    // MARK: - View Controller Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let image1 = self.gradientWithFrametoImage(frame: btnSubmit.frame, colors: [UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1).cgColor, UIColor(red: 255/255, green: 141/255, blue: 41/255, alpha: 1).cgColor])!
        self.btnSubmit.backgroundColor = UIColor(patternImage: image1)
        
        let image2 = self.gradientWithFrametoImage(frame: btnLikelyLVO.frame, colors: [UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1).cgColor, UIColor(red: 255/255, green: 141/255, blue: 41/255, alpha: 1).cgColor])!
        self.btnLikelyLVO.backgroundColor = UIColor(patternImage: image2)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    // MARK: - Action Methods -
    
    @IBAction func btnTypeClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func btnArmDriftOptClicked(_ sender: UIButton) {
        
        self.btnArmDriftYes.isSelected = false
        self.btnArmDriftNo.isSelected = false
        self.btnArmDriftUnknown.isSelected = false
        sender.isSelected = true
    }
    
    @IBAction func btnFacialDroopOptClicked(_ sender: UIButton) {
        
        self.btnFacialDropYes.isSelected = false
        self.btnFacialDropNo.isSelected = false
        self.btnFacialDropUnknown.isSelected = false
        sender.isSelected = true
    }
    
    @IBAction func btnWeakGripOptClicked(_ sender: UIButton) {
        
        self.btnWeakGripYes.isSelected = false
        self.btnWeakGripNo.isSelected = false
        self.btnWeakGripUnknown.isSelected = false
        sender.isSelected = true
    }
    
    @IBAction func btnSpeechDifficultyOptClicked(_ sender: UIButton) {
        
        self.btnSpeechDifficultyYes.isSelected = false
        self.btnSpeechDifficultyNo.isSelected = false
        self.btnSpeechDifficultyUnknown.isSelected = false
        sender.isSelected = true
    }
    
    @IBAction func btnHeartRythmClicked(_ sender: UIButton) {
        
        self.btnRegular.isSelected = false
        self.btnIrregular.isSelected = false
        
        sender.isSelected = true
    }
    
    @IBAction func btn18GIVCannulaClicked(_ sender: UIButton) {
        
        self.btn18GIVYes.isSelected = false
        self.btn18GIVNo.isSelected = false
        
        sender.isSelected = true
    }
    
    @IBAction func btnLikelyLVOClicked(_ sender: UIButton) {
        
        let actionsheet = UIAlertController(title: "Warning", message: "Are you sure you want to notify staff about a potential LVO?", preferredStyle: UIAlertControllerStyle.alert)
        
        actionsheet.addAction(UIAlertAction(title: "YES", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            self.isLikelyLVO = true
            
            let param = ["likely_lvo": self.isLikelyLVO,
                         "signoff_first_name": LoginUserData.savedUser()!.strFirstName,
                         "signoff_last_name": LoginUserData.savedUser()!.strLastName,
                         "signoff_role": LoginUserData.savedUser()!.strUserRole] as [String : Any]
            
            if Reachability.isConnectedToNetwork() {
                DispatchQueue.global(qos: .background).async {
                    DispatchQueue.main.async {
                        self.WS_Clinician_Assessment(url: AppURL.baseURL + AppURL.Clinician_Assessment + "\(CaseList.savedUser()!.case_id)/", parameter: param, isGet: false)
                    }
                }
            } else {
                showAlert("No internet connection")
            }
        }))
        
        actionsheet.addAction(UIAlertAction(title: "NO", style: UIAlertActionStyle.cancel, handler: { (action) -> Void in
            self.isLikelyLVO = false
        }))
        
        self.present(actionsheet, animated: true, completion: nil)
    }
    
    @IBAction func btnSubmitClicked(_ sender: UIButton) {
        
        let param = ["facial_droop": self.btnFacialDropUnknown.isSelected ? "unknown" : (self.btnFacialDropYes.isSelected ? "yes" : self.btnFacialDropNo.isSelected ? "no" : ""),
                     "arm_drift": self.btnArmDriftUnknown.isSelected ? "unknown" : (self.btnArmDriftYes.isSelected ? "yes" : self.btnArmDriftNo.isSelected ? "no" : ""),
                     "weak_grip": self.btnWeakGripUnknown.isSelected ? "unknown" : (self.btnWeakGripYes.isSelected ? "yes" : self.btnWeakGripNo.isSelected ? "no" : ""),
                     "speech_difficulty": self.btnSpeechDifficultyUnknown.isSelected ? "unknown" : (self.btnSpeechDifficultyYes.isSelected ? "yes" : self.btnSpeechDifficultyNo.isSelected ? "no" : ""),
                     "bp_systolic": 0,
                     "bp_diastolic": 0,
                     "heart_rate": isEmptyString(self.txtHeartRate.text!) ? "" : Int(self.txtHeartRate.text!)!,
                     "heart_rhythm": self.btnRegular.isSelected ? "regular" : self.btnIrregular.isSelected ? "irregular" : "",
                     "rr": isEmptyString(self.txtRespiratoryRate.text!) ? "" : Int(self.txtRespiratoryRate.text!)!,
                     "o2sats": isEmptyString(self.txtOxygenSaturation.text!) ? "" : Int(self.txtOxygenSaturation.text!)!,
                     "temp": isEmptyString(self.txtTemperature.text!) ? "" : Int(self.txtTemperature.text!)!,
                     "gcs": isEmptyString(self.txtGCS.text!) ? "" : Int(self.txtGCS.text!)!,
                     "blood_glucose": isEmptyString(self.txtBloodGlucose.text!) ? "" : Int(self.txtBloodGlucose.text!)!,
                     "arm_motor_impair": isEmptyString(self.txtArmMotorImpairment.text!) ? "" : self.arrArmMoterImp[selected_ArmMotorImp]["value"]!,
                     "leg_motor_impair": isEmptyString(self.txtLegMotorImpairment.text!) ? "" : self.arrLegMoterImp[selected_LegMotorImp]["value"]!,
                     "head_gaze_deviate": isEmptyString(self.txtHeadAndGazeDeviation.text!) ? "" : self.arrHeadGaze[selected_HeadGaze]["value"]!,
                     "hemiparesis": segmentHemiparesis.selectedSegmentIndex == 0 ? "left" : "right",
                     "cannula": self.btn18GIVYes.isSelected ? true : self.btn18GIVNo.isSelected ? false : "",
                     "conscious_level": isEmptyString(self.txtLevelOfConsciousness.text!) ? "" : self.arrLevelCons[selected_LevelCons]["value"]!,
                     "month_age": isEmptyString(self.txtMonthAndAge.text!) ? "" : self.arrMonthAge[selected_MonthAge]["value"]!,
                     "blink_squeeze": isEmptyString(self.txtBlinkEye.text!) ? "" : self.arrBlinkEye[selected_BlinnkEye]["value"]!,
                     "horizontal_gaze": isEmptyString(self.txtHorizontalGaze.text!) ? "" : self.arrHorizontalGaze[selected_HorizontalGaze]["value"]!,
                     "visual_fields": isEmptyString(self.txtVisualFields.text!) ? "" : self.arrVisualPalsy[selected_VisualPalsy]["value"]!,
                     "facial_palsy_nihss": isEmptyString(self.txtNIHSS_Facial_Palsy.text!) ? "" : self.arrFacialPalsy_NIHSS[selected_FacialPalsy_NIHSS]["value"]!,
                     "left_arm_drift": isEmptyString(self.txtLeftArmDrift.text!) ? "" : self.arrLeftArmDrift[selected_LeftArmDrift]["value"]!,
                     "right_arm_drift": isEmptyString(self.txtRightArmDrift.text!) ? "" : self.arrRightArmDrift[selected_RightArmDrift]["value"]!,
                     "left_leg_drift": isEmptyString(self.txtLeftLegDrift.text!) ? "" : self.arrLeftLegDrift[selected_LeftLegDrift]["value"]!,
                     "right_leg_drift": isEmptyString(self.txtRightLegDrift.text!) ? "" : self.arrRightLegDrift[selected_LeftLegDrift]["value"]!,
                     "limb_ataxia": isEmptyString(self.txtLimbAtaxia.text!) ? "" : self.arrLimbAtaxia[selected_LimbAtaxia]["value"]!,
                     "sensation": isEmptyString(self.txtSensation.text!) ? "" : self.arrSensation[selected_Sensation]["value"]!,
                     "aphasia": isEmptyString(self.txtAlphasia.text!) ? "" : self.arrAphasia[selected_Aphasia]["value"]!,
                     "dysarthria": isEmptyString(self.txtDysarthria.text!) ? "" : self.arrDysarthria[selected_Dysarthria]["value"]!,
                     "neglect": isEmptyString(self.txtExtinction.text!) ? "" : self.arrExtinction[selected_Extinction]["value"]!,
                     "rankin_conscious": isEmptyString(self.txtLevelOfConsciousness_Rankin.text!) ? "" : self.arrLevelCons_Rankin[selected_LevelCons_Rankin]["value"]!,
                     "likely_lvo": self.isLikelyLVO,
                     "signoff_first_name": LoginUserData.savedUser()!.strFirstName,
                     "signoff_last_name": LoginUserData.savedUser()!.strLastName,
                     "signoff_role": LoginUserData.savedUser()!.strUserRole] as [String : Any]
        
        if Reachability.isConnectedToNetwork() {
            DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.async {
                    self.WS_Clinician_Assessment(url: AppURL.baseURL + AppURL.Clinician_Assessment + "\(CaseList.savedUser()!.case_id)/", parameter: param, isGet: false)
                }
            }
        } else {
            showAlert("No internet connection")
        }
    }
    
    // MARK: - Custom Methods -
    
    func WS_Clinician_Assessment_Call() {
        
        if Reachability.isConnectedToNetwork() {
            DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.async {
                    self.WS_Clinician_Assessment(url: AppURL.baseURL + AppURL.Clinician_Assessment + "\(CaseList.savedUser()!.case_id)/", parameter: [:], isGet: true)
                }
            }
        } else {
            showAlert("No internet connection")
        }
    }
    
    func clearAllSelectionAndSelectedItem(btn1: UIButton, btn1Selected: Bool, btn2: UIButton, btn2Selected: Bool, btn3: UIButton, btn3Selected: Bool) {
        
        btn1.isSelected = btn1Selected
        btn2.isSelected = btn2Selected
        btn3.isSelected = btn3Selected
    }
    
    func clearAllSelectionAndSelectedItem2(btn1: UIButton, btn1Selected: Bool, btn2: UIButton, btn2Selected: Bool) {
        
        btn1.isSelected = btn1Selected
        btn2.isSelected = btn2Selected
    }
    
    func clearSelectedItems() {
        
        self.txtFacialPalsy.isSelected = false
        self.txtArmMotorImpairment.isSelected = false
        self.txtLegMotorImpairment.isSelected = false
        self.txtHeadAndGazeDeviation.isSelected = false
        self.txtLevelOfConsciousness.isSelected = false
        self.txtMonthAndAge.isSelected = false
        self.txtBlinkEye.isSelected = false
        self.txtHorizontalGaze.isSelected = false
        self.txtVisualFields.isSelected = false
        self.txtNIHSS_Facial_Palsy.isSelected = false
        self.txtLeftArmDrift.isSelected = false
        self.txtRightArmDrift.isSelected = false
        self.txtLeftLegDrift.isSelected = false
        self.txtRightLegDrift.isSelected = false
        self.txtLimbAtaxia.isSelected = false
        self.txtSensation.isSelected = false
        self.txtAlphasia.isSelected = false
        self.txtDysarthria.isSelected = false
        self.txtExtinction.isSelected = false
        self.txtLevelOfConsciousness_Rankin.isSelected = false
    }
    
    func openPickerViewController() {
        
        self.tabBarController?.tabBar.isHidden = true
        
        let style = RMActionControllerStyle.white
        
        let selectAction = RMAction<UIPickerView>(title: "Select", style: .done) { controller in
            
            if self.txtFacialPalsy.isSelected == true {
                self.txtFacialPalsy.text = self.arrFacialPalsy[self.selected_FacialPalsy]["title"]
            } else if self.txtArmMotorImpairment.isSelected == true {
                self.txtArmMotorImpairment.text = self.arrArmMoterImp[self.selected_ArmMotorImp]["title"]
            } else if self.txtLegMotorImpairment.isSelected == true {
                self.txtLegMotorImpairment.text = self.arrLegMoterImp[self.selected_LegMotorImp]["title"]
            } else if self.txtHeadAndGazeDeviation.isSelected == true {
                self.txtHeadAndGazeDeviation.text = self.arrHeadGaze[self.selected_HeadGaze]["title"]
            } else if self.txtLevelOfConsciousness.isSelected == true {
                self.txtLevelOfConsciousness.text = self.arrLevelCons[self.selected_LevelCons]["title"]
            } else if self.txtMonthAndAge.isSelected == true {
                self.txtMonthAndAge.text = self.arrMonthAge[self.selected_MonthAge]["title"]
            } else if self.txtBlinkEye.isSelected == true {
                self.txtBlinkEye.text = self.arrBlinkEye[self.selected_BlinnkEye]["title"]
            } else if self.txtHorizontalGaze.isSelected == true {
                self.txtHorizontalGaze.text = self.arrHorizontalGaze[self.selected_HorizontalGaze]["title"]
            } else if self.txtVisualFields.isSelected == true {
                self.txtVisualFields.text = self.arrVisualPalsy[self.selected_VisualPalsy]["title"]
            } else if self.txtNIHSS_Facial_Palsy.isSelected == true {
                self.txtNIHSS_Facial_Palsy.text = self.arrFacialPalsy_NIHSS[self.selected_FacialPalsy_NIHSS]["title"]
            } else if self.txtLeftArmDrift.isSelected == true {
                self.txtLeftArmDrift.text = self.arrLeftArmDrift[self.selected_LeftArmDrift]["title"]
            } else if self.txtRightArmDrift.isSelected == true {
                self.txtRightArmDrift.text = self.arrRightArmDrift[self.selected_RightArmDrift]["title"]
            } else if self.txtLeftLegDrift.isSelected == true {
                self.txtLeftLegDrift.text = self.arrLeftLegDrift[self.selected_LeftLegDrift]["title"]
            } else if self.txtRightLegDrift.isSelected == true {
                self.txtRightLegDrift.text = self.arrRightLegDrift[self.selected_RightLegDrift]["title"]
            } else if self.txtLimbAtaxia.isSelected == true {
                self.txtLimbAtaxia.text = self.arrLimbAtaxia[self.selected_LimbAtaxia]["title"]
            } else if self.txtSensation.isSelected == true {
                self.txtSensation.text = self.arrSensation[self.selected_Sensation]["title"]
            } else if self.txtAlphasia.isSelected == true {
                self.txtAlphasia.text = self.arrAphasia[self.selected_Aphasia]["title"]
            } else if self.txtDysarthria.isSelected == true {
                self.txtDysarthria.text = self.arrDysarthria[self.selected_Dysarthria]["title"]
            } else if self.txtExtinction.isSelected == true {
                self.txtExtinction.text = self.arrExtinction[self.selected_Extinction]["title"]
            } else  {
                self.txtLevelOfConsciousness_Rankin.text = self.arrLevelCons_Rankin[self.selected_LevelCons_Rankin]["title"]
            }
        }
        
        let cancelAction = RMAction<UIPickerView>(title: "Cancel", style: .cancel) { _ in
            
            self.tabBarController?.tabBar.isHidden = false
        }
        
        let strTitle = "Code Stroke Alert"
        let strMessage = "Please select from least"
        
        let actionController = RMPickerViewController(style: style, title: strTitle, message: strMessage, select: selectAction, andCancel: cancelAction)!;
        
        actionController.picker.delegate = self
        actionController.picker.dataSource = self
        
        present(actionController, animated: true, completion: nil)
    }
    
    // MARK: - Memory Warning -
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation -
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ClinicianPatientDetailFive" {
            
            let destination = segue.destination as! ClinicianPatientDetailFiveVC
            print(destination)
        }
    }
}

// MARK: - UITextField Delegate -

extension ClinicianPatientDetailFourVC: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        self.clearSelectedItems()
        textField.isSelected = true
        self.openPickerViewController()
        return false
    }
}

extension ClinicianPatientDetailFourVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if self.txtFacialPalsy.isSelected == true {
            return self.arrFacialPalsy.count
        } else if self.txtArmMotorImpairment.isSelected == true {
            return self.arrArmMoterImp.count
        } else if self.txtLegMotorImpairment.isSelected == true {
            return self.arrLegMoterImp.count
        } else if self.txtHeadAndGazeDeviation.isSelected == true {
            return self.arrHeadGaze.count
        } else if self.txtLevelOfConsciousness.isSelected == true {
            return self.arrLevelCons.count
        } else if self.txtMonthAndAge.isSelected == true {
            return self.arrMonthAge.count
        } else if self.txtBlinkEye.isSelected == true {
            return self.arrBlinkEye.count
        } else if self.txtHorizontalGaze.isSelected == true {
            return self.arrHorizontalGaze.count
        } else if self.txtVisualFields.isSelected == true {
            return self.arrVisualPalsy.count
        } else if self.txtNIHSS_Facial_Palsy.isSelected == true {
            return self.arrFacialPalsy_NIHSS.count
        } else if self.txtLeftArmDrift.isSelected == true {
            return self.arrLeftArmDrift.count
        } else if self.txtRightArmDrift.isSelected == true {
            return self.arrRightArmDrift.count
        } else if self.txtLeftLegDrift.isSelected == true {
            return self.arrLeftLegDrift.count
        } else if self.txtRightLegDrift.isSelected == true {
            return self.arrRightLegDrift.count
        } else if self.txtLimbAtaxia.isSelected == true {
            return self.arrLimbAtaxia.count
        } else if self.txtSensation.isSelected == true {
            return self.arrSensation.count
        } else if self.txtAlphasia.isSelected == true {
            return self.arrAphasia.count
        } else if self.txtDysarthria.isSelected == true {
            return self.arrDysarthria.count
        } else if self.txtExtinction.isSelected == true {
            return self.arrExtinction.count
        } else  {
            return self.arrLevelCons_Rankin.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if self.txtFacialPalsy.isSelected == true {
            return self.arrFacialPalsy[row]["title"]
        } else if self.txtArmMotorImpairment.isSelected == true {
            return self.arrArmMoterImp[row]["title"]
        } else if self.txtLegMotorImpairment.isSelected == true {
            return self.arrLegMoterImp[row]["title"]
        } else if self.txtHeadAndGazeDeviation.isSelected == true {
            return self.arrHeadGaze[row]["title"]
        } else if self.txtLevelOfConsciousness.isSelected == true {
            return self.arrLevelCons[row]["title"]
        } else if self.txtMonthAndAge.isSelected == true {
            return self.arrMonthAge[row]["title"]
        } else if self.txtBlinkEye.isSelected == true {
            return self.arrBlinkEye[row]["title"]
        } else if self.txtHorizontalGaze.isSelected == true {
            return self.arrHorizontalGaze[row]["title"]
        } else if self.txtVisualFields.isSelected == true {
            return self.arrVisualPalsy[row]["title"]
        } else if self.txtNIHSS_Facial_Palsy.isSelected == true {
            return self.arrFacialPalsy_NIHSS[row]["title"]
        } else if self.txtLeftArmDrift.isSelected == true {
            return self.arrLeftArmDrift[row]["title"]
        } else if self.txtRightArmDrift.isSelected == true {
            return self.arrRightArmDrift[row]["title"]
        } else if self.txtLeftLegDrift.isSelected == true {
            return self.arrLeftLegDrift[row]["title"]
        } else if self.txtRightLegDrift.isSelected == true {
            return self.arrRightLegDrift[row]["title"]
        } else if self.txtLimbAtaxia.isSelected == true {
            return self.arrLimbAtaxia[row]["title"]
        } else if self.txtSensation.isSelected == true {
            return self.arrSensation[row]["title"]
        } else if self.txtAlphasia.isSelected == true {
            return self.arrAphasia[row]["title"]
        } else if self.txtDysarthria.isSelected == true {
            return self.arrDysarthria[row]["title"]
        } else if self.txtExtinction.isSelected == true {
            return self.arrExtinction[row]["title"]
        } else  {
            return self.arrLevelCons_Rankin[row]["title"]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if self.txtFacialPalsy.isSelected == true {
            self.selected_FacialPalsy = row
        } else if self.txtArmMotorImpairment.isSelected == true {
            self.selected_ArmMotorImp = row
        } else if self.txtLegMotorImpairment.isSelected == true {
            self.selected_LegMotorImp = row
        } else if self.txtHeadAndGazeDeviation.isSelected == true {
            self.selected_HeadGaze = row
        } else if self.txtLevelOfConsciousness.isSelected == true {
            self.selected_LevelCons = row
        } else if self.txtMonthAndAge.isSelected == true {
            self.selected_MonthAge = row
        } else if self.txtBlinkEye.isSelected == true {
            self.selected_BlinnkEye = row
        } else if self.txtHorizontalGaze.isSelected == true {
            self.selected_HorizontalGaze = row
        } else if self.txtVisualFields.isSelected == true {
            self.selected_VisualPalsy = row
        } else if self.txtNIHSS_Facial_Palsy.isSelected == true {
            self.selected_FacialPalsy_NIHSS = row
        } else if self.txtLeftArmDrift.isSelected == true {
            self.selected_LeftArmDrift = row
        } else if self.txtRightArmDrift.isSelected == true {
            self.selected_RightArmDrift = row
        } else if self.txtLeftLegDrift.isSelected == true {
            self.selected_LeftLegDrift = row
        } else if self.txtRightLegDrift.isSelected == true {
            self.selected_RightLegDrift = row
        } else if self.txtLimbAtaxia.isSelected == true {
            self.selected_LimbAtaxia = row
        } else if self.txtSensation.isSelected == true {
            self.selected_Sensation = row
        } else if self.txtAlphasia.isSelected == true {
            self.selected_Aphasia = row
        } else if self.txtDysarthria.isSelected == true {
            self.selected_Dysarthria = row
        } else if self.txtExtinction.isSelected == true {
            self.selected_Extinction = row
        } else  {
            self.selected_LevelCons_Rankin = row
        }
    }
}
