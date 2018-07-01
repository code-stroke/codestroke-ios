import Foundation
import KRProgressHUD
import Alamofire

extension PatientDetailVC {
    
    func WS_PatientInfo(url: String, parameter: [String: String]) {
        
        print("\(url)?\(parameter)")
        self.view.isUserInteractionEnabled = false
        self.showHud("")
        
        let headers = ["content-type": "application/json"]
        
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

extension ClinicalHistoryVC {
    
    func WS_ClinicalHistory(url: String, parameter: [String: Any]) {
        
        print("\(url)?\(parameter)")
        self.view.isUserInteractionEnabled = false
        self.showHud("")
        
        let headers = ["content-type": "application/json"]
        
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
        
        let headers = ["content-type": "application/json"]
        
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
        
        let headers = ["content-type": "application/json"]
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseObject { (response : DataResponse<CaseListModel>) in
            self.view.isUserInteractionEnabled = true
            self.hideHUD()
            
            if (response.result.value != nil) {
                
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
        
        let headers = ["content-type": "application/json"]
        
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
                        self.performSegue(withIdentifier: "ClinicianPatientDetailTwo", sender: nil)
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
        
        let headers = ["content-type": "application/json"]
        
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
                        self.performSegue(withIdentifier: "ClinicianPatientDetailThree", sender: nil)
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
        
        let headers = ["content-type": "application/json"]
        
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
                        self.performSegue(withIdentifier: "ClinicianPatientDetailFour", sender: nil)
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
