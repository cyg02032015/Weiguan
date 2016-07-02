//
//  YGTabbarButton.swift
//  SuperWay
//
//  Created by C on 15/9/16.
//  Copyright © 2015年 YoungKook. All rights reserved.
//

import UIKit

class YGTabbarButton: UIButton {

    var _item: UITabBarItem!
    var item: UITabBarItem! {
        didSet {
            item.addObserver(self, forKeyPath: "image", options: .New, context: nil)
            item.addObserver(self, forKeyPath: "title", options: .New, context: nil)
            item.addObserver(self, forKeyPath: "selectedImage", options: .New, context: nil)
            item.addObserver(self, forKeyPath: "badgeValue", options: .New, context: nil)
            self.observeValueForKeyPath(nil, ofObject: nil, change: nil, context: nil)
            
        }
    }
    
    override var highlighted: Bool { set {} get{return false}}
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageView!.contentMode = .ScaleAspectFit
        self.titleLabel!.font = UIFont.systemFontOfSize(10)
        self.titleLabel!.textAlignment = .Center
        self.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
    }

    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        self.setTitle(item.title, forState: .Normal)
        self.setImage(item.image, forState: UIControlState.Normal)
        self.setImage(item.selectedImage, forState: UIControlState.Selected)
        self.setTitleColor(UIColor(hex: 0xC8C8C8), forState: .Normal)
        self.setTitleColor(UIColor(hex: 0x64B8FF), forState: .Selected)
        guard let badge = item.badgeValue else {
            LogError("badgeValue is nil")
            return
        }
        if Int(badge) > 0 {
            self.badgeValue = badge
            self.badgeOriginX = self.width - 20
            self.badgeOriginY = self.y + 5
            self.shouldAnimateBadge = true
        } else {
            self.badgeValue = ""
        }
    }
    
    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
        let image = self.imageForState(.Normal)
        if image == nil {
            return CGRectZero
        }
//        return CGRect(x: 0, y: 2, width: contentRect.size.width, height: image!.size.height - 8)
        return CGRect(x: self.width/2 - 15, y: 3, width: 30, height: 30)
    }
    
    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
        let image = self.imageForState(.Normal)
        if image == nil {
            return CGRectZero
        }
        return CGRect(x: 0, y: self.height - 14, width: contentRect.size.width, height: 10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented - YGTabbarButton")
    }
}
