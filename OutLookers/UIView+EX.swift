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
    
    func dottedLine(cornerRadios cornerRadios: CGFloat, lineColor: UIColor = kLineColor) {
        let border = CAShapeLayer()
        border.strokeColor = lineColor.CGColor
        border.fillColor = UIColor.clearColor().CGColor
        border.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadios).CGPath
        border.frame = self.bounds
        border.lineWidth = 1
        border.lineCap = "square"
        border.lineDashPattern = [4,2]
        self.layer.addSublayer(border)
    }
    
    func getSuperController() -> UIViewController? {
        var obj = self.nextResponder()
        while obj != nil && !obj!.isKindOfClass(UIViewController.self) {
            obj = obj?.nextResponder()
        }
        guard let controller = obj as? UIViewController else {return nil}
        return controller
    }
}

