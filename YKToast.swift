//
//  YKToast.swift
//  OutLookers
//
//  Created by C on 16/6/18.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class YKToast {
    
    class func makeText(message: String) {
        let view = UIApplication.sharedApplication().windows.first
        guard let v = view where view!.isKindOfClass(UIView.classForCoder()) else {
            fatalError("view is nil")
        }
        v.makeToast(message, duration: 1.0, position: CGPoint(x: ScreenWidth/2, y: ScreenHeight/2 + 150))
    }
}
