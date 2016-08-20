//
//  AppDelegate.swift
//  OutLookers
//
//  Created by Youngkook on 16/6/15.
//  Copyright © 2016年 youngkook. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import AliyunOSSiOS
import Alamofire
import SwiftyJSON
import YYWebImage
import KeychainAccess

var globleSingle = GlobleDefineSingle.sharedInstance
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func testUpload() {
    }
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        #if DEBUG
            configCocoaLumberjack()
        #endif
        testUpload()
        
//        try! KeyChainSingle.sharedInstance.keychain.removeAll()
        
        // 键盘
        keyboardSetting()
        // 初始化配置SVProgressHUD
        keyChainGetDeviceId()  // 获取设备号
        SVToast.initialize()
        configNavigation()
        configUMeng()
        configGlobleDefine()
        tokenLogin()
        isLogin()
        return true
    }
    
    func isLogin() {
        if !UserSingleton.sharedInstance.isLogin() {
            LogInfo("用户未登录")
        }
    }
    
    func tokenLogin() {
        if TokenTool.isCookieExpired() {
            if !isEmptyString(KeyChainSingle.sharedInstance.keychain[kToken]) {
                Server.tokenLogin { (success, msg, value) in
                    LogDebug("token login = \(value)\n\(msg)")
                }
            } else {
                LogError("token is nil")
            }
        } else {
            LogDebug("cookie 没有过期")
        }
    }
    
    func keyboardSetting() {
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
    }

    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        let result = UMSocialSnsService.handleOpenURL(url)
        if result == false {
            // 设置微信支付宝等
        }
        return result
    }
    
    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }


}

