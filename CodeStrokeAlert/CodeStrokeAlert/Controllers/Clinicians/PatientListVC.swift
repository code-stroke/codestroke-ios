//
//  PatientListVC.swift
//  CodeStrokeAlert
//
//  Created by Jayesh on 27/06/18.
//  Copyright © 2018 Jayesh. All rights reserved.
//

import UIKit

class PatientListCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblETA: UILabel!
    @IBOutlet weak var viewShadow: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.viewShadow.dropShadow(color: UIColor.init(red: 0.0/255.0, green: 90.0/255.0, blue: 192.0/255.0, alpha: 0.44), viewShadow: self.viewShadow)
    }
}

class PatientListVC: UIViewController {
    
    // MARK: - Declarations -
    
    @IBOutlet weak var tblPatientList: UITableView!
    @IBOutlet weak var btnIncoming: UIButton!
    @IBOutlet weak var btnActive: UIButton!
    @IBOutlet weak var btnCompleted: UIButton!
    @IBOutlet weak var leading_Slider: NSLayoutConstraint!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var arrCaseList = [CaseList]()
    var arrCaseListActive = [CaseList]()
    var arrCaseListInComing = [CaseList]()
    var arrCaseListCompleted = [CaseList]()
    var filtered: [CaseList] = []
    var searchActive : Bool = false
    
    // MARK: - View Controller Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "CODE STROKE"
        // Do any additional setup after loading the view.
        
        searchBar.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if Reachability.isConnectedToNetwork() {
            DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.async {
                    self.WS_PatientInfo(url: AppURL.baseURL + AppURL.CaseList)
                }
            }
        } else {
            showAlert("No internet connection")
        }
    }
    
    // MARK: - Action Methods -
    
    @IBAction func btnSearchClicked(_ sender: UIBarButtonItem) {
        
        
    }
    
    @IBAction func btnCaseListClicked(_ sender: UIButton) {
        
        self.clearSelection()
        sender.isSelected = true
        searchActive = false
        searchBar.text = ""
        var x: CGFloat = 0
        
        if sender.tag == 1 {
            x = 0
            self.filtered = self.arrCaseListActive
        } else if sender.tag == 2 {
            x = btnActive.frame.origin.x
            self.filtered = self.arrCaseListInComing
        } else if sender.tag == 3 {
            x = btnCompleted.frame.origin.x
            self.filtered = self.arrCaseListCompleted
        }
        
        UIView.animate(withDuration: 0.22) {
            self.leading_Slider.constant = x
            self.view.layoutIfNeeded()
        }
        
        self.view.endEditing(true)
        self.tblPatientList.reloadData()
    }
    
    // MARK: - Custom Methods -
    
    func clearSelection() {
        
        self.btnActive.isSelected = false
        self.btnIncoming.isSelected = false
        self.btnCompleted.isSelected = false
    }
    
    // MARK: - Memory Warning -
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation -
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ClinicianPatientDetail" {
            
            let destination = segue.destination as! MainContainerVC
            print(destination)
        }
    }
}

extension PatientListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchActive {
            return filtered.count
        } else {
            if self.btnActive.isSelected {
                return self.arrCaseListActive.count
            } else if self.btnIncoming.isSelected {
                return self.arrCaseListInComing.count
            } else {
                return self.arrCaseListCompleted.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: PatientListCell = tableView.dequeueReusableCell(withIdentifier: "PatientListCell", for: indexPath) as! PatientListCell
        
        if searchActive {
            
            cell.lblName.text = "\(self.filtered[indexPath.row].first_name == "unknown" ? "" : self.filtered[indexPath.row].first_name) \(self.filtered[indexPath.row].last_name == "unknown" ? "" : self.filtered[indexPath.row].last_name)"
            
            cell.lblGender.text = self.filtered[indexPath.row].gender == "f" ? "Female" : "Male"
            
            if self.filtered[indexPath.row].dob != "" {
                let strDOB = self.calcAge(birthday: self.filtered[indexPath.row].dob)
                cell.lblAge.text = "\(strDOB)"
            }
            
            cell.lblETA.text = ""
            
            if let date = self.filtered[indexPath.row].eta.toDate("yyyy-MM-dd HH:mm") {
                
                cell.lblETA.text = date.toString("dd, MMM yyyy hh:mm a")
            }
            
        } else {
            
            if self.btnActive.isSelected {
                
                cell.lblName.text = "\(self.arrCaseListActive[indexPath.row].first_name == "unknown" ? "" : self.arrCaseListActive[indexPath.row].first_name) \(self.arrCaseListActive[indexPath.row].last_name == "unknown" ? "" : self.arrCaseListActive[indexPath.row].last_name)"
                
                cell.lblGender.text = self.arrCaseListActive[indexPath.row].gender == "f" ? "Female" : "Male"
                
                if self.arrCaseListActive[indexPath.row].dob != "" {
                    let strDOB = self.calcAge(birthday: self.arrCaseListActive[indexPath.row].dob)
                    cell.lblAge.text = "\(strDOB)"
                }
                
                cell.lblETA.text = ""
                
                if let date = self.arrCaseListActive[indexPath.row].eta.toDate("yyyy-MM-dd HH:mm") {
                    
                    cell.lblETA.text = date.toString("dd, MMM yyyy hh:mm a")
                }
                
            } else if self.btnIncoming.isSelected {
                
                cell.lblName.text = "\(self.arrCaseListInComing[indexPath.row].first_name == "unknown" ? "" : self.arrCaseListInComing[indexPath.row].first_name) \(self.arrCaseListInComing[indexPath.row].last_name == "unknown" ? "" : self.arrCaseListInComing[indexPath.row].last_name)"
                cell.lblGender.text = self.arrCaseListInComing[indexPath.row].gender == "f" ? "Female" : "Male"
                
                if self.arrCaseListInComing[indexPath.row].dob != "" {
                    let strDOB = self.calcAge(birthday: self.arrCaseListInComing[indexPath.row].dob)
                    cell.lblAge.text = "\(strDOB)"
                }
                
                cell.lblETA.text = ""
                
                if let date = self.arrCaseListInComing[indexPath.row].eta.toDate("yyyy-MM-dd HH:mm") {
                    
                    cell.lblETA.text = date.toString("dd, MMM yyyy hh:mm a")
                }
                
            } else if self.btnCompleted.isSelected {
                
                cell.lblName.text = "\(self.arrCaseListCompleted[indexPath.row].first_name == "unknown" ? "" : self.arrCaseListCompleted[indexPath.row].first_name) \(self.arrCaseListCompleted[indexPath.row].last_name == "unknown" ? "" : self.arrCaseListCompleted[indexPath.row].last_name)"
                cell.lblGender.text = self.arrCaseListCompleted[indexPath.row].gender == "f" ? "Female" : "Male"
                
                if self.arrCaseListCompleted[indexPath.row].dob != "" {
                    let strDOB = self.calcAge(birthday: self.arrCaseListCompleted[indexPath.row].dob)
                    cell.lblAge.text = "\(strDOB)"
                }
                
                cell.lblETA.text = ""
                
                if let date = self.arrCaseListCompleted[indexPath.row].eta.toDate("yyyy-MM-dd HH:mm") {
                    
                    cell.lblETA.text = date.toString("dd, MMM yyyy hh:mm a")
                }
            }
        }
        
        cell.lblName.text = cell.lblName.text!.trim
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if searchActive {
            filtered[indexPath.row].save()
        } else {
            if self.btnActive.isSelected {
                self.arrCaseListActive[indexPath.row].save()
            } else if self.btnIncoming.isSelected {
                self.arrCaseListInComing[indexPath.row].save()
            } else {
                self.arrCaseListCompleted[indexPath.row].save()
            }
        }
        self.performSegue(withIdentifier: "ClinicianPatientDetail", sender: indexPath)
    }
}

extension PatientListVC: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
        self.searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        self.searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        self.searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if self.btnActive.isSelected {
            self.filtered = self.arrCaseListActive.filter { user in
                let first_name = "\(user.first_name) \(user.last_name)"
                return first_name.localizedCaseInsensitiveContains(searchText) == true
            }
        } else if self.btnIncoming.isSelected {
            self.filtered = self.arrCaseListInComing.filter { user in
                let first_name = "\(user.first_name) \(user.last_name)"
                return first_name.localizedCaseInsensitiveContains(searchText) == true
            }
        } else {
            self.filtered = self.arrCaseListCompleted.filter { user in
                let first_name = "\(user.first_name) \(user.last_name)"
                return first_name.localizedCaseInsensitiveContains(searchText) == true
            }
        }
        
        if(filtered.count == 0){
            searchActive = false
        } else {
            searchActive = true
        }
        
        self.tblPatientList.reloadData()
    }
}
