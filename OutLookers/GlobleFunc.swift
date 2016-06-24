//
//  GlobleFunc.swift
//  OutLookers
//
//  Created by C on 16/6/18.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import CocoaLumberjack

func LogInfo(message: String) {
    #if DEBUG
    DDLogInfo(message)
    #endif
}

func LogVerbose(message: String) {
    #if DEBUG
        DDLogVerbose(message)
    #endif
}

func LogError(message: String) {
    #if DEBUG
        DDLogError(message)
    #endif
}

func LogWarn(message: String) {
    #if DEBUG
        DDLogWarn(message)
    #endif
}

func configCocoaLumberjack() {
    DDLog.addLogger(DDTTYLogger.sharedInstance())
    setenv("XcodeColors", "YES", 0)
    DDTTYLogger.sharedInstance().colorsEnabled = true
}

func LocalizedString(text: String) -> String {
    return NSLocalizedString(text, comment: "")
}

// 适配高度
func kSizeScale(a: CGFloat) -> CGFloat {
    return a * UIScreen.mainScreen().bounds.width / 375.0
}

func configNavigation() {
    UINavigationBar.appearance().barTintColor = UIColor(hex: 0x333333)
    UINavigationBar.appearance().translucent = false
    UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
}

func configUMeng() {
    UMSocialData.setAppKey(kUmengAppkey)
    #if DEBUG
    UMSocialData.openLog(true)
    #endif
//    //设置微信AppId、appSecret，分享url
//    UMSocialWechatHandler.setWXAppId(kWechatAppId, appSecret: kWechatSecret, url: kWechatUrl)
//    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
//    UMSocialQQHandler.setQQWithAppId(kQQAppId, appKey: kQQAppSecret, url: kQQUrl)
//    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
//    UMSocialSinaSSOHandler.openNewSinaSSOWithAppKey(kSinaAppkey, secret: kSinaAppSecret, redirectURL: kSinaRedirectUrl)
}