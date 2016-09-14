//
//  YKToast.swift
//  OutLookers
//
//  Created by C on 16/6/18.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class YKToast {
    
//    static var hud: MBProgressHUD!
    
    class func makeText(message: String) {
        let view = UIApplication.sharedApplication().windows.first
        guard let v = view where view!.isKindOfClass(UIView.self) else {
            fatalError("view is nil")
        }
        let hud = MBProgressHUD.showHUDAddedTo(v, animated: true)
        hud.mode = .Text
        hud.label.text = message
        hud.label.font = UIFont.customFontOfSize(12)
        hud.offset = CGPoint(x: 0, y: ScreenHeight/2 + 100)
        hud.hideAnimated(true, afterDelay: 1)
    }
    
    class func show(message: String) {
        let view = UIApplication.sharedApplication().windows.first
        guard let v = view where view!.isKindOfClass(UIView.self) else {
            fatalError("view is nil")
        }
        let hud = MBProgressHUD.showHUDAddedTo(v, animated: true)
        hud.label.text = message
    }
    
    class func dismiss() {
        let view = UIApplication.sharedApplication().windows.first
        guard let v = view where view!.isKindOfClass(UIView.self) else {
            fatalError("view is nil")
        }
        MBProgressHUD.hideAllHUDsForView(v, animated: true)
    }
}

class SVToast {
    
    class func initialize() {
        SVProgressHUD.setDefaultStyle(.Dark) //#64B8FF, 100%
        SVProgressHUD.setBackgroundColor(UIColor(r: 1, g: 1, b: 1, a: 0.6))
    }
    
    class func show() {
        SVProgressHUD.show()
    }
    
    class func show(message: String) {
        SVProgressHUD.showWithStatus(message)
    }
    
    class func showWithError(message: String) {
        delay(0.5) {
            SVProgressHUD.setMinimumDismissTimeInterval(0.5)
            SVProgressHUD.showErrorWithStatus(message)
        }
    }
    
    class func showWithSuccess(message: String) {
        delay(0.5) {
            SVProgressHUD.setMinimumDismissTimeInterval(0.5)
            SVProgressHUD.showSuccessWithStatus(message)
        }
    }
    
    class func dismiss() {
        SVProgressHUD.dismiss()
    }
}
