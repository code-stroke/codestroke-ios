//
//  LoginNavigation.swift
//  CodeStrokeAlert
//
//  Created by Jayesh on 18/06/18.
//  Copyright © 2018 Jayesh. All rights reserved.
//

import UIKit

class LoginNavigation: UINavigationController {

    // MARK:- ViewController LifeCycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.navigationBar.prefersLargeTitles = true
        
        let navFrames = self.navigationBar.frame
        
        let newframe = CGRect(origin: .zero, size: CGSize(width: navFrames.width, height: (navFrames.height + UIApplication.shared.statusBarFrame.height) ))
        let image = self.gradientWithFrametoImage(frame: newframe, colors: [UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1).cgColor, UIColor(red: 255/255, green: 141/255, blue: 41/255, alpha: 1).cgColor])!
        
        self.navigationBar.barTintColor = UIColor(patternImage: image)
    }
    
    // MARK:- Memory Warning -
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension UIViewController {
    
    func gradientWithFrametoImage(frame: CGRect, colors: [CGColor]) -> UIImage? {
        
        let gradient: CAGradientLayer  = CAGradientLayer(layer: self.view.layer)
        gradient.frame = frame
        gradient.colors = colors
        UIGraphicsBeginImageContext(frame.size)
        gradient.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
