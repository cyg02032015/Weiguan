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

var globleSingle = GlobleDefineSingle.sharedInstance
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func testUpload() {
//        Server.getUpdateFileToken { (success, msg, value) in
//            if success {
//                guard let object = value else {return}
//                OSSImageUploader.asyncUploadImages(object, images: [UIImage(named: "open")!,UIImage(named: "open")!,UIImage(named: "open")!], complete: { (names, state) in
//                    if state == .Success {
//                        LogDebug("\(names)")
//                    } else {
//                        LogError("upload Failure")
//                    }
//                })
//            } else {
//                LogError(msg)
//            }
//        }
    }
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        #if DEBUG
            configCocoaLumberjack()
        #endif
        testUpload()
        LogInfo(YYImageWebPAvailable())
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
        
        configNavigation()
        configUMeng()
        configGlobleDefine()
        return true
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

