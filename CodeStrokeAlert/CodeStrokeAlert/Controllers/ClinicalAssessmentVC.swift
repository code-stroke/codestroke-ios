//
//  ClinicalAssessmentVC.swift
//  CodeStrokeAlert
//
//  Created by Jayesh on 19/06/18.
//  Copyright © 2018 Jayesh. All rights reserved.
//

import UIKit

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
        
        self.performSegue(withIdentifier: "ClinicalAssessmentTwo", sender: self)
    }
    
    @IBAction func btnUnknownClicked(_ sender: DesignableButton) {
        
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
