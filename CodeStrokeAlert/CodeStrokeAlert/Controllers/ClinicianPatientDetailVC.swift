//
//  ClinicianPatientDetailVC.swift
//  CodeStrokeAlert
//
//  Created by Jayesh on 27/06/18.
//  Copyright © 2018 Jayesh. All rights reserved.
//

import UIKit

class ClinicianPatientDetailVC: UIViewController {

    // MARK: - Declarations -
    
    @IBOutlet weak var btnED: UIButton!
    @IBOutlet weak var btnPatientDetail: UIButton!
    @IBOutlet weak var btnClinicalHistory: UIButton!
    @IBOutlet weak var btnClinicalAssessment: UIButton!
    @IBOutlet weak var btnRadiology: UIButton!
    @IBOutlet weak var btnManagement: UIButton!
    @IBOutlet weak var scrlView: UIScrollView!
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    // MARK: - View Controller Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.btnED.layer.cornerRadius = 5
        self.btnPatientDetail.layer.cornerRadius = 5
        self.btnClinicalHistory.layer.cornerRadius = 5
        self.btnClinicalAssessment.layer.cornerRadius = 5
        self.btnRadiology.layer.cornerRadius = 5
        self.btnManagement.layer.cornerRadius = 5
        
        self.buttonCenter(scrollView: scrlView, button: self.btnED)
        
        let image1 = self.gradientWithFrametoImage(frame: btnSubmit.frame, colors: [UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1).cgColor, UIColor(red: 255/255, green: 141/255, blue: 41/255, alpha: 1).cgColor])!
        self.btnSubmit.backgroundColor = UIColor(patternImage: image1)
    }
    
    // MARK: - Action Methods -

    @IBAction func btnTypeClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func btnSubmitClicked(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "ClinicianPatientDetailTwo", sender: sender)
    }
    
    // MARK: - Custom Methods -
    
    func clearSelection() {
        
        self.btnED.backgroundColor = UIColor.init(red: 212.0/255.0, green: 215.0/255.0, blue: 220.0/255.0, alpha: 1.0)
        self.btnPatientDetail.backgroundColor = UIColor.init(red: 212.0/255.0, green: 215.0/255.0, blue: 220.0/255.0, alpha: 1.0)
        self.btnClinicalHistory.backgroundColor = UIColor.init(red: 212.0/255.0, green: 215.0/255.0, blue: 220.0/255.0, alpha: 1.0)
        self.btnClinicalAssessment.backgroundColor = UIColor.init(red: 212.0/255.0, green: 215.0/255.0, blue: 220.0/255.0, alpha: 1.0)
        self.btnRadiology.backgroundColor = UIColor.init(red: 212.0/255.0, green: 215.0/255.0, blue: 220.0/255.0, alpha: 1.0)
        self.btnManagement.backgroundColor = UIColor.init(red: 212.0/255.0, green: 215.0/255.0, blue: 220.0/255.0, alpha: 1.0)
    }
    
    // MARK: - Memory Warning -
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation -

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ClinicianPatientDetailTwo" {
            
            let destination = segue.destination as! ClinicianPatientDetailTwoVC
            print(destination)
        }
    }
}
