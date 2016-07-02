//
//  UIFont+EX.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/1.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import Device

extension Selector {
    static let customFontOfSize = #selector(UIFont.customFontOfSize(_:))
    static let systemFontOfSize = #selector(UIFont.systemFontOfSize(_:))
}

extension UIFont {
    
//    override public class func initialize() {
//        struct Static {
//            static var token: dispatch_once_t = 0
//        }
//        //使用单次标识代码块，确保其中的代码仅执行一次（固定写法，照抄即可）
//        //*重要！*此代码块不可省略！否则会产生不可预知的崩溃！
//        dispatch_once(&Static.token) {
//            //若对象类型正确，则执行Swizzle方法
//            if self == UIFont.self {
//                let customMethod = class_getClassMethod(self, .customFontOfSize)
//                let systemMethod = class_getClassMethod(self, .systemFontOfSize)
//                method_exchangeImplementations(customMethod, systemMethod)
//            }
//        }
//    }
    
    class func customFontOfSize(a: CGFloat) -> UIFont {
        var size: CGFloat!
        if Device.size() == .Screen5_5Inch {
            size = a * scale
        } else {
            size = a
        }
        return UIFont(name: "STHeitiSC-Light", size: size)!
    }
    
}


