//
//  ClinicalHistoryVC.swift
//  CodeStrokeAlert
//
//  Created by Jayesh on 19/06/18.
//  Copyright © 2018 Jayesh. All rights reserved.
//

import UIKit

class ClinicalHistoryVC: UIViewController {

    @IBOutlet weak var btnNext: DesignableButton!
    @IBOutlet weak var txtPostMedicalHistory: UITextField!
    @IBOutlet weak var txtMedications: UITextField!
    
    @IBOutlet weak var btnIHD: UIButton!
    @IBOutlet weak var btnDM: UIButton!
    @IBOutlet weak var btnStroke: UIButton!
    @IBOutlet weak var btnEpilepsy: UIButton!
    @IBOutlet weak var btnAF: UIButton!
    @IBOutlet weak var btnOther: UIButton!

    @IBOutlet weak var btnAnticoagulantsYes: UIButton!
    @IBOutlet weak var btnAnticoagulantsNo: UIButton!
    
    @IBOutlet weak var btnApixaban: UIButton!
    @IBOutlet weak var btnRivaroxaban: UIButton!
    @IBOutlet weak var btnWarfarin: UIButton!
    @IBOutlet weak var btnDabigatran: UIButton!
    @IBOutlet weak var btnHeparin: UIButton!
    
    @IBOutlet weak var txtLastDate: DesignableTextField!
    @IBOutlet weak var txtSituation: UITextField!
    @IBOutlet weak var txtWeight: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Clinical History"
        
        let image1 = self.gradientWithFrametoImage(frame: btnNext.frame, colors: [UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1).cgColor, UIColor(red: 255/255, green: 141/255, blue: 41/255, alpha: 1).cgColor])!
        self.btnNext.backgroundColor = UIColor(patternImage: image1)
    }

    // MARK: - Action Methods -
    
    @IBAction func btnNextClicked(_ sender: DesignableButton) {
        
        self.performSegue(withIdentifier: "ClinicalAssessment", sender: self)
    }
    
    @IBAction func btnPostMedicalHistoryClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func btnAnnticoagulantsClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func btnMedicationClicked(_ sender: UIButton) {
        
    }
    
    // MARK: - Memory Warning -
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation -

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ClinicalAssessment" {
            
            let destination = segue.destination as! ClinicalAssessmentVC
            print(destination)
        }
    }
}
