//
//  MainContainerVC.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 08/07/18.
//  Copyright © 2018 Jayesh. All rights reserved.
//

import UIKit

class MainContainerVC: UIViewController {
    
    // MARK: - Declarations -
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var viewShadow: UIView!
    
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
    
    @IBOutlet weak var btnPrimarySurvey: UIButton!
    @IBOutlet weak var btnRegistered: UIButton!
    @IBOutlet weak var btnTriggered: UIButton!
    @IBOutlet weak var txtLocation: UITextField!
    
    var cashDetail = CaseList()
    
    // MARK: - View Controller Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        add(asChildViewController: clinicianPatientDetail)
        
        self.viewShadow.dropShadow(color: UIColor.init(red: 0.0/255.0, green: 90.0/255.0, blue: 192.0/255.0, alpha: 0.44), viewShadow: self.viewShadow)
        
        self.lblName.text = "\(CaseList.savedUser()!.first_name == "unknown" ? "" : CaseList.savedUser()!.first_name) \(CaseList.savedUser()!.last_name == "unknown" ? "" : CaseList.savedUser()!.last_name)"
        self.lblLastSeen.text = CaseList.savedUser()!.last_well
        
        if CaseList.savedUser()!.dob != "" {
            let strDOB = self.calcAge(birthday: CaseList.savedUser()!.dob)
            self.lblAge.text = "\(strDOB)"
        } else {
            self.lblAge.text = "-"
        }
        
        self.lblCaseType.text = CaseList.savedUser()!.status
        self.lblGender.text = CaseList.savedUser()!.gender == "f" ? "Female" : "Male"
        self.lblETA.text = CaseList.savedUser()!.status_time
        
        self.btnED.layer.cornerRadius = 5
        self.btnPatientDetail.layer.cornerRadius = 5
        self.btnClinicalHistory.layer.cornerRadius = 5
        self.btnClinicalAssessment.layer.cornerRadius = 5
        self.btnRadiology.layer.cornerRadius = 5
        self.btnManagement.layer.cornerRadius = 5
        
        self.buttonCenter(scrollView: scrlView, button: self.btnED)
    }
    
    private lazy var clinicianPatientDetail: ClinicianPatientDetailVC = {
        
        // Instantiate View Controller
        var viewController = dashBoardStoryboard.instantiateViewController(withIdentifier: "ClinicianPatientDetailVC") as! ClinicianPatientDetailVC
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var clinicianPatientDetailTwo: ClinicianPatientDetailTwoVC = {
        
        // Instantiate View Controller
        var viewController = dashBoardStoryboard.instantiateViewController(withIdentifier: "ClinicianPatientDetailTwoVC") as! ClinicianPatientDetailTwoVC
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var clinicianPatientDetailThree: ClinicianPatientDetailThreeVC = {
        
        // Instantiate View Controller
        var viewController = dashBoardStoryboard.instantiateViewController(withIdentifier: "ClinicianPatientDetailThreeVC") as! ClinicianPatientDetailThreeVC
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var clinicianPatientDetailFour: ClinicianPatientDetailFourVC = {
        
        // Instantiate View Controller
        var viewController = dashBoardStoryboard.instantiateViewController(withIdentifier: "ClinicianPatientDetailFourVC") as! ClinicianPatientDetailFourVC
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var clinicianPatientDetailFive: ClinicianPatientDetailFiveVC = {
        
        // Instantiate View Controller
        var viewController = dashBoardStoryboard.instantiateViewController(withIdentifier: "ClinicianPatientDetailFiveVC") as! ClinicianPatientDetailFiveVC
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var clinicianPatientDetailSix: ClinicianPatientDetailSixVC = {
        
        // Instantiate View Controller
        var viewController = dashBoardStoryboard.instantiateViewController(withIdentifier: "ClinicianPatientDetailSixVC") as! ClinicianPatientDetailSixVC
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    // MARK: - Action Methods -
    
    @IBAction func btnTypeClicked(_ sender: UIButton) {
        
        self.clearSelection()
        sender.backgroundColor = UIColor.init(red: 43.0/255.0, green: 143.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        
        self.buttonCenter(scrollView: scrlView, button: sender)
        
        remove(asChildViewController: clinicianPatientDetail)
        remove(asChildViewController: clinicianPatientDetailTwo)
        remove(asChildViewController: clinicianPatientDetailThree)
        remove(asChildViewController: clinicianPatientDetailFour)
        remove(asChildViewController: clinicianPatientDetailFive)
        remove(asChildViewController: clinicianPatientDetailSix)
        
        if sender.tag == 1 {
            add(asChildViewController: clinicianPatientDetail)
        } else if sender.tag == 2 {
            add(asChildViewController: clinicianPatientDetailTwo)
        } else if sender.tag == 3 {
            add(asChildViewController: clinicianPatientDetailThree)
        } else if sender.tag == 4 {
            add(asChildViewController: clinicianPatientDetailFour)
        } else if sender.tag == 5 {
            add(asChildViewController: clinicianPatientDetailFive)
        } else if sender.tag == 6 {
            add(asChildViewController: clinicianPatientDetailSix)
        }
    }
    
    @IBAction func btnRegisterTriagedPrimaryClicked(_ sender: UIButton) {
        
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }
    
    @IBAction func btnSubmitClicked(_ sender: UIButton) {
        
        let param = ["location": "",
                     "registered": self.btnRegistered.isSelected ? 1 : 0,
                     "triaged": self.btnTriggered.isSelected ? 1 : 0,
                     "primary_survey": self.btnPrimarySurvey.isSelected ? 1 : 0,
                     "signoff_first_name": LoginUserData.savedUser()!.strFirstName,
                     "signoff_last_name": LoginUserData.savedUser()!.strLastName,
                     "signoff_role": LoginUserData.savedUser()!.strUserRole] as [String : Any]
        
        if Reachability.isConnectedToNetwork() {
            DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.async {
                    self.WS_ED_Details(url: AppURL.baseURL + AppURL.ED + "\(CaseList.savedUser()!.case_id)/", parameter: param, isGet: false)
                }
            }
        } else {
            showAlert("No internet connection")
        }
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
    
    // MARK: - Helper Methods
    
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChildViewController(viewController)
        
        // Add Child View as Subview
        self.viewContainer.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = self.viewContainer.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParentViewController: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParentViewController()
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
