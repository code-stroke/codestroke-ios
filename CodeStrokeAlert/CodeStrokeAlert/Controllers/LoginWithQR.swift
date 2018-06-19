//
//  LoginWithQR.swift
//  CodeStrokeAlert
//
//  Created by Jayesh on 18/06/18.
//  Copyright © 2018 Jayesh. All rights reserved.
//

import UIKit

class LoginWithQR: UIViewController {

    // MARK:- Declarations -
    
    @IBOutlet weak var btnLoginGPlus: UIButton!
    @IBOutlet weak var btnLoginFB: UIButton!
    @IBOutlet weak var btnLoginTwitter: UIButton!
    
    // MARK:- ViewController LifeCycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Login"
        
        let image1 = self.gradientWithFrametoImage(frame: btnLoginGPlus.frame, colors: [UIColor(red: 250/255, green: 129/255, blue: 105/255, alpha: 1).cgColor, UIColor(red: 243/255, green: 74/255, blue: 56/255, alpha: 1).cgColor])!
        self.btnLoginGPlus.backgroundColor = UIColor(patternImage: image1)
        self.btnLoginGPlus.layer.cornerRadius = 5.0
        
        let image2 = self.gradientWithFrametoImage(frame: btnLoginFB.frame, colors: [UIColor(red: 109/255, green: 146/255, blue: 201/255, alpha: 1).cgColor, UIColor(red: 59/255, green: 89/255, blue: 152/255, alpha: 1).cgColor])!
        self.btnLoginFB.backgroundColor = UIColor(patternImage: image2)
        self.btnLoginFB.layer.cornerRadius = 5.0
        
        let image3 = self.gradientWithFrametoImage(frame: btnLoginTwitter.frame, colors: [UIColor(red: 7/255, green: 212/255, blue: 250/255, alpha: 1).cgColor, UIColor(red: 3/255, green: 169/255, blue: 244/255, alpha: 1).cgColor])!
        self.btnLoginTwitter.backgroundColor = UIColor(patternImage: image3)
        self.btnLoginTwitter.layer.cornerRadius = 5.0
    }
    
    // MARK:- Action Methods -
    
    @IBAction func btnLoginGPlusClicked(_ sender: UIButton) {
    
        appDelegate.goToDeshBordView()
    }
    
    @IBAction func btnLoginFBClicked(_ sender: UIButton) {
        
        appDelegate.goToDeshBordView()
    }
    
    @IBAction func btnLoginTwitterClicked(_ sender: UIButton) {
        
        appDelegate.goToDeshBordView()
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
