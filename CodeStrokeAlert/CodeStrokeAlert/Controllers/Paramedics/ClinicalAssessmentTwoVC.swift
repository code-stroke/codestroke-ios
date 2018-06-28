//
//  ClinicalAssessmentTwoVC.swift
//  CodeStrokeAlert
//
//  Created by Jayesh on 19/06/18.
//  Copyright © 2018 Jayesh. All rights reserved.
//

import UIKit
import EVReflection

let kClinicalAssessmentTwoData = "ClinicalAssessmentTwoData"

class ClinicalAssessmentTwoData: EVObject {
    
    var strBlood_Pressure: String               = ""
    var strHeart_Rate: String                   = ""
    var strHeart_Rhythm: String                 = ""
    var strRespiratory_Rate: String             = ""
    var strOxygen_Saturation: String            = ""
    var strTemperature: String                  = ""
    var strBlood_Glucose: String                = ""
    var strGCS: String                          = ""
    
    func save() {
        
        let defaults: UserDefaults = UserDefaults.standard
        let data: NSData = NSKeyedArchiver.archivedData(withRootObject: self) as NSData
        defaults.set(data, forKey: kClinicalAssessmentTwoData)
        defaults.synchronize()
    }
    
    class func savedUser() -> ClinicalAssessmentTwoData? {
        
        let defaults: UserDefaults = UserDefaults.standard
        let data = defaults.object(forKey: kClinicalAssessmentTwoData) as? NSData
        
        if data != nil {
            
            if let userinfo = NSKeyedUnarchiver.unarchiveObject(with: data! as Data) as? ClinicalAssessmentTwoData {
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
        defaults.removeObject(forKey: kClinicalAssessmentTwoData)
        defaults.synchronize()
    }
}

class ClinicalAssessmentTwoVC: UIViewController {
    
    // MARK:- Declarations -
    
    @IBOutlet weak var leadingGCS: NSLayoutConstraint!
    @IBOutlet weak var btnNext: DesignableButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var btnEye: UIButton!
    @IBOutlet weak var btnVerbal: UIButton!
    @IBOutlet weak var btnMotor: UIButton!
    
    @IBOutlet weak var txtBloodPressure: UITextField!
    @IBOutlet weak var txtHeartRate: UITextField!
    @IBOutlet weak var txtRespiratoryRate: UITextField!
    @IBOutlet weak var txtOxygenSaturation: UITextField!
    @IBOutlet weak var txtTemperature: UITextField!
    @IBOutlet weak var txtBloodGlucose: UITextField!
    
    @IBOutlet weak var btnRegular: UIButton!
    @IBOutlet weak var btnIrregular: UIButton!
    
    @IBOutlet weak var btnEyeOption1: UIButton!
    @IBOutlet weak var btnEyeOption2: UIButton!
    @IBOutlet weak var btnEyeOption3: UIButton!
    @IBOutlet weak var btnEyeOption4: UIButton!
    
    @IBOutlet weak var btnVerbalOption1: UIButton!
    @IBOutlet weak var btnVerbalOption2: UIButton!
    @IBOutlet weak var btnVerbalOption3: UIButton!
    @IBOutlet weak var btnVerbalOption4: UIButton!
    @IBOutlet weak var btnVerbalOption5: UIButton!
    
    @IBOutlet weak var btnMoterOption1: UIButton!
    @IBOutlet weak var btnMoterOption2: UIButton!
    @IBOutlet weak var btnMoterOption3: UIButton!
    @IBOutlet weak var btnMoterOption4: UIButton!
    @IBOutlet weak var btnMoterOption5: UIButton!
    @IBOutlet weak var btnMoterOption6: UIButton!

    var clinicalAssessmentTwoData = ClinicalAssessmentTwoData()
    
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
        
        clinicalAssessmentTwoData.strBlood_Pressure = isEmptyString(self.txtBloodPressure.text!) ? "NULL" : self.txtBloodPressure.text!
        clinicalAssessmentTwoData.strHeart_Rate = isEmptyString(self.txtHeartRate.text!) ? "NULL" : self.txtHeartRate.text!
        clinicalAssessmentTwoData.strHeart_Rhythm = self.btnRegular.isSelected ? "regular" : "irregular"
        clinicalAssessmentTwoData.strRespiratory_Rate = isEmptyString(self.txtRespiratoryRate.text!) ? "NULL" : self.txtRespiratoryRate.text!
        clinicalAssessmentTwoData.strOxygen_Saturation = isEmptyString(self.txtOxygenSaturation.text!) ? "NULL" : self.txtOxygenSaturation.text!
        clinicalAssessmentTwoData.strTemperature = isEmptyString(self.txtTemperature.text!) ? "NULL" : self.txtTemperature.text!
        clinicalAssessmentTwoData.strBlood_Glucose = isEmptyString(self.txtBloodGlucose.text!) ? "NULL" : self.txtBloodGlucose.text!
        
        var gscSelected = 0
        
        if self.btnEyeOption1.isSelected {
            gscSelected += 1
        } else if self.btnEyeOption1.isSelected {
            gscSelected += 2
        } else if self.btnEyeOption3.isSelected {
            gscSelected += 3
        } else if self.btnEyeOption4.isSelected {
            gscSelected += 4
        }
        
        if self.btnVerbalOption1.isSelected {
            gscSelected += 1
        } else if self.btnVerbalOption2.isSelected {
            gscSelected += 2
        } else if self.btnVerbalOption3.isSelected {
            gscSelected += 3
        } else if self.btnVerbalOption4.isSelected {
            gscSelected += 4
        } else if self.btnVerbalOption5.isSelected {
            gscSelected += 5
        }
        
        if self.btnMoterOption1.isSelected {
            gscSelected += 1
        } else if self.btnMoterOption2.isSelected {
            gscSelected += 2
        } else if self.btnMoterOption3.isSelected {
            gscSelected += 3
        } else if self.btnMoterOption4.isSelected {
            gscSelected += 4
        } else if self.btnMoterOption5.isSelected {
            gscSelected += 5
        } else if self.btnMoterOption6.isSelected {
            gscSelected += 6
        }
        
        clinicalAssessmentTwoData.strGCS = String(gscSelected)
        
        clinicalAssessmentTwoData.save()
        print(ClinicalAssessmentTwoData.savedUser()!)
        
        self.performSegue(withIdentifier: "ClinicalAssessmentThree", sender: self)
    }
    
    @IBAction func btnGCSClicked(_ sender: UIButton) {
        
        self.btnEye.isSelected = false
        self.btnVerbal.isSelected = false
        self.btnMotor.isSelected = false
        
        UIView.animate(withDuration: 0.22) {
            
            sender.isSelected = true
            self.leadingGCS.constant = sender.frame.origin.x
            let xAxis = sender.tag - 1
            self.scrollView.setContentOffset(CGPoint(x:CGFloat(xAxis) * (self.scrollView.frame.size.width) , y: 0), animated: true)
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func btnRegularIrregularClicked(_ sender: UIButton) {
        
        self.btnIrregular.isSelected = false
        self.btnRegular.isSelected = false
        
        sender.isSelected = true
    }
    
    @IBAction func btnEyeOptionClicked(_ sender: UIButton) {
        
        self.btnEyeOption1.isSelected = false
        self.btnEyeOption2.isSelected = false
        self.btnEyeOption3.isSelected = false
        self.btnEyeOption4.isSelected = false
        
        sender.isSelected = true
    }
    
    @IBAction func btnVerbalOptionClicked(_ sender: UIButton) {
        
        self.btnVerbalOption1.isSelected = false
        self.btnVerbalOption2.isSelected = false
        self.btnVerbalOption3.isSelected = false
        self.btnVerbalOption4.isSelected = false
        self.btnVerbalOption5.isSelected = false
        
        sender.isSelected = true
    }
    
    @IBAction func btnMoterOptionClicked(_ sender: UIButton) {
        
        self.btnMoterOption1.isSelected = false
        self.btnMoterOption2.isSelected = false
        self.btnMoterOption3.isSelected = false
        self.btnMoterOption4.isSelected = false
        self.btnMoterOption5.isSelected = false
        self.btnMoterOption6.isSelected = false
        
        sender.isSelected = true
    }
    
    // MARK: - Memory Warning -
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation -
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ClinicalAssessmentThree" {
            
            let destination = segue.destination as! ClinicalAssessmentThreeVC
            print(destination)
        }
    }
}

extension ClinicalAssessmentTwoVC: UIScrollViewDelegate {
    
    
}
