//
//  TextFieldDesign.swift
//  CasaMatchNew
//
//  Created by osvinuser on 19/10/16.
//  Copyright © 2016 osvinuser. All rights reserved.
//

import UIKit

@IBDesignable class TextFieldDesign: UITextField {
    
    @IBInspectable var paddingLeft: CGFloat = 0
    @IBInspectable var paddingRight: CGFloat = 0
    
    @IBInspectable var leftAddView: CGRect = CGRect.zero
    @IBInspectable var leftimageView: CGRect = CGRect.zero
    
    @IBInspectable var rightAddView: CGRect = CGRect.zero
    @IBInspectable var rightimageView: CGRect = CGRect.zero
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: newValue!])
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornurRadius: CGFloat = 1.0 {
        didSet {
            layer.cornerRadius = cornurRadius
        }
    }
    
    @IBInspectable var shadowColor: UIColor = UIColor.darkGray {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.0 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0.0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    
    @IBInspectable var masksToBounds: Bool = false {
        didSet {
            layer.masksToBounds = masksToBounds
        }
    }
    
    @IBInspectable var shadowOffset : CGSize {
        get {
            return layer.shadowOffset;
        }
        set {
            layer.shadowOffset = newValue;
        }
    }
    
    @IBInspectable var SideImage:UIImage? {
        didSet{
            
            let leftAddView = UIView(frame: self.leftAddView)
            let leftimageView = UIImageView(frame: self.leftimageView)//Create a imageView for left side.
            leftimageView.image = SideImage
            leftAddView.addSubview(leftimageView)
            self.leftView = leftAddView
            self.leftViewMode = UITextFieldViewMode.always
        }
    }
    
    @IBInspectable var rightSideImage:UIImage? {
        didSet{
            
            let rightAddView = UIView(frame: self.rightAddView)
            let rightimageView = UIImageView(frame: self.rightimageView)//Create a imageView for right side.
            rightimageView.image = rightSideImage
            rightAddView.addSubview(rightimageView)
            self.rightView = rightAddView
            self.rightViewMode = UITextFieldViewMode.always
        }
        
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + paddingLeft, y: bounds.origin.y, width: bounds.size.width - paddingLeft - paddingRight, height: bounds.size.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
