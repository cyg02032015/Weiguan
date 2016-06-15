//
//  UIView+EX.swift
//  jizhi
//
//  Created by C on 15/10/20.
//  Copyright © 2015年 YoungKook. All rights reserved.
//

import UIKit

extension UIView {
    /// 模糊效果
    func insertBlurView (view: UIView,  style: UIBlurEffectStyle) {
        view.backgroundColor = UIColor.clearColor()
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        view.insertSubview(blurEffectView, atIndex: 0)
    }
    
    
}

