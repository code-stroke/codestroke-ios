//
//  DashboardNavigation.swift
//  CodeStrokeAlert
//
//  Created by Jayesh on 19/06/18.
//  Copyright © 2018 Jayesh. All rights reserved.
//

import UIKit

class DashboardNavigation: UINavigationController {
    
    // MARK:- ViewController LifeCycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let navFrames = self.navigationBar.frame
        let newframe = CGRect(origin: .zero, size: CGSize(width: navFrames.width, height: (navFrames.height + UIApplication.shared.statusBarFrame.height) ))
        let image = self.gradientWithFrametoImage(frame: newframe, colors: [UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1).cgColor, UIColor(red: 255/255, green: 141/255, blue: 41/255, alpha: 1).cgColor])!
        
        self.navigationBar.barTintColor = UIColor(patternImage: image)
        self.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.white,
             NSAttributedStringKey.font: UIFont(name: "SFUIDisplay-Semibold", size: 22)!]
        
    }
    
    // MARK:- Memory Warning -
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation -
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
