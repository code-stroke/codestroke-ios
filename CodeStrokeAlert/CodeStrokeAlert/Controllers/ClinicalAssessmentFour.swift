
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
        
        self.performSegue(withIdentifier: "ProfileSummery", sender: self)
    }
    
    @IBAction func btn18GIVClicked(_ sender: UIButton) {
    
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
        
        if segue.identifier == "ProfileSummery" {
            
            let destination = segue.destination as! ProfileSummeryVC
            print(destination)
        }
    }
}
