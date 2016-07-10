//
//  UILabel+EX.swift
//  OutLookers
//
//  Created by C on 16/7/9.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

extension UILabel {
    
    class func createLabel(font: CGFloat, textColor: UIColor = UIColor.blackColor()) -> UILabel {
        
        let label = UILabel()
        
        label.textColor = textColor
        
        label.font = UIFont.customFontOfSize(font)
        
        return label
    }
    
}