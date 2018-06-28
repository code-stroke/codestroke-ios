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
}

class PatientListVC: UIViewController {

    // MARK: - Declarations -
    
    @IBOutlet weak var tblPatientList: UITableView!
    @IBOutlet weak var btnIncoming: UIButton!
    @IBOutlet weak var btnActive: UIButton!
    @IBOutlet weak var btnCompleted: UIButton!
    @IBOutlet weak var leading_Slider: NSLayoutConstraint!
    
    // MARK: - View Controller Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CODE STROKE"
        // Do any additional setup after loading the view.
    }

    // MARK: - Action Methods -
    
    @IBAction func btnCaseListClicked(_ sender: UIButton) {
        
        self.clearSelection()
        sender.isSelected = true
        
        var x: CGFloat = 0
        
        if sender.tag == 1 {
            x = 0
        } else if sender.tag == 2 {
            x = btnActive.frame.origin.x
        } else if sender.tag == 3 {
            x = btnCompleted.frame.origin.x
        }
        
        UIView.animate(withDuration: 0.22) {
            self.leading_Slider.constant = x
            self.view.layoutIfNeeded()
        }
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
            
            let destination = segue.destination as! ClinicianPatientDetailVC
            print(destination)
        }
    }
}

extension PatientListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: PatientListCell = tableView.dequeueReusableCell(withIdentifier: "PatientListCell", for: indexPath) as! PatientListCell
        
        cell.lblName.text = "John Smith"
        cell.lblGender.text = "Male"
        cell.lblAge.text = "65"
        cell.lblETA.text = "5 Mins"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "ClinicianPatientDetail", sender: indexPath)
    }
}
