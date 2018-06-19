//
//  ProfileSummeryVC.swift
//  CodeStrokeAlert
//
//  Created by Jayesh on 19/06/18.
//  Copyright © 2018 Jayesh. All rights reserved.
//

import UIKit

class ProfileSummeryVC: UIViewController {

    @IBOutlet weak var height_Detail: NSLayoutConstraint!
    @IBOutlet weak var height_History: NSLayoutConstraint!
    @IBOutlet weak var height_Mass: NSLayoutConstraint!
    @IBOutlet weak var height_Vitals: NSLayoutConstraint!
    @IBOutlet weak var height_Race: NSLayoutConstraint!
    @IBOutlet weak var height_18GIV: NSLayoutConstraint!
    
    // MARK:- ViewController LifeCycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Profile Summary"
    }

    // MARK:- Action Methods -
    
    @IBAction func btnProfileItemClicked(_ sender: DesignableButton) {
        
        if sender.isSelected == false {
            
            sender.isSelected = true
            
            if sender.tag == 1 {
                UIView.animate(withDuration: 0.22) {
                    self.height_Detail.constant = 280
                    self.view.layoutIfNeeded()
                }
            } else if sender.tag == 2 {
                UIView.animate(withDuration: 0.22) {
                    self.height_History.constant = 280
                    self.view.layoutIfNeeded()
                }
            } else if sender.tag == 3 {
                UIView.animate(withDuration: 0.22) {
                    self.height_Mass.constant = 280
                    self.view.layoutIfNeeded()
                }
            } else if sender.tag == 4 {
                UIView.animate(withDuration: 0.22) {
                    self.height_Vitals.constant = 280
                    self.view.layoutIfNeeded()
                }
            } else if sender.tag == 5 {
                UIView.animate(withDuration: 0.22) {
                    self.height_Race.constant = 280
                    self.view.layoutIfNeeded()
                }
            } else if sender.tag == 6 {
                UIView.animate(withDuration: 0.22) {
                    self.height_18GIV.constant = 280
                    self.view.layoutIfNeeded()
                }
            }
            
        } else {
            
            sender.isSelected = false
            
            if sender.tag == 1 {
                UIView.animate(withDuration: 0.22) {
                    self.height_Detail.constant = 50
                    self.view.layoutIfNeeded()
                }
            } else if sender.tag == 2 {
                UIView.animate(withDuration: 0.22) {
                    self.height_History.constant = 50
                    self.view.layoutIfNeeded()
                }
            } else if sender.tag == 3 {
                UIView.animate(withDuration: 0.22) {
                    self.height_Mass.constant = 50
                    self.view.layoutIfNeeded()
                }
            } else if sender.tag == 4 {
                UIView.animate(withDuration: 0.22) {
                    self.height_Vitals.constant = 50
                    self.view.layoutIfNeeded()
                }
            } else if sender.tag == 5 {
                UIView.animate(withDuration: 0.22) {
                    self.height_Race.constant = 50
                    self.view.layoutIfNeeded()
                }
            } else if sender.tag == 6 {
                UIView.animate(withDuration: 0.22) {
                    self.height_18GIV.constant = 50
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    // MARK:- Memory Warning -
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation -

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}
