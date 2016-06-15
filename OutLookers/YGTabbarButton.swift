//
//  YGTabbarButton.swift
//  SuperWay
//
//  Created by C on 15/9/16.
//  Copyright © 2015年 YoungKook. All rights reserved.
//

import UIKit

class YGTabbarButton: UIButton {

    
    var item: UITabBarItem! {
        didSet {
            item.addObserver(self, forKeyPath: "image", options: .New, context: nil)
            item.addObserver(self, forKeyPath: "title", options: .New, context: nil)
            item.addObserver(self, forKeyPath: "selectedImage", options: .New, context: nil)
            self.observeValueForKeyPath(nil, ofObject: nil, change: nil, context: nil)
            
        }
    }
    
    override var highlighted: Bool { set {} get{return false}}
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageView!.contentMode = .ScaleAspectFit
        self.titleLabel!.font = UIFont.systemFontOfSize(12)
        self.titleLabel!.textAlignment = .Center
        self.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
    }

    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        self.setTitle(item.title, forState: .Normal)
        self.setImage(item.image, forState: UIControlState.Normal)
        self.setImage(item.selectedImage, forState: UIControlState.Selected)
        self.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        self.setTitleColor(UIColor.yellowColor(), forState: .Selected)

    }
    
//    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
//        let image = self.imageForState(.Normal)
//        if image == nil {
//            return CGRectZero
//        }
////        return CGRect(x: 0, y: 2, width: contentRect.size.width, height: image!.size.height - 8)
//        return CGRect(x: self.width/2 - 10, y: 5, width: 20, height: 20)
//    }
//    
//    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
//        let image = self.imageForState(.Normal)
//        if image == nil {
//            return CGRectZero
//        }
////        let titleY = image!.size.height
//        let titleH = contentRect.size.height - 25
//        return CGRect(x: 0, y: 25, width: contentRect.size.width, height: titleH)
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented - YGTabbarButton")
    }
}
