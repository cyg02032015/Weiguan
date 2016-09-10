//
//  ViewController.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/7.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class TouchLabel: UILabel {
    
    typealias TouchClick = () -> ()
    
    private var tapLabelClick: TouchClick?
    private var target: AnyObject?
    private var action: Selector?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.userInteractionEnabled = true
    }
    
    func tapLabelAction(touchclick: TouchClick?) {
        self.tapLabelClick = touchclick
    }
    
    func addTarget(target: AnyObject?, action: Selector?) {
        self.target = target
        self.action = action
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let _ = action {
            target?.performSelector(action!)
        }else if let _ = tapLabelClick {
            tapLabelClick!()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class TouchView: UIView {
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

class TouchImageView: UIImageView {
    typealias TouchClick = () -> ()

    private var tapImageClick: TouchClick?
    private weak var target: AnyObject?
    private var action: Selector?
    
    weak var cell: HomeCollectionCell!
    
    convenience init() {
        self.init(frame: CGRectZero)
        self.userInteractionEnabled = true
    }
    
    func tapImageAction(touchclick: TouchClick?) {
        self.tapImageClick = touchclick
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.userInteractionEnabled = true
    }
    
    func addTarget(target: AnyObject?, action: Selector?) {
        self.target = target
        self.action = action
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let _ = action {
            target?.performSelector(action!)
        }else if let _ = tapImageClick {
            tapImageClick!()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}