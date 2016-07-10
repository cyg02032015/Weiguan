//
//  ViewController.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/7.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

public class TouchLabel: UILabel {
    private var target: AnyObject!
    private var action: Selector!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.userInteractionEnabled = true
    }
    
    public func addTarget(target: AnyObject!, action: Selector) {
        self.target = target
        self.action = action
    }
    
    public override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        target.performSelector(action)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class ViewFactory
    
{
    
    class func createButton(title:String, action:Selector, sender:UIViewController)->UIButton
        
    {
        
        let button = UIButton()
        button.setTitle(title, forState:.Normal)
        button.titleLabel!.font = UIFont.customFontOfSize(14)
        return button
        
    }
}
