//
//  NSString+EX.swift
//  jizhi
//
//  Created by C on 15/10/20.
//  Copyright © 2015年 YoungKook. All rights reserved.
//

import UIKit

extension NSString {
    func sizeWithFonts(textFont: CGFloat) -> CGSize {
        return self.boundingRectWithSize(CGSize(width: ScreenWidth, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(textFont)], context: nil).size
    }
    
    func sizeWithFonts(textFont: CGFloat, maxX: CGFloat) -> CGSize {
        return self.boundingRectWithSize(CGSize(width: maxX, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(textFont)], context: nil).size
    }
}
