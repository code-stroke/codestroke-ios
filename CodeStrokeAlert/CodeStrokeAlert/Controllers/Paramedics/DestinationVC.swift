//
//  DestinationVC.swift
//  CodeStrokeAlert
//
//  Created by Jayesh on 19/06/18.
//  Copyright © 2018 Jayesh. All rights reserved.
//

import UIKit
import CoreLocation

private var selectorColorAssociationKey: UInt8 = 0

extension UIPickerView {
    
    @IBInspectable var selectorColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, &selectorColorAssociationKey) as? UIColor
        }
        set(newValue) {
            objc_setAssociatedObject(self, &selectorColorAssociationKey, newValue,
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    open override func didAddSubview(_ subview: UIView) {
        
        super.didAddSubview(subview)
        if let color = selectorColor {
            if subview.bounds.height < 1.0 {
                subview.backgroundColor = color
            }
        }
    }
}

class DestinationVC: BaseVC {
    
    // MARK: - Declarations -
    
    @IBOutlet weak var btnNext: DesignableButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var viewTop: UIView!
    
    var arrHospitalList = [HospitalData]()
    var selectedHospital: Int = 0
    
    var userCurrentLocation: CLLocation?
    
    // MARK: - ViewController LifeCycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.updateUserCurrentLocation()
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notificationObject:)), name: NSNotification.Name(rawValue: BaseVC.notificationIdentifier), object: nil)
        
        self.title = "Destination"
        
        viewTop.layer.shadowColor = UIColor.lightGray.cgColor
        viewTop.layer.shadowOpacity = 1
        viewTop.layer.shadowOffset = CGSize.zero
        viewTop.layer.cornerRadius = 3.0
        viewTop.layer.shadowRadius = 10
        
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        
        let image1 = self.gradientWithFrametoImage(frame: btnNext.frame, colors: [UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1).cgColor, UIColor(red: 255/255, green: 141/255, blue: 41/255, alpha: 1).cgColor])!
        self.btnNext.backgroundColor = UIColor(patternImage: image1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if Reachability.isConnectedToNetwork() {
            DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.async {
                    self.WS_HospitalList(url: "https://codestroke-hospitals-codestroke-hospitals.193b.starter-ca-central-1.openshiftapps.com/hospital_list.json")
                }
            }
        } else {
            showAlert("No internet connection")
        }
    }
    
    @objc func methodOfReceivedNotification(notificationObject: Notification){
        
        print(notificationObject.userInfo ?? "not found location")
        userCurrentLocation = notificationObject.userInfo?["location"] as? CLLocation
    }
    
    // MARK: - Action Methods -
    
    @IBAction func btnNextClicked(_ sender: DesignableButton) {
        
        if let userLatitude = self.userCurrentLocation?.coordinate.latitude, let userLongitude = self.userCurrentLocation?.coordinate.longitude {
            
            let param = ["first_name": PatientDetailData.savedUser()!.strFirstName,
                         "last_name": PatientDetailData.savedUser()!.strLastName,
                         "dob": PatientDetailData.savedUser()!.strAge,
                         "address": PatientDetailData.savedUser()!.strAddress,
                         "gender": PatientDetailData.savedUser()!.strGender == "unspecified" ? "u" : PatientDetailData.savedUser()!.strGender == "male" ? "m" : "f",
                         "last_well": PatientDetailData.savedUser()!.strLastSeen,
                         "nok": PatientDetailData.savedUser()!.strNok,
                         "nok_phone": PatientDetailData.savedUser()!.strNOKContact,
                         "hospital_id": self.arrHospitalList[selectedHospital+1].hospital_id,
                         //                             "initial_location_lat": "\(userLatitude)",
                //                             "initial_location_long": "\(userLongitude)",
                "initial_location_lat": "-37.9150",
                "initial_location_long": "145.1300"] as [String : Any]
            
            if Reachability.isConnectedToNetwork() {
                DispatchQueue.global(qos: .background).async {
                    DispatchQueue.main.async {
                        self.WS_PatientInfo(url: AppURL.baseURL + AppURL.AddNewCase, parameter: param)
                    }
                }
            } else {
                showAlert("No internet connection")
            }
        } else {
            
            let param = ["first_name": PatientDetailData.savedUser()!.strFirstName,
                         "last_name": PatientDetailData.savedUser()!.strLastName,
                         "dob": PatientDetailData.savedUser()!.strAge,
                         "address": PatientDetailData.savedUser()!.strAddress,
                         "gender": PatientDetailData.savedUser()!.strGender == "unspecified" ? "u" : PatientDetailData.savedUser()!.strGender == "male" ? "m" : "f",
                         "last_well": PatientDetailData.savedUser()!.strLastSeen,
                         "nok": PatientDetailData.savedUser()!.strNok,
                         "nok_phone": PatientDetailData.savedUser()!.strNOKContact,
                         "hospital_id": self.arrHospitalList[selectedHospital+1].hospital_id,
                         "initial_location_lat": NSNull(),
                         "initial_location_long": NSNull()] as [String : Any]
            
            if Reachability.isConnectedToNetwork() {
                DispatchQueue.global(qos: .background).async {
                    DispatchQueue.main.async {
                        self.WS_PatientInfo(url: AppURL.baseURL + AppURL.AddNewCase, parameter: param)
                    }
                }
            } else {
                showAlert("No internet connection")
            }
        }
    }
    
    // MARK: - Memory Warning -
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation -
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ClinicalHistory" {
            
            let destination = segue.destination as! ClinicalHistoryVC
            print(destination)
        }
    }
}

// MARK: - Picker Controller Delegate -

extension DestinationVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView:  UIPickerView) -> Int  {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrHospitalList.count - 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrHospitalList[row+1].hospital_name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedHospital = row
    }
}
