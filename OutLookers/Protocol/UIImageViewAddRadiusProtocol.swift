//
//  UIImageViewAddRadiusProtocol.swift
//  OutLookers
//
//  Created by 宋碧海 on 16/9/13.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

protocol UIImageViewAddRadiusProtocol {
    func addRadius(imageView: AnyObject, radius: CGFloat, position: CGPoint)
}

extension UIImageViewAddRadiusProtocol {
    func addRadius(imageView: AnyObject, radius: CGFloat, position: CGPoint) {
        if imageView is UIImageView || imageView is IconHeaderView {
            let shapeLayer = CAShapeLayer()
            let path = UIBezierPath()
            path.addArcWithCenter(position, radius: radius, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true)
            shapeLayer.path = path.CGPath
            shapeLayer.lineWidth = 2
            shapeLayer.opacity = 0.5
            shapeLayer.strokeColor = UIColor.whiteColor().CGColor
            shapeLayer.fillColor = UIColor.clearColor().CGColor
            shapeLayer.strokeEnd = 1.0
            imageView.layer.addSublayer(shapeLayer)
        }
    }
}
