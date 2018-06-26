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
