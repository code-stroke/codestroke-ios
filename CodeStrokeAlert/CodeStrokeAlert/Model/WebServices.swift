import Foundation
import KRProgressHUD
import Alamofire

extension LoginWithQR {
    
    func WS_Login(url: String, parameter: [String: String]) {
        
        print("\(url)?\(parameter)")
        self.view.isUserInteractionEnabled = false
        self.showHud("")
        
        let headers = ["content-type": "application/json"]
        
        Alamofire.upload(multipartFormData: {
            multipartFormData in
            for (key, value) in parameter {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        },usingThreshold: 0 ,to: url, headers: headers, encodingCompletion: {
            encodingResult in switch encodingResult {
                
            case .success(let upload, _, _):
                upload.responseObject(completionHandler: { (response : DataResponse<UserData>) in
                    
                    self.view.isUserInteractionEnabled = true
                    self.hideHUD()
                    
                    if response.result.value != nil {
                        
                        print(response.result.value!)
                        
                        if let status = response.result.value?.status {
                            
                            if status == 200 {
                                
                                self.loginUserData.userID = response.result.value!.user_id
                                self.loginUserData.save()
                                
                                if let userInfo = response.result.value {
                                    userInfo.save()
                                }
                                
                                appDelegate.goToClinicianDeshBordView()
                            }
                            else {
                                showAlert(response.result.value!.message)
                            }
                        }
                    } else {
                        showAlert("Database return nil value")
                    }
                })
                
                break
                
            case .failure(let encodingError):
                print(encodingError)
                break
            }
        })
    }
}

extension PatientDetailVC {
    
    func WS_PatientInfo(url: String, parameter: [String: String]) {
        
        print("\(url)?\(parameter)")
        self.view.isUserInteractionEnabled = false
        self.showHud("")
        
        let username = "adfa"
        let password = "changethislater"
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        let headers = ["content-type": "application/json",
                       "Authorization": "Basic \(base64LoginString)"]
        
        Alamofire.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: headers).responseObject { (response : DataResponse<CaseModel>) in
            self.view.isUserInteractionEnabled = true
            self.hideHUD()
            
            if (response.result.value != nil) {
                
                if response.result.value?.success == true {
                    self.performSegue(withIdentifier: "Destination", sender: self)
                    UserDefaults.standard.set(response.result.value!.case_id, forKey: "case_id")
                } else {
                    showAlert("Error in adding data")
                }
            } else {
                showAlert("Database return nil value")
            }
        }
    }
}

extension DestinationVC {
    
    func WS_HospitalList(url: String) {
        
        print("\(url)")
        self.view.isUserInteractionEnabled = false
        self.showHud("")
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseArray { (response: DataResponse<[HospitalData]>) in
            
            self.view.isUserInteractionEnabled = true
            self.hideHUD()
            
            if (response.result.value != nil) {
                print(response.result.value!)
                self.arrHospitalList = response.result.value!
                self.pickerView.reloadAllComponents()
            } else {
                showAlert("Database return nil value")
            }
        }
    }
}

extension ClinicalHistoryVC {
    
    func WS_ClinicalHistory(url: String, parameter: [String: Any]) {
        
        print("\(url)?\(parameter)")
        self.view.isUserInteractionEnabled = false
        self.showHud("")
        
        let username = "adfa"
        let password = "changethislater"
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        let headers = ["content-type": "application/json",
                       "Authorization": "Basic \(base64LoginString)"]
        
        Alamofire.request(url, method: .put, parameters: parameter, encoding: JSONEncoding.default, headers: headers).responseObject { (response : DataResponse<DefaultModel>) in
            self.view.isUserInteractionEnabled = true
            self.hideHUD()
            
            if (response.result.value != nil) {
                
                if response.result.value?.success == true {
                    self.performSegue(withIdentifier: "ClinicalAssessment", sender: self)
                } else {
                    showAlert("Error in adding data")
                }
            } else {
                showAlert("Database return nil value")
            }
        }
    }
}

extension ClinicalAssessmentFourVC {
    
    func WS_ClinicalAssessment(url: String, parameter: [String: Any]) {
        
        print("\(url)?\(parameter)")
        self.view.isUserInteractionEnabled = false
        self.showHud("")
        
        let username = "adfa"
        let password = "changethislater"
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        let headers = ["content-type": "application/json",
                       "Authorization": "Basic \(base64LoginString)"]
        
        Alamofire.request(url, method: .put, parameters: parameter, encoding: JSONEncoding.default, headers: headers).responseObject { (response : DataResponse<DefaultModel>) in
            self.view.isUserInteractionEnabled = true
            self.hideHUD()
            
            if (response.result.value != nil) {
                
                if response.result.value?.success == true {
                    self.performSegue(withIdentifier: "ProfileSummary", sender: self)
                } else {
                    showAlert("Error in adding data")
                }
            } else {
                showAlert("Database return nil value")
            }
        }
    }
}

extension PatientListVC {
    
    func WS_PatientInfo(url: String) {
        
        self.view.isUserInteractionEnabled = false
        self.showHud("")
        
        let username = "adfa"
        let password = "changethislater"
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        let headers = ["content-type": "application/json",
                       "Authorization": "Basic \(base64LoginString)"]
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseObject { (response : DataResponse<CaseListModel>) in
            self.view.isUserInteractionEnabled = true
            self.hideHUD()
            
            if (response.result.value != nil) {
                print(response.result.value!.result!)
                if response.result.value!.result!.count > 0 {
                    self.arrCaseList = response.result.value!.result!
                    
                    for (index, value) in self.arrCaseList.enumerated() {
                        
                        if self.arrCaseList[index].status == "active" {
                            self.arrCaseListActive.append(value)
                        } else if self.arrCaseList[index].status == "incoming" {
                            self.arrCaseListInComing.append(value)
                        } else if self.arrCaseList[index].status == "completed" {
                            self.arrCaseListCompleted.append(value)
                        }
                    }
                    
                } else {
                    self.arrCaseList = []
                }
                self.tblPatientList.reloadData()
            } else {
                showAlert("Database return nil value")
            }
        }
    }
}

extension ClinicianPatientDetailVC {
    
    func WS_ED_Details(url: String, parameter: [String: Any], isGet: Bool) {
        
        print("\(url)?\(parameter)")
        self.view.isUserInteractionEnabled = false
        self.showHud("")
        
        let username = "adfa"
        let password = "changethislater"
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        let headers = ["content-type": "application/json",
                       "Authorization": "Basic \(base64LoginString)"]
        
        var method = HTTPMethod.get
        
        if isGet == true {
            method = HTTPMethod.get
        } else {
            method = HTTPMethod.put
        }
        
        Alamofire.request(url, method: method, parameters: isGet ? nil : parameter, encoding: JSONEncoding.default, headers: headers).responseObject { (response : DataResponse<EDModel>) in
            self.view.isUserInteractionEnabled = true
            self.hideHUD()
            
            if (response.result.value != nil) {
                print(response.result.value!)
                
                if isGet == false {
                    if response.result.value!.success == true {
                        //                        self.performSegue(withIdentifier: "ClinicianPatientDetailTwo", sender: nil)
                        showAlert("Data submitted successfully")
                    } else {
                        showAlert("Something went wrong")
                    }
                } else {
                    
                    if response.result.value!.result![0].primary_survey == 1 {
                        
                        self.btnPrimarySurvey.isSelected = true
                    }
                    
                    if response.result.value!.result![0].registered == 1 {
                        
                        self.btnRegistered.isSelected = true
                    }
                    
                    if response.result.value!.result![0].triaged == 1 {
                        
                        self.btnTriggered.isSelected = true
                    }
                }
                
            } else {
                showAlert("Database return nil value")
            }
        }
    }
}

extension MainContainerVC {
    
    func WS_ED_Details(url: String, parameter: [String: Any], isGet: Bool) {
        
        print("\(url)?\(parameter)")
        self.view.isUserInteractionEnabled = false
        self.showHud("")
        
        let username = "adfa"
        let password = "changethislater"
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        let headers = ["content-type": "application/json",
                       "Authorization": "Basic \(base64LoginString)"]
        
        var method = HTTPMethod.get
        
        if isGet == true {
            method = HTTPMethod.get
        } else {
            method = HTTPMethod.put
        }
        
        Alamofire.request(url, method: method, parameters: isGet ? nil : parameter, encoding: JSONEncoding.default, headers: headers).responseObject { (response : DataResponse<EDModel>) in
            self.view.isUserInteractionEnabled = true
            self.hideHUD()
            
            if (response.result.value != nil) {
                print(response.result.value!)
                
                if isGet == false {
                    if response.result.value!.success == true {
                        //                        self.performSegue(withIdentifier: "ClinicianPatientDetailTwo", sender: nil)
                        showAlert("Data submitted successfully")
                    } else {
                        showAlert("Something went wrong")
                    }
                } else {
                    
                    if response.result.value!.result![0].primary_survey == 1 {
                        
                        self.btnPrimarySurvey.isSelected = true
                    }
                    
                    if response.result.value!.result![0].registered == 1 {
                        
                        self.btnRegistered.isSelected = true
                    }
                    
                    if response.result.value!.result![0].triaged == 1 {
                        
                        self.btnTriggered.isSelected = true
                    }
                }
                
            } else {
                showAlert("Database return nil value")
            }
        }
    }
}

extension ClinicianPatientDetailTwoVC {
    
    func WS_Case_Details(url: String, parameter: [String: Any], isGet: Bool) {
        
        print("\(url)?\(parameter)")
        self.view.isUserInteractionEnabled = false
        self.showHud("")
        
        let username = "adfa"
        let password = "changethislater"
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        let headers = ["content-type": "application/json",
                       "Authorization": "Basic \(base64LoginString)"]
        
        var method = HTTPMethod.get
        
        if isGet == true {
            method = HTTPMethod.get
        } else {
            method = HTTPMethod.put
        }
        
        Alamofire.request(url, method: method, parameters: isGet ? nil : parameter, encoding: JSONEncoding.default, headers: headers).responseObject { (response : DataResponse<CaseListModel>) in
            self.view.isUserInteractionEnabled = true
            self.hideHUD()
            
            if (response.result.value != nil) {
                print(response.result.value!)
                
                if isGet == false {
                    if response.result.value!.success == true {
                        showAlert("Data submitted successfully")
                    } else {
                        showAlert("Something went wrong")
                    }
                } else {
                    
                    self.txtAddress.text = response.result.value!.result![0].address
                    self.txtDOB.text = response.result.value!.result![0].dob
                    self.txtNextKin.text = response.result.value!.result![0].nok
                    self.txtSurname.text = response.result.value!.result![0].last_name
                    self.txtLastSeen.text = response.result.value!.result![0].last_well
                    self.txtMedicare.text = response.result.value!.result![0].medicare_no
                    self.txtFirstName.text = response.result.value!.result![0].first_name
                    self.txtNOKContact.text = response.result.value!.result![0].nok_phone
                    
                    self.btnFemale.isSelected = false
                    self.btnMale.isSelected = false
                    self.btnUnspecifies.isSelected = false
                    
                    if response.result.value!.result![0].gender == "f" {
                        self.btnFemale.isSelected = true
                    } else if response.result.value!.result![0].gender == "m" {
                        self.btnMale.isSelected = true
                    } else {
                        self.btnUnspecifies.isSelected = true
                    }
                }
                
            } else {
                showAlert("Database return nil value")
            }
        }
    }
}

extension ClinicianPatientDetailThreeVC {
    
    func WS_Clinician_Details(url: String, parameter: [String: Any], isGet: Bool) {
        
        print("\(url)?\(parameter)")
        self.view.isUserInteractionEnabled = false
        self.showHud("")
        
        let username = "adfa"
        let password = "changethislater"
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        let headers = ["content-type": "application/json",
                       "Authorization": "Basic \(base64LoginString)"]
        
        var method = HTTPMethod.get
        
        if isGet == true {
            method = HTTPMethod.get
        } else {
            method = HTTPMethod.put
        }
        
        Alamofire.request(url, method: method, parameters: isGet ? nil : parameter, encoding: JSONEncoding.default, headers: headers).responseObject { (response : DataResponse<CaseHistoryModel>) in
            self.view.isUserInteractionEnabled = true
            self.hideHUD()
            
            if (response.result.value != nil) {
                print(response.result.value!)
                
                if isGet == false {
                    if response.result.value!.success == true {
                        //                        self.performSegue(withIdentifier: "ClinicianPatientDetailFour", sender: nil)
                        showAlert("Data submitted successfully")
                    } else {
                        showAlert("Something went wrong")
                    }
                } else {
                    
                    self.txtWeight.text = "\(response.result.value!.result![0].weight)"
                    self.txtLastDose.text = response.result.value!.result![0].anticoags_last_dose
                    self.txtLastMeal.text = response.result.value!.result![0].last_meal
                    self.txtSituation.text = response.result.value!.result![0].hopc
                    self.txtMedication.text = response.result.value!.result![0].meds
                    self.txtPastMedicalHistory.text = response.result.value!.result![0].pmhx
                    
                    if response.result.value!.result![0].anticoags == true {
                        self.btnAnticoagulantsYes.isSelected = true
                        self.btnAnticoagulantsNo.isSelected = false
                    } else {
                        self.btnAnticoagulantsYes.isSelected = false
                        self.btnAnticoagulantsNo.isSelected = true
                    }
                }
                
            } else {
                showAlert("Database return nil value")
            }
        }
    }
}

extension ClinicianPatientDetailFourVC {
    
    func WS_Clinician_Assessment(url: String, parameter: [String: Any], isGet: Bool) {
        
        print("\(url)?\(parameter)")
        self.view.isUserInteractionEnabled = false
        self.showHud("")
        
        let username = "adfa"
        let password = "changethislater"
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        let headers = ["content-type": "application/json",
                       "Authorization": "Basic \(base64LoginString)"]
        
        var method = HTTPMethod.get
        
        if isGet == true {
            method = HTTPMethod.get
        } else {
            method = HTTPMethod.put
        }
        
        Alamofire.request(url, method: method, parameters: isGet ? nil : parameter, encoding: JSONEncoding.default, headers: headers).responseObject { (response : DataResponse<ClinicianAssessmentModel>) in
            self.view.isUserInteractionEnabled = true
            self.hideHUD()
            
            if (response.result.value != nil) {
                print(response.result.value!)
                
                if isGet == false {
                    if response.result.value!.success == true {
                        //                        self.performSegue(withIdentifier: "ClinicianPatientDetailFive", sender: nil)
                        showAlert("Data submitted successfully")
                    } else {
                        showAlert("Something went wrong")
                    }
                } else {
                    
                    if response.result.value!.result![0].facial_droop == "" {
                        self.clearAllSelectionAndSelectedItem(btn1: self.btnFacialDropYes, btn1Selected: false, btn2: self.btnFacialDropNo, btn2Selected: false, btn3: self.btnFacialDropUnknown, btn3Selected: false)
                    } else if response.result.value!.result![0].facial_droop == "yes" {
                        self.clearAllSelectionAndSelectedItem(btn1: self.btnFacialDropYes, btn1Selected: true, btn2: self.btnFacialDropNo, btn2Selected: false, btn3: self.btnFacialDropUnknown, btn3Selected: false)
                    } else if response.result.value!.result![0].facial_droop == "no" {
                        self.clearAllSelectionAndSelectedItem(btn1: self.btnFacialDropYes, btn1Selected: false, btn2: self.btnFacialDropNo, btn2Selected: true, btn3: self.btnFacialDropUnknown, btn3Selected: false)
                    } else {
                        self.clearAllSelectionAndSelectedItem(btn1: self.btnFacialDropYes, btn1Selected: false, btn2: self.btnFacialDropNo, btn2Selected: false, btn3: self.btnFacialDropUnknown, btn3Selected: true)
                    }
                    
                    if response.result.value!.result![0].arm_drift == "" {
                        self.clearAllSelectionAndSelectedItem(btn1: self.btnArmDriftYes, btn1Selected: false, btn2: self.btnArmDriftNo, btn2Selected: false, btn3: self.btnArmDriftUnknown, btn3Selected: false)
                    } else if response.result.value!.result![0].arm_drift == "yes" {
                        self.clearAllSelectionAndSelectedItem(btn1: self.btnArmDriftYes, btn1Selected: true, btn2: self.btnArmDriftNo, btn2Selected: false, btn3: self.btnArmDriftUnknown, btn3Selected: false)
                    } else if response.result.value!.result![0].arm_drift == "no" {
                        self.clearAllSelectionAndSelectedItem(btn1: self.btnArmDriftYes, btn1Selected: false, btn2: self.btnArmDriftNo, btn2Selected: true, btn3: self.btnArmDriftUnknown, btn3Selected: false)
                    } else {
                        self.clearAllSelectionAndSelectedItem(btn1: self.btnArmDriftYes, btn1Selected: false, btn2: self.btnArmDriftNo, btn2Selected: false, btn3: self.btnArmDriftUnknown, btn3Selected: true)
                    }
                    
                    if response.result.value!.result![0].weak_grip == "" {
                        self.clearAllSelectionAndSelectedItem(btn1: self.btnWeakGripYes, btn1Selected: false, btn2: self.btnWeakGripNo, btn2Selected: false, btn3: self.btnWeakGripUnknown, btn3Selected: false)
                    } else if response.result.value!.result![0].weak_grip == "yes" {
                        self.clearAllSelectionAndSelectedItem(btn1: self.btnWeakGripYes, btn1Selected: true, btn2: self.btnWeakGripNo, btn2Selected: false, btn3: self.btnWeakGripUnknown, btn3Selected: false)
                    } else if response.result.value!.result![0].weak_grip == "no" {
                        self.clearAllSelectionAndSelectedItem(btn1: self.btnWeakGripYes, btn1Selected: false, btn2: self.btnWeakGripNo, btn2Selected: true, btn3: self.btnWeakGripUnknown, btn3Selected: false)
                    } else {
                        self.clearAllSelectionAndSelectedItem(btn1: self.btnWeakGripYes, btn1Selected: false, btn2: self.btnWeakGripNo, btn2Selected: false, btn3: self.btnWeakGripUnknown, btn3Selected: true)
                    }
                    
                    if response.result.value!.result![0].speech_difficulty == "" {
                        self.clearAllSelectionAndSelectedItem(btn1: self.btnSpeechDifficultyYes, btn1Selected: false, btn2: self.btnSpeechDifficultyNo, btn2Selected: false, btn3: self.btnSpeechDifficultyUnknown, btn3Selected: false)
                    } else if response.result.value!.result![0].speech_difficulty == "yes" {
                        self.clearAllSelectionAndSelectedItem(btn1: self.btnSpeechDifficultyYes, btn1Selected: true, btn2: self.btnSpeechDifficultyNo, btn2Selected: false, btn3: self.btnSpeechDifficultyUnknown, btn3Selected: false)
                    } else if response.result.value!.result![0].speech_difficulty == "no" {
                        self.clearAllSelectionAndSelectedItem(btn1: self.btnSpeechDifficultyYes, btn1Selected: false, btn2: self.btnSpeechDifficultyNo, btn2Selected: true, btn3: self.btnSpeechDifficultyUnknown, btn3Selected: false)
                    } else {
                        self.clearAllSelectionAndSelectedItem(btn1: self.btnSpeechDifficultyYes, btn1Selected: false, btn2: self.btnSpeechDifficultyNo, btn2Selected: false, btn3: self.btnSpeechDifficultyUnknown, btn3Selected: true)
                    }
                    
                    if response.result.value!.result![0].heart_rhythm == "" {
                        self.clearAllSelectionAndSelectedItem2(btn1: self.btnRegular, btn1Selected: false, btn2: self.btnIrregular, btn2Selected: false)
                    } else if response.result.value!.result![0].heart_rhythm == "regular" {
                        self.clearAllSelectionAndSelectedItem2(btn1: self.btnRegular, btn1Selected: true, btn2: self.btnIrregular, btn2Selected: false)
                    } else {
                        self.clearAllSelectionAndSelectedItem2(btn1: self.btnRegular, btn1Selected: false, btn2: self.btnIrregular, btn2Selected: true)
                    }
                    
                    if response.result.value!.result![0].cannula == true {
                        self.clearAllSelectionAndSelectedItem2(btn1: self.btn18GIVYes, btn1Selected: true, btn2: self.btn18GIVNo, btn2Selected: false)
                    } else if response.result.value!.result![0].cannula == false {
                        self.clearAllSelectionAndSelectedItem2(btn1: self.btn18GIVYes, btn1Selected: false, btn2: self.btn18GIVNo, btn2Selected: true)
                    } else {
                        self.clearAllSelectionAndSelectedItem2(btn1: self.btn18GIVYes, btn1Selected: false, btn2: self.btn18GIVNo, btn2Selected: false)
                    }
                    
                    if response.result.value!.result![0].heart_rate == 0 {
                        self.txtHeartRate.text = ""
                    } else {
                        self.txtHeartRate.text = "\(response.result.value!.result![0].heart_rate)"
                    }
                    
                    if response.result.value!.result![0].rr == 0 {
                        self.txtRespiratoryRate.text = ""
                    } else {
                        self.txtRespiratoryRate.text = "\(response.result.value!.result![0].rr)"
                    }
                    
                    if response.result.value!.result![0].o2sats == 0 {
                        self.txtOxygenSaturation.text = ""
                    } else {
                        self.txtOxygenSaturation.text = "\(response.result.value!.result![0].o2sats)"
                    }
                    
                    if response.result.value!.result![0].temp == 0 {
                        self.txtTemperature.text = ""
                    } else {
                        self.txtTemperature.text = "\(response.result.value!.result![0].temp)"
                    }
                    
                    if response.result.value!.result![0].blood_glucose == 0 {
                        self.txtBloodGlucose.text = ""
                    } else {
                        self.txtBloodGlucose.text = "\(response.result.value!.result![0].blood_glucose)"
                    }
                    
                    if response.result.value!.result![0].gcs == 0 {
                        self.txtGCS.text = ""
                    } else {
                        self.txtGCS.text = "\(response.result.value!.result![0].gcs)"
                    }
                    
                    if response.result.value!.result![0].head_gaze_deviate == 0 {
                        self.txtHeadAndGazeDeviation.text = ""
                    } else {
                        self.txtHeadAndGazeDeviation.text = "\(response.result.value!.result![0].head_gaze_deviate)"
                    }
                    
                    if response.result.value!.result![0].arm_motor_impair == 0 {
                        self.txtArmMotorImpairment.text = ""
                    } else {
                        self.txtArmMotorImpairment.text = "\(response.result.value!.result![0].arm_motor_impair)"
                    }
                    
                    if response.result.value!.result![0].leg_motor_impair == 0 {
                        self.txtLegMotorImpairment.text = ""
                    } else {
                        self.txtLegMotorImpairment.text = "\(response.result.value!.result![0].leg_motor_impair)"
                    }
                    
                    if response.result.value!.result![0].facial_palsy_race == 0 {
                        self.txtFacialPalsy.text = ""
                    } else {
                        self.txtFacialPalsy.text = "\(response.result.value!.result![0].facial_palsy_race)"
                    }
                    
                    if response.result.value!.result![0].conscious_level == 0 {
                        self.txtLevelOfConsciousness.text = ""
                    } else {
                        self.txtLevelOfConsciousness.text = "\(response.result.value!.result![0].conscious_level)"
                    }
                    
                    if response.result.value!.result![0].month_age == 0 {
                        self.txtLevelOfConsciousness.text = ""
                    } else {
                        self.txtLevelOfConsciousness.text = "\(response.result.value!.result![0].month_age)"
                    }
                    
                    if response.result.value!.result![0].blink_squeeze == 0 {
                        self.txtBlinkEye.text = ""
                    } else {
                        self.txtBlinkEye.text = "\(response.result.value!.result![0].blink_squeeze)"
                    }
                    
                    if response.result.value!.result![0].horizontal_gaze == 0 {
                        self.txtHorizontalGaze.text = ""
                    } else {
                        self.txtHorizontalGaze.text = "\(response.result.value!.result![0].horizontal_gaze)"
                    }
                    
                    if response.result.value!.result![0].visual_fields == 0 {
                        self.txtVisualFields.text = ""
                    } else {
                        self.txtVisualFields.text = "\(response.result.value!.result![0].visual_fields)"
                    }
                    
                    if response.result.value!.result![0].facial_palsy_nihss == 0 {
                        self.txtNIHSS_Facial_Palsy.text = ""
                    } else {
                        self.txtNIHSS_Facial_Palsy.text = "\(response.result.value!.result![0].facial_palsy_nihss)"
                    }
                    
                    if response.result.value!.result![0].left_arm_drift == 0 {
                        self.txtLeftArmDrift.text = ""
                    } else {
                        self.txtLeftArmDrift.text = "\(response.result.value!.result![0].left_arm_drift)"
                    }
                    
                    if response.result.value!.result![0].right_arm_drift == 0 {
                        self.txtRightArmDrift.text = ""
                    } else {
                        self.txtRightArmDrift.text = "\(response.result.value!.result![0].right_arm_drift)"
                    }
                    
                    
                    if response.result.value!.result![0].left_leg_drift == 0 {
                        self.txtLeftLegDrift.text = ""
                    } else {
                        self.txtLeftLegDrift.text = "\(response.result.value!.result![0].left_leg_drift)"
                    }
                    
                    if response.result.value!.result![0].right_leg_drift == 0 {
                        self.txtRightLegDrift.text = ""
                    } else {
                        self.txtRightLegDrift.text = "\(response.result.value!.result![0].right_leg_drift)"
                    }
                    
                    if response.result.value!.result![0].limb_ataxia == 0 {
                        self.txtLimbAtaxia.text = ""
                    } else {
                        self.txtLimbAtaxia.text = "\(response.result.value!.result![0].limb_ataxia)"
                    }
                    
                    if response.result.value!.result![0].sensation == 0 {
                        self.txtSensation.text = ""
                    } else {
                        self.txtSensation.text = "\(response.result.value!.result![0].sensation)"
                    }
                    
                    if response.result.value!.result![0].aphasia == 0 {
                        self.txtAlphasia.text = ""
                    } else {
                        self.txtAlphasia.text = "\(response.result.value!.result![0].aphasia)"
                    }
                    
                    if response.result.value!.result![0].dysarthria == 0 {
                        self.txtDysarthria.text = ""
                    } else {
                        self.txtDysarthria.text = "\(response.result.value!.result![0].dysarthria)"
                    }
                    
                    if response.result.value!.result![0].neglect == 0 {
                        self.txtExtinction.text = ""
                    } else {
                        self.txtExtinction.text = "\(response.result.value!.result![0].neglect)"
                    }
                    
                    if response.result.value!.result![0].rankin_conscious == 0 {
                        self.txtLevelOfConsciousness_Rankin.text = ""
                    } else {
                        self.txtLevelOfConsciousness_Rankin.text = "\(response.result.value!.result![0].rankin_conscious)"
                    }
                    
                    if response.result.value!.result![0].hemiparesis == "left" {
                        self.segmentHemiparesis.selectedSegmentIndex = 0
                    } else {
                        self.segmentHemiparesis.selectedSegmentIndex = 1
                    }
                }
                
            } else {
                showAlert("Database return nil value")
            }
        }
    }
}

extension ClinicianPatientDetailFiveVC {
    
    func WS_Radiology(url: String, parameter: [String: Any], isGet: Bool) {
        
        print("\(url)?\(parameter)")
        self.view.isUserInteractionEnabled = false
        self.showHud("")
        
        let username = "adfa"
        let password = "changethislater"
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        let headers = ["content-type": "application/json",
                       "Authorization": "Basic \(base64LoginString)"]
        
        var method = HTTPMethod.get
        
        if isGet == true {
            method = HTTPMethod.get
        } else {
            method = HTTPMethod.put
        }
        
        Alamofire.request(url, method: method, parameters: isGet ? nil : parameter, encoding: JSONEncoding.default, headers: headers).responseObject { (response : DataResponse<RadiologyModel>) in
            self.view.isUserInteractionEnabled = true
            self.hideHUD()
            
            if (response.result.value != nil) {
                print(response.result.value!)
                
                if isGet == false {
                    if response.result.value!.success == true {
                        //                        self.performSegue(withIdentifier: "ClinicianPatientDetailSix", sender: nil)
                        showAlert("Data submitted successfully")
                    } else {
                        showAlert("Something went wrong")
                    }
                } else {
                    
                    if response.result.value!.result![0].ct1 == true {
                        self.btnCT1Yes.isSelected = true
                    } else if response.result.value!.result![0].ct1 == false {
                        self.btnCT1No.isSelected = true
                    } else {
                        self.clearSelection(btn1: self.btnCT1Yes, btn2: self.btnCT1No)
                    }
                    
                    if response.result.value!.result![0].ct2 == true {
                        self.btnCT2Yes.isSelected = true
                    } else if response.result.value!.result![0].ct2 == false {
                        self.btnCT2No.isSelected = true
                    } else {
                        self.clearSelection(btn1: self.btnCT2Yes, btn2: self.btnCT2No)
                    }
                    
                    if response.result.value!.result![0].ct3 == true {
                        self.btnCT3Yes.isSelected = true
                    } else if response.result.value!.result![0].ct3 == false {
                        self.btnCT3No.isSelected = true
                    } else {
                        self.clearSelection(btn1: self.btnCT3Yes, btn2: self.btnCT3No)
                    }
                    
                    if response.result.value!.result![0].arrived_to_ct == true {
                        self.btnPtArriveInCTYes.isSelected = true
                    } else if response.result.value!.result![0].arrived_to_ct == false {
                        self.btnPtArriveInCT2No.isSelected = true
                    } else {
                        self.clearSelection(btn1: self.btnPtArriveInCTYes, btn2: self.btnPtArriveInCT2No)
                    }
                    
                    if response.result.value!.result![0].ct_complete == true {
                        self.btnCTCompleteYes.isSelected = true
                    } else if response.result.value!.result![0].ct_complete == false {
                        self.btnCTCompleteNo.isSelected = true
                    } else {
                        self.clearSelection(btn1: self.btnCTCompleteYes, btn2: self.btnCTCompleteNo)
                    }
                    
                    if response.result.value!.result![0].ich_found == true {
                        self.btnICHCTYes.isSelected = true
                    } else if response.result.value!.result![0].ich_found == false {
                        self.btnICHCTNo.isSelected = true
                    } else {
                        self.clearSelection(btn1: self.btnICHCTYes, btn2: self.btnICHCTNo)
                    }
                    
                    if response.result.value!.result![0].do_cta_ctp == true {
                        self.btnProceedCTAorCTPYes.isSelected = true
                    } else if response.result.value!.result![0].do_cta_ctp == false {
                        self.btnProceedCTAorCTPNo.isSelected = true
                    } else {
                        self.clearSelection(btn1: self.btnProceedCTAorCTPYes, btn2: self.btnProceedCTAorCTPNo)
                    }
                    
                    if response.result.value!.result![0].cta_ctp_complete == true {
                        self.btnCTAorCTPCompleteYes.isSelected = true
                    } else if response.result.value!.result![0].cta_ctp_complete == false {
                        self.btnCTAorCTPCompleteNo.isSelected = true
                    } else {
                        self.clearSelection(btn1: self.btnCTAorCTPCompleteYes, btn2: self.btnCTAorCTPCompleteNo)
                    }
                    
                    if response.result.value!.result![0].large_vessel_occlusion == true {
                        self.btnLargeVesselOcclusionYes.isSelected = true
                    } else if response.result.value!.result![0].large_vessel_occlusion == false {
                        self.btnLargeVesselOcclusionNo.isSelected = true
                    } else {
                        self.clearSelection(btn1: self.btnLargeVesselOcclusionYes, btn2: self.btnLargeVesselOcclusionNo)
                    }
                }
            } else {
                showAlert("Database return nil value")
            }
        }
    }
}

extension ClinicianPatientDetailSixVC {
    
    func WS_Management(url: String, parameter: [String: Any], isGet: Bool) {
        
        print("\(url)?\(parameter)")
        self.view.isUserInteractionEnabled = false
        self.showHud("")
        
        let username = "adfa"
        let password = "changethislater"
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        let headers = ["content-type": "application/json",
                       "Authorization": "Basic \(base64LoginString)"]
        
        var method = HTTPMethod.get
        
        if isGet == true {
            method = HTTPMethod.get
        } else {
            method = HTTPMethod.put
        }
        
        Alamofire.request(url, method: method, parameters: isGet ? nil : parameter, encoding: JSONEncoding.default, headers: headers).responseObject { (response : DataResponse<ManagementModel>) in
            self.view.isUserInteractionEnabled = true
            self.hideHUD()
            
            if (response.result.value != nil) {
                print(response.result.value!)
                
                if isGet == false {
                    if response.result.value!.success == true {
                        //                        self.performSegue(withIdentifier: "ClinicianPatientDetailSix", sender: nil)
                        showAlert("Data submitted successfully")
                    } else {
                        showAlert("Something went wrong")
                    }
                } else {
                    
                    if response.result.value!.result![0].thrombolysis == true {
                        self.lblThrombolysis1.text = "Yes"
                        self.lblThrombolysis2.text = "Yes"
                        self.lblThrombolysis3.text = "Yes"
                        self.lblThrombolysis4.text = "Yes"
                    } else if response.result.value!.result![0].thrombolysis == false {
                        self.lblThrombolysis1.text = "No"
                        self.lblThrombolysis2.text = "No"
                        self.lblThrombolysis3.text = "No"
                        self.lblThrombolysis4.text = "No"
                    } else {
                        self.lblThrombolysis1.text = ""
                        self.lblThrombolysis2.text = ""
                        self.lblThrombolysis3.text = ""
                        self.lblThrombolysis4.text = ""
                    }
                    
                    if response.result.value!.result![0].new_trauma_haemorrhage == true {
                        self.btnNueHeadYes.isSelected = true
                    } else if response.result.value!.result![0].new_trauma_haemorrhage == false {
                        self.btnNueHeadNo.isSelected = true
                    } else {
                        self.clearSelectionButtons(btn1: self.btnNueHeadYes, btn2: self.btnNueHeadNo)
                    }
                    
                    if response.result.value!.result![0].uncontrolled_htn == true {
                        self.btnUnControlledHTNYes.isSelected = true
                    } else if response.result.value!.result![0].uncontrolled_htn == false {
                        self.btnUnControlledHTNNo.isSelected = true
                    } else {
                        self.clearSelectionButtons(btn1: self.btnUnControlledHTNYes, btn2: self.btnUnControlledHTNNo)
                    }
                    
                    if response.result.value!.result![0].history_ich == true {
                        self.btnHistoryOfICHYes.isSelected = true
                    } else if response.result.value!.result![0].history_ich == false {
                        self.btnHistoryOfICHNo.isSelected = true
                    } else {
                        self.clearSelectionButtons(btn1: self.btnHistoryOfICHYes, btn2: self.btnHistoryOfICHNo)
                    }
                    
                    if response.result.value!.result![0].known_intracranial == true {
                        self.btnKnownIntracranialYes.isSelected = true
                    } else if response.result.value!.result![0].known_intracranial == false {
                        self.btnKnownIntracraniaNo.isSelected = true
                    } else {
                        self.clearSelectionButtons(btn1: self.btnKnownIntracranialYes, btn2: self.btnKnownIntracraniaNo)
                    }
                    
                    if response.result.value!.result![0].active_bleed == true {
                        self.btnActiveBleedingYes.isSelected = true
                    } else if response.result.value!.result![0].active_bleed == false {
                        self.btnActiveBleedingNo.isSelected = true
                    } else {
                        self.clearSelectionButtons(btn1: self.btnActiveBleedingYes, btn2: self.btnActiveBleedingNo)
                    }
                    
                    if response.result.value!.result![0].endocarditis == true {
                        self.btnEndocarditisYes.isSelected = true
                    } else if response.result.value!.result![0].endocarditis == false {
                        self.btnEndocarditisNo.isSelected = true
                    } else {
                        self.clearSelectionButtons(btn1: self.btnEndocarditisYes, btn2: self.btnEndocarditisNo)
                    }
                    
                    if response.result.value!.result![0].bleeding_diathesis == true {
                        self.btnKnownBleedingDiathesisYes.isSelected = true
                    } else if response.result.value!.result![0].bleeding_diathesis == false {
                        self.btnKnownBleedingDiathesisNo.isSelected = true
                    } else {
                        self.clearSelectionButtons(btn1: self.btnKnownBleedingDiathesisYes, btn2: self.btnKnownBleedingDiathesisNo)
                    }
                    
                    if response.result.value!.result![0].abnormal_blood_glucose == true {
                        self.btnAbnormalBloodGlucoseYes.isSelected = true
                    } else if response.result.value!.result![0].abnormal_blood_glucose == false {
                        self.btnAbnormalBloodGlucoseNo.isSelected = true
                    } else {
                        self.clearSelectionButtons(btn1: self.btnAbnormalBloodGlucoseYes, btn2: self.btnAbnormalBloodGlucoseNo)
                    }
                    
                    if response.result.value!.result![0].rapidly_improving == true {
                        self.btnRapidlyImprovingYes.isSelected = true
                    } else if response.result.value!.result![0].rapidly_improving == false {
                        self.btnRapidlyImprovingNo.isSelected = true
                    } else {
                        self.clearSelectionButtons(btn1: self.btnRapidlyImprovingYes, btn2: self.btnRapidlyImprovingNo)
                    }
                    
                    if response.result.value!.result![0].recent_trauma_surgery == true {
                        self.btnRecentTraumaSurgeryYes.isSelected = true
                    } else if response.result.value!.result![0].recent_trauma_surgery == false {
                        self.btnRecentTraumaSurgeryNo.isSelected = true
                    } else {
                        self.clearSelectionButtons(btn1: self.btnRecentTraumaSurgeryYes, btn2: self.btnRecentTraumaSurgeryNo)
                    }
                    
                    if response.result.value!.result![0].recent_active_bleed == true {
                        self.btnRecentActiveBleedingYes.isSelected = true
                    } else if response.result.value!.result![0].recent_active_bleed == false {
                        self.btnRecentActiveBleedingNo.isSelected = true
                    } else {
                        self.clearSelectionButtons(btn1: self.btnRecentActiveBleedingYes, btn2: self.btnRecentActiveBleedingNo)
                    }
                    
                    if response.result.value!.result![0].seizure_onset == true {
                        self.btnSeizureAtOnsetYes.isSelected = true
                    } else if response.result.value!.result![0].seizure_onset == false {
                        self.btnSeizureAtOnsetNo.isSelected = true
                    } else {
                        self.clearSelectionButtons(btn1: self.btnSeizureAtOnsetYes, btn2: self.btnSeizureAtOnsetNo)
                    }
                    
                    if response.result.value!.result![0].recent_arterial_puncture == true {
                        self.btnRecenntArterialPunctureYes.isSelected = true
                    } else if response.result.value!.result![0].recent_arterial_puncture == false {
                        self.btnRecenntArterialPunctureNo.isSelected = true
                    } else {
                        self.clearSelectionButtons(btn1: self.btnRecenntArterialPunctureYes, btn2: self.btnRecenntArterialPunctureNo)
                    }
                    
                    if response.result.value!.result![0].recent_lumbar_puncture == true {
                        self.bntRecentLumbarPunctureYes.isSelected = true
                    } else if response.result.value!.result![0].recent_lumbar_puncture == false {
                        self.bntRecentLumbarPunctureNo.isSelected = true
                    } else {
                        self.clearSelectionButtons(btn1: self.bntRecentLumbarPunctureYes, btn2: self.bntRecentLumbarPunctureNo)
                    }
                    
                    if response.result.value!.result![0].post_acs_pericarditis == true {
                        self.btnPostACSPericarditisYes.isSelected = true
                    } else if response.result.value!.result![0].post_acs_pericarditis == false {
                        self.btnPostACSPericarditisNo.isSelected = true
                    } else {
                        self.clearSelectionButtons(btn1: self.btnPostACSPericarditisYes, btn2: self.btnPostACSPericarditisNo)
                    }
                    
                    if response.result.value!.result![0].pregnant == true {
                        self.btnPregnantYes.isSelected = true
                    } else if response.result.value!.result![0].pregnant == false {
                        self.btnPregnantNo.isSelected = true
                    } else {
                        self.clearSelectionButtons(btn1: self.btnPregnantYes, btn2: self.btnPregnantNo)
                    }
                    
                    if response.result.value!.result![0].ecr == true {
                        self.btnECRYes.isSelected = true
                    } else if response.result.value!.result![0].ecr == false {
                        self.btnECRNo.isSelected = true
                    } else {
                        self.clearSelectionButtons(btn1: self.btnECRYes, btn2: self.btnECRNo)
                    }
                    
                    if response.result.value!.result![0].surgical_rx == true {
                        self.btnSurgicalManagementYes.isSelected = true
                    } else if response.result.value!.result![0].surgical_rx == false {
                        self.btnSurgicalManagementNo.isSelected = true
                    } else {
                        self.clearSelectionButtons(btn1: self.btnSurgicalManagementYes, btn2: self.btnSurgicalManagementNo)
                    }
                    
                    if response.result.value!.result![0].conservative_rx == true {
                        self.btnConservativeManagementYes.isSelected = true
                    } else if response.result.value!.result![0].conservative_rx == false {
                        self.btnConservativeManagementNo.isSelected = true
                    } else {
                        self.clearSelectionButtons(btn1: self.btnConservativeManagementYes, btn2: self.btnConservativeManagementNo)
                    }
                }
            } else {
                showAlert("Database return nil value")
            }
        }
    }
}
