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

    var customTabbar: YGTabbar!
    var window: UIWindow?
    func testUpload() {
    }
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // 调试时想要删除keychain里的数据调用此方法
//        _ = try? KeyChainSingle.sharedInstance.keychain.removeAll()
        #if DEBUG
            configCocoaLumberjack()
        #endif
        testUpload()
                
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
        } else {
            UserSingleton.sharedInstance.type = UserType(rawValue: Int(KeyChainSingle.sharedInstance.keychain[kAuthType] ?? "0")!)!
            UserSingleton.sharedInstance.userId = KeyChainSingle.sharedInstance.keychain[kUserId] ?? ""
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

