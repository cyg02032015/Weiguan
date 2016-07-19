//
//  ZSPasswordView.swift
//  Password(Swift)
//
//  Created by 张森 on 15/12/14.
//  Copyright © 2015年 张森. All rights reserved.
//
import UIKit

protocol ZSPasswordViewDelegate: class {
    func zaPasswordSendText(text: String)
}

class ZSPasswordView: UIView,UITextFieldDelegate {
    
    weak var delegate: ZSPasswordViewDelegate!
    let passwordLength : NSInteger=6
    static let space : CGFloat = 10
    let space : CGFloat = 10
    
    var textFiledString : String {
        get{
            return self.textFiled.text!
        }
    }
    
    var _frame : CGRect?
    override var frame : CGRect {
        get{
            return _frame!
        }
        set{
            _frame = newValue
            super.frame = _frame!
            self.createUI(_frame!)
        }
    }
    
    lazy var textFiled:UITextField = {
        let tempTextFiled : UITextField = UITextField.init()
        tempTextFiled.backgroundColor = UIColor.whiteColor()
        tempTextFiled.layer.masksToBounds = true
        tempTextFiled.layer.borderColor = UIColor.grayColor().CGColor
        tempTextFiled.layer.borderWidth = 1
        tempTextFiled.layer.cornerRadius = space * 0.5
        tempTextFiled.secureTextEntry = true
        tempTextFiled.delegate = self
        tempTextFiled.tintColor = UIColor.clearColor()
        tempTextFiled.textColor = UIColor.clearColor()
        tempTextFiled.font = UIFont.systemFontOfSize(30)
        tempTextFiled.keyboardType = UIKeyboardType.NumberPad
        tempTextFiled.addTarget(self, action: #selector(ZSPasswordView.textFiledEdingChanged), forControlEvents: UIControlEvents.EditingChanged)
        return tempTextFiled
    }()
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let str = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
        return str.characters.count <= passwordLength
    }
    
    func textFiledEdingChanged() {
        let length : NSInteger = (self.textFiled.text?.characters.count)!
        for i : NSInteger in 0 ..< passwordLength {
            let dotLabel : UILabel? = (self.viewWithTag(i + 1) as! UILabel)
            if(dotLabel != nil){
                self.bringSubviewToFront(dotLabel!)
                dotLabel!.hidden = length <= i
            }
        }
        if delegate != nil {
            delegate.zaPasswordSendText(self.textFiled.text!)
        }
        
        self.textFiled.sendActionsForControlEvents(UIControlEvents.ValueChanged)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if delegate != nil {
            delegate.zaPasswordSendText(self.textFiled.text!)
        }
    }
    
    func createUI(frame:CGRect){
        self.addSubview(self.textFiled)
        self.textFiled.frame = CGRectMake(0,0,self.frame.size.width,self.frame.size.height)
        let perWidth:CGFloat = (frame.size.width - (CGFloat)(passwordLength) + 1) / CGFloat(passwordLength)
        for i:Int in 0 ..< passwordLength {
            if (i < passwordLength - 1){
                let lineLabel:UIView = UIView.init()
                lineLabel.backgroundColor = UIColor.lightGrayColor()
                lineLabel.frame = CGRectMake(CGFloat(i + 1) * frame.size.width / CGFloat (passwordLength) + 1, 0, 1, frame.height)
                self.addSubview(lineLabel)
            }
            
            var dotLabel:UILabel? = self.viewWithTag(i+1) as? UILabel
            if (dotLabel == nil){
                dotLabel = UILabel.init()
                dotLabel!.tag = i + 1
                self.addSubview(dotLabel!)
            }
            dotLabel?.frame = CGRectMake((perWidth + 1) * CGFloat (i) + (perWidth - space) * 0.5, (frame.size.height - space) * 0.5, space, space)
            dotLabel?.layer.masksToBounds = true
            dotLabel?.layer.cornerRadius = space * 0.5
            dotLabel?.backgroundColor = UIColor.blackColor()
            dotLabel?.hidden = true
        }
    }
}
