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
