//
//  ClinicalAssessmentTwoVC.swift
//  CodeStrokeAlert
//
//  Created by Jayesh on 19/06/18.
//  Copyright © 2018 Jayesh. All rights reserved.
//

import UIKit

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
        
    }
    
    @IBAction func btnEyeOptionClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func btnVerbalOptionClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func btnMoterOptionClicked(_ sender: UIButton) {
        
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
