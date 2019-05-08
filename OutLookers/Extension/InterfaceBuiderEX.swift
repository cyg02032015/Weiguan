//
//  InterfaceBuiderEX.swift
//  Zhaoshi365
//
//  Created by C on 15/9/7.
//  Copyright (c) 2015年 YoungKook. All rights reserved.
//

import UIKit

class SBQuick {
    class func loadStoryBoard(storyboard: String, identifier: String) -> UIViewController {
        return UIStoryboard(name: storyboard, bundle: nil).instantiateViewControllerWithIdentifier(identifier) as UIViewController
    }
    
}

class LoadXib {
    class func nibName(name: String) -> UIView {
        return NSBundle.mainBundle().loadNibNamed(name, owner: nil, options: nil)!.last as! UIView
    }
}

class LoadNib {
    class func nibName(name: String) -> UINib? {
        return UINib(nibName: name, bundle: nil)
    }
}

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(CGColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.CGColor
        }
    }
    @IBInspectable var hexRgbColor: NSString {
        get {
            return "0xffffff";
        }
        set {
            
            let scanner = NSScanner(string: newValue as String)
            var hexNum = 0 as UInt32
            
            if (scanner.scanHexInt(&hexNum)){
                let r = (hexNum >> 16) & 0xFF
                let g = (hexNum >> 8) & 0xFF
                let b = (hexNum) & 0xFF
                
                self.backgroundColor = UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
            }
            
        }
    }
    
    @IBInspectable var onePx: Bool {
        get {
            return self.onePx
        }
        set {
            if (onePx == true){
                self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 1 / UIScreen.mainScreen().scale)
            }
        }
    }
}

extension UIButton{
    @IBInspectable var textHexColor: NSString {
        get {
            return "0xffffff";
        }
        set {
            let scanner = NSScanner(string: newValue as String)
            var hexNum = 0 as UInt32
            
            if (scanner.scanHexInt(&hexNum)){
                let r = (hexNum >> 16) & 0xFF
                let g = (hexNum >> 8) & 0xFF
                let b = (hexNum) & 0xFF
                
                self.setTitleColor(UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0), forState: .Normal)
            }
        }
    }
}

extension UILabel{
    @IBInspectable var textHexColor: NSString {
        get {
            return "0xffffff";
        }
        set {
            let scanner = NSScanner(string: newValue as String)
            var hexNum = 0 as UInt32
            
            if (scanner.scanHexInt(&hexNum)){
                let r = (hexNum >> 16) & 0xFF
                let g = (hexNum >> 8) & 0xFF
                let b = (hexNum) & 0xFF
                
                self.textColor = UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
            }
        }
    }
}
