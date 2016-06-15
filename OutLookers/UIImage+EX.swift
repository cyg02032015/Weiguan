//
//  UIImage+EX.swift
//  SuperWay
//
//  Created by C on 15/9/16.
//  Copyright © 2015年 YoungKook. All rights reserved.
//

import UIKit

//MARK: 拉伸图片
extension UIImage {
    class func resizeImageWith(imagename: String) -> UIImage {
        return self.resizeImageWith(imagename, left: 0.5, top: 0.5)
    }
    class func resizeImageWith(imageName: String, left: CGFloat, top: CGFloat) -> UIImage {
        let image = UIImage(named: imageName)!
        return image.stretchableImageWithLeftCapWidth(Int(ceil(image.size.width*left)), topCapHeight: Int(ceil(image.size.height*top)))
    }
}

extension UIScrollView {
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.nextResponder()?.touchesBegan(touches, withEvent: event)
        super.touchesBegan(touches, withEvent: event)
    }
}
