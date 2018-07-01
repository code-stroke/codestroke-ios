//
//  DestinationVC.swift
//  CodeStrokeAlert
//
//  Created by Jayesh on 19/06/18.
//  Copyright © 2018 Jayesh. All rights reserved.
//

import UIKit

private var selectorColorAssociationKey: UInt8 = 0

extension UIPickerView {
    
    @IBInspectable var selectorColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, &selectorColorAssociationKey) as? UIColor
        }
        set(newValue) {
            objc_setAssociatedObject(self, &selectorColorAssociationKey, newValue,
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    open override func didAddSubview(_ subview: UIView) {
        
        super.didAddSubview(subview)
        if let color = selectorColor {
            if subview.bounds.height < 1.0 {
                subview.backgroundColor = color
            }
        }
    }
}

class DestinationVC: UIViewController {

    // MARK: - Declarations -
    
    @IBOutlet weak var btnNext: DesignableButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var viewTop: UIView!

    var prodotti = ["Royal Melbourne", "Austin", "St. Vincent’s Hospital"]
    
    // MARK: - ViewController LifeCycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Destination"
        
        viewTop.layer.shadowColor = UIColor.lightGray.cgColor
        viewTop.layer.shadowOpacity = 1
        viewTop.layer.shadowOffset = CGSize.zero
        viewTop.layer.cornerRadius = 3.0
        viewTop.layer.shadowRadius = 10
        
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        
        let image1 = self.gradientWithFrametoImage(frame: btnNext.frame, colors: [UIColor(red: 255/255, green: 105/255, blue: 97/255, alpha: 1).cgColor, UIColor(red: 255/255, green: 141/255, blue: 41/255, alpha: 1).cgColor])!
        self.btnNext.backgroundColor = UIColor(patternImage: image1)
    }

    // MARK: - Action Methods -
    
    @IBAction func btnNextClicked(_ sender: DesignableButton) {
        
        self.performSegue(withIdentifier: "ClinicalHistory", sender: self)
    }
    
    // MARK: - Memory Warning -
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation -

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ClinicalHistory" {
            
            let destination = segue.destination as! ClinicalHistoryVC
            print(destination)
        }
    }
}

// MARK: - Picker Controller Delegate -

extension DestinationVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView:  UIPickerView) -> Int  {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return prodotti.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return prodotti[row]
    }
}
