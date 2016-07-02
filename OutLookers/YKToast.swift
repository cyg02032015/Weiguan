//
//  YKToast.swift
//  OutLookers
//
//  Created by C on 16/6/18.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
//import MBProgressHUD

class YKToast {
    
    class func makeText(message: String) {
        let view = UIApplication.sharedApplication().windows.first
        guard let v = view where view!.isKindOfClass(UIView.self) else {
            fatalError("view is nil")
        }
        v.backgroundColor = UIColor.blackColor()
        let hud = MBProgressHUD.showHUDAddedTo(v, animated: true)
        hud.mode = .Text
        hud.label.text = message
        hud.label.font = UIFont.customFontOfSize(12)
        hud.offset = CGPoint(x: 0, y: ScreenHeight/2 + 100)
        hud.hideAnimated(true, afterDelay: 1)
    }
}
