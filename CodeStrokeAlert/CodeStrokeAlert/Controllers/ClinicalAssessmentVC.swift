//
//  ClinicalAssessmentVC.swift
//  CodeStrokeAlert
//
//  Created by Jayesh on 19/06/18.
//  Copyright © 2018 Jayesh. All rights reserved.
//

import UIKit
import EVReflection

let kClinicalAssessmentData = "ClinicalAssessmentData"

class ClinicalAssessmentData: EVObject {
    
    var strFacialDroop: String          = ""
    var strArm_Drift: String            = ""
    var strWeak_Grip: String            = ""
    var strSpeechDifficulty: String     = ""
    
    func save() {
        
        let defaults: UserDefaults = UserDefaults.standard
        let data: NSData = NSKeyedArchiver.archivedData(withRootObject: self) as NSData
        defaults.set(data, forKey: kClinicalAssessmentData)
        defaults.synchronize()
    }
    
    class func savedUser() -> ClinicalAssessmentData? {
        
        let defaults: UserDefaults = UserDefaults.standard
        let data = defaults.object(forKey: kClinicalAssessmentData) as? NSData
        
        if data != nil {
            
            if let userinfo = NSKeyedUnarchiver.unarchiveObject(with: data! as Data) as? ClinicalAssessmentData {
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
        defaults.removeObject(forKey: kClinicalAssessmentData)
        defaults.synchronize()
    }
}

class ClinicalAssessmentVC: UIViewController {

    // MARK:- Declarations -
    
    @IBOutlet weak var btnNext: DesignableButton!
    
    @IBOutlet weak var btnFacialDropYes: UIButton!
    @IBOutlet weak var btnFacialDropNo: UIButton!
    
    @IBOutlet weak var btnArmDriftYes: UIButton!
    @IBOutlet weak var btnArmDriftNo: UIButton!
    
    @IBOutlet weak var btnWeakGripYes: UIButton!
    @IBOutlet weak var btnWeakGripNo: UIButton!
    
    @IBOutlet weak var btnSpeechDifficultyYes: UIButton!
    @IBOutlet weak var btnSpeechDifficultyNo: UIButton!

    @IBOutlet weak var btnFacialDroopUnknown: DesignableButton!
    @IBOutlet weak var btnnArmDriftUnknown: DesignableButton!
    @IBOutlet weak var btnWeakGripUnknown: DesignableButton!
    @IBOutlet weak var btnSpeechDifficultyUnknown: DesignableButton!
    
    var clinicalAssessmentData = ClinicalAssessmentData()
    
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
        
        clinicalAssessmentData.strFacialDroop = self.btnFacialDroopUnknown.isSelected ? "unknown" : (self.btnFacialDropYes.isSelected ? "yes" : "no")
        clinicalAssessmentData.strArm_Drift = self.btnnArmDriftUnknown.isSelected ? "unknown" : (self.btnArmDriftYes.isSelected ? "yes" : "no")
        clinicalAssessmentData.strWeak_Grip = self.btnWeakGripUnknown.isSelected ? "unknown" : (self.btnWeakGripYes.isSelected ? "yes" : "no")
        clinicalAssessmentData.strSpeechDifficulty = self.btnSpeechDifficultyUnknown.isSelected ? "unknown" : (self.btnSpeechDifficultyYes.isSelected ? "yes" : "no")
        
        clinicalAssessmentData.save()
        print(ClinicalAssessmentData.savedUser()!) 
        self.performSegue(withIdentifier: "ClinicalAssessmentTwo", sender: self)
    }
    
    @IBAction func btnUnknownClicked(_ sender: DesignableButton) {
        
        if sender.tag == 1 {
            self.btnFacialDropYes.isSelected = false
            self.btnFacialDropNo.isSelected = false
        } else if sender.tag == 2 {
            self.btnArmDriftYes.isSelected = false
            self.btnArmDriftNo.isSelected = false
        } else if sender.tag == 3 {
            self.btnWeakGripYes.isSelected = false
            self.btnWeakGripNo.isSelected = false
        } else if sender.tag == 4 {
            self.btnSpeechDifficultyYes.isSelected = false
            self.btnSpeechDifficultyNo.isSelected = false
        }
        
        if sender.isSelected {
            sender.isSelected = false
            sender.backgroundColor = UIColor.init(red: 197.0/255.0, green: 210.0/255.0, blue: 216.0/255.0, alpha: 1.0)
        } else {
            sender.isSelected = true
            sender.backgroundColor = UIColor.init(red: 43.0/255.0, green: 143.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        }
    }
    
    @IBAction func btnArmDriftOptClicked(_ sender: UIButton) {
        
        self.btnArmDriftYes.isSelected = false
        self.btnArmDriftNo.isSelected = false
        self.btnnArmDriftUnknown.isSelected = false
        self.btnnArmDriftUnknown.backgroundColor = UIColor.init(red: 197.0/255.0, green: 210.0/255.0, blue: 216.0/255.0, alpha: 1.0)
        sender.isSelected = true
    }
    
    @IBAction func btnFacialDroopOptClicked(_ sender: UIButton) {
        
        self.btnFacialDropYes.isSelected = false
        self.btnFacialDropNo.isSelected = false
        self.btnFacialDroopUnknown.isSelected = false
        self.btnFacialDroopUnknown.backgroundColor = UIColor.init(red: 197.0/255.0, green: 210.0/255.0, blue: 216.0/255.0, alpha: 1.0)
        sender.isSelected = true
    }
    
    @IBAction func btnWeakGripOptClicked(_ sender: UIButton) {
        
        self.btnWeakGripYes.isSelected = false
        self.btnWeakGripNo.isSelected = false
        self.btnWeakGripUnknown.isSelected = false
        self.btnWeakGripUnknown.backgroundColor = UIColor.init(red: 197.0/255.0, green: 210.0/255.0, blue: 216.0/255.0, alpha: 1.0)
        sender.isSelected = true
    }
    
    @IBAction func btnSpeechDifficultyOptClicked(_ sender: UIButton) {
        
        self.btnSpeechDifficultyYes.isSelected = false
        self.btnSpeechDifficultyNo.isSelected = false
        self.btnSpeechDifficultyUnknown.isSelected = false
        self.btnSpeechDifficultyUnknown.backgroundColor = UIColor.init(red: 197.0/255.0, green: 210.0/255.0, blue: 216.0/255.0, alpha: 1.0)
        sender.isSelected = true
    }
    
    // MARK: - Memory Warning -
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation -

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ClinicalAssessmentTwo" {
            
            let destination = segue.destination as! ClinicalAssessmentTwoVC
            print(destination)
        }
    }
}
