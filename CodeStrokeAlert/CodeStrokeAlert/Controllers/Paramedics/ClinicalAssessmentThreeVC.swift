//
//  ClinicalAssessmentThreeVC.swift
//  CodeStrokeAlert
//
//  Created by Jayesh on 19/06/18.
//  Copyright © 2018 Jayesh. All rights reserved.
//

import UIKit
import EVReflection

let kClinicalAssessmentThreeData = "ClinicalAssessmentThreeData"

class ClinicalAssessmentThreeData: EVObject {
    
    var strFacial_Palsy_Race: String            = ""
    var strArm_Motor_Impair: String             = ""
    var strLeg_Motor_Impair: String             = ""
    var strHead_Gaze_Deviate: String            = ""
    
    func save() {
        
        let defaults: UserDefaults = UserDefaults.standard
        let data: NSData = NSKeyedArchiver.archivedData(withRootObject: self) as NSData
        defaults.set(data, forKey: kClinicalAssessmentThreeData)
        defaults.synchronize()
    }
    
    class func savedUser() -> ClinicalAssessmentThreeData? {
        
        let defaults: UserDefaults = UserDefaults.standard
        let data = defaults.object(forKey: kClinicalAssessmentThreeData) as? NSData
        
        if data != nil {
            
            if let userinfo = NSKeyedUnarchiver.unarchiveObject(with: data! as Data) as? ClinicalAssessmentThreeData {
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
        defaults.removeObject(forKey: kClinicalAssessmentThreeData)
        defaults.synchronize()
    }
}

class ClinicalAssessmentThreeVC: UIViewController {

    // MARK:- Declarations -
    
    @IBOutlet weak var btnNext: DesignableButton!
    
    @IBOutlet weak var btnFacialPalsyOption1: UIButton!
    @IBOutlet weak var btnFacialPalsyOption2: UIButton!
    @IBOutlet weak var btnFacialPalsyOption3: UIButton!
    
    @IBOutlet weak var btnArmMoterOption1: UIButton!
    @IBOutlet weak var btnArmMoterOption2: UIButton!
    @IBOutlet weak var btnArmMoterOption3: UIButton!
    
    @IBOutlet weak var btnLegMoterOption1: UIButton!
    @IBOutlet weak var btnLegMoterOption2: UIButton!
    @IBOutlet weak var btnLegMoterOption3: UIButton!
    
    @IBOutlet weak var btnHeadGazeOption1: UIButton!
    @IBOutlet weak var btnHeadGazeOption2: UIButton!
    
    var clinicalAssessmentThreeData = ClinicalAssessmentThreeData()
    
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
        
        var facial_palsy_race = 0
        
        if self.btnFacialPalsyOption1.isSelected {
            facial_palsy_race += 0
        } else if self.btnFacialPalsyOption2.isSelected {
            facial_palsy_race += 1
        } else if self.btnFacialPalsyOption3.isSelected {
            facial_palsy_race += 2
        }
        
        var arm_motor_impair = 0
        
        if self.btnArmMoterOption1.isSelected {
            arm_motor_impair += 0
        } else if self.btnArmMoterOption2.isSelected {
            arm_motor_impair += 1
        } else if self.btnArmMoterOption3.isSelected {
            arm_motor_impair += 2
        }
        
        var leg_motor_impair = 0
        
        if self.btnLegMoterOption1.isSelected {
            leg_motor_impair += 0
        } else if self.btnLegMoterOption2.isSelected {
            leg_motor_impair += 1
        } else if self.btnLegMoterOption3.isSelected {
            leg_motor_impair += 2
        }
        
        var head_gaze_deviate = 0
        
        if self.btnHeadGazeOption1.isSelected {
            head_gaze_deviate += 0
        } else if self.btnHeadGazeOption2.isSelected {
            head_gaze_deviate += 1
        }
        
        clinicalAssessmentThreeData.strFacial_Palsy_Race = String(facial_palsy_race)
        clinicalAssessmentThreeData.strArm_Motor_Impair = String(arm_motor_impair)
        clinicalAssessmentThreeData.strLeg_Motor_Impair = String(leg_motor_impair)
        clinicalAssessmentThreeData.strHead_Gaze_Deviate = String(head_gaze_deviate)
        
        clinicalAssessmentThreeData.save()
        print(ClinicalAssessmentThreeData.savedUser()!)
        
        self.performSegue(withIdentifier: "ClinicalAssessmentFour", sender: self)
    }
    
    @IBAction func btnFacialPalsyOptionClicked(_ sender: UIButton) {
        
        self.btnFacialPalsyOption1.isSelected = false
        self.btnFacialPalsyOption2.isSelected = false
        self.btnFacialPalsyOption3.isSelected = false
        
        sender.isSelected = true
    }
    
    @IBAction func btnArmMoterOptionClicked(_ sender: UIButton) {
        
        self.btnArmMoterOption1.isSelected = false
        self.btnArmMoterOption2.isSelected = false
        self.btnArmMoterOption3.isSelected = false
        
        sender.isSelected = true
    }
    
    @IBAction func btnLegMoterOptionClicked(_ sender: UIButton) {
        
        self.btnLegMoterOption1.isSelected = false
        self.btnLegMoterOption2.isSelected = false
        self.btnLegMoterOption3.isSelected = false
        
        sender.isSelected = true
    }
    
    @IBAction func btnHeadGazeOptionClicked(_ sender: UIButton) {
        
        self.btnHeadGazeOption1.isSelected = false
        self.btnHeadGazeOption2.isSelected = false
        
        sender.isSelected = true
    }
    
    // MARK: - Memory Warning -
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation -

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ClinicalAssessmentFour" {
            
            let destination = segue.destination as! ClinicalAssessmentFourVC
            print(destination)
        }
    }
}
