//
//  PatientDetailVC.swift
//  CodeStrokeAlert
//
//  Created by Jayesh on 19/06/18.
//  Copyright © 2018 Jayesh. All rights reserved.
//

import UIKit

class PatientDetailVC: UIViewController {

    // MARK:- Declarations -
    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var btnFirstNameUnknown: DesignableButton!
    @IBOutlet weak var txtSurname: UITextField!
    @IBOutlet weak var btnSurnameUnknown: DesignableButton!
    @IBOutlet weak var txtDOB: DesignableTextField!
    @IBOutlet weak var btnDOBUnknown: DesignableButton!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var btnAddressUnknown: DesignableButton!
    @IBOutlet weak var segmentGender: UISegmentedControl!
    @IBOutlet weak var btnGenderUnspecified: DesignableButton!
    
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblHours: UILabel!
    @IBOutlet weak var lblMins: UILabel!
    @IBOutlet weak var lblAMPM: UILabel!
    @IBOutlet weak var btnLastSeen: UIButton!
    
    @IBOutlet weak var btnDateUnknown: DesignableButton!
    
    @IBOutlet weak var txtNextToKIN: UITextField!
    @IBOutlet weak var btnNextToKINUnknown: DesignableButton!
    @IBOutlet weak var txtNOKTelephone: UITextField!
    @IBOutlet weak var btnNOKTelephoneUnknown: DesignableButton!
    
    
    @IBOutlet weak var btnNext: DesignableButton!
    
    // MARK:- ViewController LifeCycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let image1 = self.gradientWithFrametoImage(frame: btnNext.frame, colors: [UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1).cgColor, UIColor(red: 255/255, green: 141/255, blue: 41/255, alpha: 1).cgColor])!
        self.btnNext.backgroundColor = UIColor(patternImage: image1)
        
        let f = DateFormatter()
        f.dateFormat = "EEEE MMM dd hh:mm a"
        let formattedDate: String = f.string(from: Date())
        let arrayDate = formattedDate.components(separatedBy: " ")
        self.lblDay.text = arrayDate[0].uppercased()
        self.lblDate.text = "\(arrayDate[1]) \((arrayDate[2]))"
        let arrayTime = arrayDate[3].components(separatedBy: ":")
        self.lblHours.text = arrayTime[0]
        self.lblMins.text = arrayTime[1]
        self.lblAMPM.text = arrayDate[4]
    }

    // MARK:- Action Methods -
    
    @IBAction func btnNextClicked(_ sender: DesignableButton) {
        
        if isEmptyString(self.txtFirstName.text!) && self.btnFirstNameUnknown.isSelected == false {
            showAlert("Please enter firstname")
        } else if isEmptyString(self.txtSurname.text!) && self.btnSurnameUnknown.isSelected == false {
            showAlert("Please enter surname")
        } else if isEmptyString(self.txtDOB.text!) && self.btnDOBUnknown.isSelected == false {
            showAlert("Please select dob")
        } else if isEmptyString(self.txtAddress.text!) && self.btnAddressUnknown.isSelected == false {
            showAlert("Please enter address")
        } else if isEmptyString(self.txtNextToKIN.text!) && self.btnNextToKINUnknown.isSelected == false {
            showAlert("Please enter next to KIN")
        } else if isEmptyString(self.txtNOKTelephone.text!) && self.btnNOKTelephoneUnknown.isSelected == false {
            showAlert("Please enter NOK Telephone")
        } else {
            self.performSegue(withIdentifier: "Destination", sender: self)
        }
    }
    
    @IBAction func btnUnknownClicked(_ sender: DesignableButton) {
        
        if sender.isSelected {
            sender.isSelected = false
            sender.backgroundColor = UIColor.init(red: 197.0/255.0, green: 210.0/255.0, blue: 216.0/255.0, alpha: 1.0)
            
            if sender.tag == 5 {
                segmentGender.selectedSegmentIndex = 0
                segmentGender.isUserInteractionEnabled = true
            }
            
        } else {
            sender.isSelected = true
            sender.backgroundColor = UIColor.init(red: 43.0/255.0, green: 143.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            
            if sender.tag == 5 {
                segmentGender.selectedSegmentIndex = UISegmentedControlNoSegment
                segmentGender.isUserInteractionEnabled = false
            }
        }
    }
    
    @IBAction func btnDateClicked(_ sender: UIButton) {
        
        self.btnLastSeen.isSelected = true
        self.txtDOB.isSelected = false
        self.openDatePicker()
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        
    }
    
    // MARK:- Memory Warning -
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation -

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "Destination" {
            
            let destination = segue.destination as! DestinationVC
            print(destination)
        }
    }
}

// MARK: - UITextField Delegate -

extension PatientDetailVC: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        self.btnLastSeen.isSelected = false
        self.txtDOB.isSelected = true
        self.openDatePicker()
        
        return false
    }
}

// MARK: - Extension for DatePicker -

extension PatientDetailVC {
    
    func openDatePicker() {
        
        self.view.endEditing(true)
        let style = RMActionControllerStyle.white
        
        let cancelAction = RMAction<UIDatePicker>(title: "Cancel", style: RMActionStyle.cancel) { _ in
            
            print("Date selection was canceled")
        }
        
        let selectAction = RMAction<UIDatePicker>(title: "Select", style: RMActionStyle.done) { controller in
            
            if let pickerController = controller as? RMDateSelectionViewController {
                
                let f = DateFormatter()
                
                if self.btnLastSeen.isSelected == true {
                    f.dateFormat = "EEEE MMM dd hh:mm a"
                    let formattedDate: String = f.string(from: pickerController.datePicker.date)
                    
                    let arrayDate = formattedDate.components(separatedBy: " ")
                    self.lblDay.text = arrayDate[0].uppercased()
                    self.lblDate.text = "\(arrayDate[1]) \((arrayDate[2]))"
                    let arrayTime = arrayDate[3].components(separatedBy: ":")
                    self.lblHours.text = arrayTime[0]
                    self.lblMins.text = arrayTime[1]
                    self.lblAMPM.text = arrayDate[4]
                } else {
                    f.dateFormat = "MMM dd, yyyy"
                    let formattedDate: String = f.string(from: pickerController.datePicker.date)
                    self.txtDOB.text = formattedDate
                }
            }
        }
        
        let actionController = RMDateSelectionViewController(style: style, title: "Please select date", message: nil, select: selectAction, andCancel: cancelAction)!
        
        if self.btnLastSeen.isSelected == true {
            actionController.datePicker.datePickerMode = .dateAndTime
        } else {
            actionController.datePicker.set18YearValidation()
            actionController.datePicker.datePickerMode = .date
        }
        
        appDelegate.window?.rootViewController!.present(actionController, animated: true, completion: nil)
    }
}
