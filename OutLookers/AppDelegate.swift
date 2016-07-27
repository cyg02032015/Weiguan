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

var globleSingle = GlobleDefineSingle.sharedInstance
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func testUpload() {
        Server.getUpdateFileToken { (success, msg, value) in
            if success {
                guard let object = value else {return}
                OSSImageUploader.asyncUploadImage(object, image: UIImage(named: "open")!, complete: { (names, state) in
                    if state == .Success {
                        LogDebug("\(names)")
                    } else {
                        LogError("upload Failure")
                    }
                })
            } else {
                LogError(msg)
            }
        }
    }
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        #if DEBUG
            configCocoaLumberjack()
        #endif
        testUpload()
        
        // 获取全局变量是同步获取  会阻塞线程
        Server.globleDefine { (success, msg, value) in
            if success {
                guard let item = value else {return}
                LogDebug(item.imageUrlPrefix)
                globleSingle.citiesUrl = item.citiesUrl
                globleSingle.version = item.citiesUrlVersion
                globleSingle.vedioPath = item.videoUrlPrefix
                globleSingle.imagePath = item.imageUrlPrefix
            } else {
                LogError(msg)
            }
        }
        
        
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
        
        configNavigation()
        configUMeng()
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

