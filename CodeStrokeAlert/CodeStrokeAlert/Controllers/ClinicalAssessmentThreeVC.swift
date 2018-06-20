//
//  ClinicalAssessmentThreeVC.swift
//  CodeStrokeAlert
//
//  Created by Jayesh on 19/06/18.
//  Copyright © 2018 Jayesh. All rights reserved.
//

import UIKit

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
        
        self.performSegue(withIdentifier: "ClinicalAssessmentFour", sender: self)
    }
    
    @IBAction func btnFacialPalsyOptionClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func btnArmMoterOptionClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func btnLegMoterOptionClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func btnHeadGazeOptionClicked(_ sender: UIButton) {
        
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
