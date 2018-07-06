//
//  ClinicianPatientDetailFiveVC.swift
//  CodeStrokeAlert
//
//  Created by Jayesh on 27/06/18.
//  Copyright © 2018 Jayesh. All rights reserved.
//

import UIKit

class ClinicianPatientDetailFiveVC: UIViewController {
    
    // MARK: - Declarations -
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLastSeen: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblCaseType: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblETA: UILabel!
    
    @IBOutlet weak var btnED: UIButton!
    @IBOutlet weak var btnPatientDetail: UIButton!
    @IBOutlet weak var btnClinicalHistory: UIButton!
    @IBOutlet weak var btnClinicalAssessment: UIButton!
    @IBOutlet weak var btnRadiology: UIButton!
    @IBOutlet weak var btnManagement: UIButton!
    @IBOutlet weak var scrlView: UIScrollView!
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var btnCT1Yes: UIButton!
    @IBOutlet weak var btnCT1No: UIButton!
    
    @IBOutlet weak var btnCT2Yes: UIButton!
    @IBOutlet weak var btnCT2No: UIButton!
    
    @IBOutlet weak var btnCT3Yes: UIButton!
    @IBOutlet weak var btnCT3No: UIButton!
    
    @IBOutlet weak var btnCT4Yes: UIButton!
    @IBOutlet weak var btnCT4No: UIButton!
    
    @IBOutlet weak var btnPtArriveInCTYes: UIButton!
    @IBOutlet weak var btnPtArriveInCT2No: UIButton!
    
    @IBOutlet weak var btnCTCompleteYes: UIButton!
    @IBOutlet weak var btnCTCompleteNo: UIButton!
    
    @IBOutlet weak var btnICHCTYes: UIButton!
    @IBOutlet weak var btnICHCTNo: UIButton!
    
    @IBOutlet weak var btnProceedCTAorCTPYes: UIButton!
    @IBOutlet weak var btnProceedCTAorCTPNo: UIButton!
    
    @IBOutlet weak var btnCTAorCTPCompleteYes: UIButton!
    @IBOutlet weak var btnCTAorCTPCompleteNo: UIButton!
    
    @IBOutlet weak var btnLargeVesselOcclusionYes: UIButton!
    @IBOutlet weak var btnLargeVesselOcclusionNo: UIButton!
    
    // MARK: - View Controller Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.lblName.text = "\(CaseList.savedUser()!.first_name == "unknown" ? "" : CaseList.savedUser()!.first_name) \(CaseList.savedUser()!.last_name == "unknown" ? "" : CaseList.savedUser()!.last_name)"
        self.lblLastSeen.text = CaseList.savedUser()!.last_well
        let strDOB = self.calcAge(birthday: CaseList.savedUser()!.dob)
        self.lblAge.text = "\(strDOB)"
        self.lblCaseType.text = CaseList.savedUser()!.status
        self.lblGender.text = CaseList.savedUser()!.gender == "f" ? "Female" : "Male"
        self.lblETA.text = CaseList.savedUser()!.status_time
        
        self.btnED.layer.cornerRadius = 5
        self.btnPatientDetail.layer.cornerRadius = 5
        self.btnClinicalHistory.layer.cornerRadius = 5
        self.btnClinicalAssessment.layer.cornerRadius = 5
        self.btnRadiology.layer.cornerRadius = 5
        self.btnManagement.layer.cornerRadius = 5
        
        let image1 = self.gradientWithFrametoImage(frame: btnSubmit.frame, colors: [UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1).cgColor, UIColor(red: 255/255, green: 141/255, blue: 41/255, alpha: 1).cgColor])!
        self.btnSubmit.backgroundColor = UIColor(patternImage: image1)
        
        if Reachability.isConnectedToNetwork() {
            DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.async {
                    self.WS_Radiology(url: AppURL.baseURL + AppURL.Clinician_Radiology + "\(CaseList.savedUser()!.case_id)/", parameter: [:], isGet: true)
                }
            }
        } else {
            showAlert("No internet connection")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.buttonCenter(scrollView: scrlView, button: self.btnRadiology)
    }
    
    // MARK: - Action Methods -
    
    @IBAction func btnTypeClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func btnCT1Clicked(_ sender: UIButton) {
        
        self.clearSelection(btn1: btnCT1Yes, btn2: btnCT1No)
        sender.isSelected = true
    }
    
    @IBAction func btnCT2Clicked(_ sender: UIButton) {
        
        self.clearSelection(btn1: btnCT2Yes, btn2: btnCT2No)
        sender.isSelected = true
    }
    
    @IBAction func btnCT3Clicked(_ sender: UIButton) {
        
        self.clearSelection(btn1: btnCT3Yes, btn2: btnCT3No)
        sender.isSelected = true
    }
    
    @IBAction func btnCT4Clicked(_ sender: UIButton) {
        
        self.clearSelection(btn1: btnCT4Yes, btn2: btnCT4No)
        sender.isSelected = true
    }
    
    @IBAction func btnPTinCTClicked(_ sender: UIButton) {
        
        self.clearSelection(btn1: btnPtArriveInCTYes, btn2: btnPtArriveInCT2No)
        sender.isSelected = true
    }
    
    @IBAction func btnCTCompleteClicked(_ sender: UIButton) {
        
        self.clearSelection(btn1: btnCTCompleteYes, btn2: btnCTCompleteNo)
        sender.isSelected = true
    }

    @IBAction func btnICHClicked(_ sender: UIButton) {
        
        self.clearSelection(btn1: btnICHCTYes, btn2: btnICHCTNo)
        sender.isSelected = true
    }
    
    @IBAction func btnProceedWithCTAClicked(_ sender: UIButton) {
        
        self.clearSelection(btn1: btnProceedCTAorCTPYes, btn2: btnProceedCTAorCTPNo)
        sender.isSelected = true
    }
    
    @IBAction func btnCTAorCTPCompleteClicked(_ sender: UIButton) {
        
        self.clearSelection(btn1: btnCTAorCTPCompleteYes, btn2: btnCTAorCTPCompleteNo)
        sender.isSelected = true
    }
    
    @IBAction func btnLargeVesselClicked(_ sender: UIButton) {
        
        self.clearSelection(btn1: btnLargeVesselOcclusionYes, btn2: btnLargeVesselOcclusionNo)
        sender.isSelected = true
    }
    
    @IBAction func btnSubmitClicked(_ sender: UIButton) {
        
        let param = ["ct1": self.btnCT1Yes.isSelected ? true : self.btnCT1No.isSelected ? false : 0,
                     "ct2": self.btnCT2Yes.isSelected ? true : self.btnCT2No.isSelected ? false : 0,
                     "ct3": self.btnCT3Yes.isSelected ? true : self.btnCT3No.isSelected ? false : 0,
                     "ct4": self.btnCT4Yes.isSelected ? true : self.btnCT4No.isSelected ? false : 0,
                     "arrived_to_ct": self.btnPtArriveInCTYes.isSelected ? true : self.btnPtArriveInCT2No.isSelected ? false : 0,
                     "ct_complete": self.btnCTCompleteYes.isSelected ? true : self.btnCTCompleteNo.isSelected ? false : 0,
                     "ich_found": self.btnICHCTYes.isSelected ? true : self.btnICHCTNo.isSelected ? false : 0,
                     "do_cta_ctp": self.btnProceedCTAorCTPYes.isSelected ? true : self.btnProceedCTAorCTPNo.isSelected ? false : 0,
                     "cta_ctp_complete": self.btnCTAorCTPCompleteYes.isSelected ? true : self.btnCTAorCTPCompleteNo.isSelected ? false : 0,
                     "large_vessel_occlusion": self.btnLargeVesselOcclusionYes.isSelected ? true : self.btnLargeVesselOcclusionNo.isSelected ? false : 0] as [String : Any]
        
        if Reachability.isConnectedToNetwork() {
            DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.async {
                    self.WS_Radiology(url: AppURL.baseURL + AppURL.Clinician_Radiology + "\(CaseList.savedUser()!.case_id)/", parameter: param, isGet: false)
                }
            }
        } else {
            showAlert("No internet connection")
        }
    }
    
    // MARK: - Custom Methods -
    
    
    func clearSelection(btn1: UIButton, btn2: UIButton) {
        
        btn1.isSelected = false
        btn2.isSelected = false
    }
    
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
        
        if segue.identifier == "ClinicianPatientDetailSix" {
            
            let destination = segue.destination as! ClinicianPatientDetailSixVC
            print(destination)
        }
    }
}
