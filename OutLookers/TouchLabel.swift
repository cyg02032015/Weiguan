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

public class TouchImageView: UIImageView {
    private var target: AnyObject!
    private var action: Selector!
    
    weak var cell: HomeCollectionCell!
    
    convenience init() {
        self.init(frame: CGRectZero)
        self.userInteractionEnabled = true
    }
    
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