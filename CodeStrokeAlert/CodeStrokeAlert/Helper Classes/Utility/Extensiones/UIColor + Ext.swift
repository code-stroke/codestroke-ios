//
//  UIColor + Ext.swift
//  Airbuk
//
//  Created by Apple on 05/04/17.
//  Copyright © 2017 Openxcell. All rights reserved.
//

import UIKit

extension UIColor {
    @objc convenience init(colorWithHexValue value: Int, alpha:CGFloat = 1.0){
        self.init(
            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(value & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
