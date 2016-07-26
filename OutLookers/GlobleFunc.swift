//
//  GlobleFunc.swift
//  OutLookers
//
//  Created by C on 16/6/18.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import Accelerate
import CocoaLumberjack

func LogInfo<T>(message: T) {
    #if DEBUG
    DDLogInfo("\(message)")
    #endif
}

func LogVerbose<T>(message: T) {
    #if DEBUG
        DDLogVerbose("\(message)")
    #endif
}

func LogError<T>(message: T) {
    #if DEBUG
        DDLogError("\(message)")
    #endif
}

func LogWarn<T>(message: T) {
    #if DEBUG
        DDLogWarn("\(message)")
    #endif
}

func LogDebug<T>(message: T) {
    #if DEBUG
        DDLogDebug("\(message)")
    #endif
}

func configCocoaLumberjack() {
    DDLog.addLogger(DDTTYLogger.sharedInstance())
    setenv("XcodeColors", "YES", 0)
    DDTTYLogger.sharedInstance().colorsEnabled = true
    DDTTYLogger.sharedInstance().setForegroundColor(UIColor.yellowColor(), backgroundColor: nil, forFlag: .Info)
    DDTTYLogger.sharedInstance().setForegroundColor(UIColor.cyanColor(), backgroundColor: nil, forFlag: .Debug)
    DDTTYLogger.sharedInstance().setForegroundColor(UIColor.blueColor(), backgroundColor: nil, forFlag: .Verbose)
    DDTTYLogger.sharedInstance().logFormatter = LogFormatter()
}

func LocalizedString(text: String) -> String {
    return NSLocalizedString(text, comment: "")
}


func configNavigation() {
    UINavigationBar.appearance().barTintColor = UIColor.whiteColor()
    UINavigationBar.appearance().translucent = true
    UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.blackColor(), NSFontAttributeName:UIFont.customNumFontOfSize(20)]
}

func configUMeng() {
//    UMSocialData.setAppKey(kUmengAppkey)
    #if DEBUG
//    UMSocialData.openLog(true)
    #endif
//    //设置微信AppId、appSecret，分享url
//    UMSocialWechatHandler.setWXAppId(kWechatAppId, appSecret: kWechatSecret, url: kWechatUrl)
//    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
//    UMSocialQQHandler.setQQWithAppId(kQQAppId, appKey: kQQAppSecret, url: kQQUrl)
//    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
//    UMSocialSinaSSOHandler.openNewSinaSSOWithAppKey(kSinaAppkey, secret: kSinaAppSecret, redirectURL: kSinaRedirectUrl)
}

func isEmptyString(text: String?) -> Bool {
    guard let t = text else { return true }
    if t.characters.count <= 0 || t == "" {
        return true
    } else {
        return false
    }
}

// MARK: 模糊效果
/// vImage背景模糊
func boxBlurImage(image: UIImage, withBlurNumber blur: CGFloat) -> UIImage {
    var blur = blur
    if blur < 0.0 || blur > 1.0 {
        blur = 0.5
    }
    var boxSize = Int(blur * 40)
    boxSize = boxSize - (boxSize % 2) + 1
    
    let img = image.CGImage
    
    var inBuffer = vImage_Buffer()
    var outBuffer = vImage_Buffer()
    var error: vImage_Error!
    var pixelBuffer: UnsafeMutablePointer<Void>!
    
    // 从CGImage中获取数据
    let inProvider = CGImageGetDataProvider(img)
    let inBitmapData = CGDataProviderCopyData(inProvider)
    
    // 设置从CGImage获取对象的属性
    inBuffer.width = UInt(CGImageGetWidth(img))
    inBuffer.height = UInt(CGImageGetHeight(img))
    inBuffer.rowBytes = CGImageGetBytesPerRow(img)
    inBuffer.data = UnsafeMutablePointer<Void>(CFDataGetBytePtr(inBitmapData))
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img))
    if pixelBuffer == nil {
        NSLog("No pixel buffer!")
    }
    
    outBuffer.data = pixelBuffer
    outBuffer.width = UInt(CGImageGetWidth(img))
    outBuffer.height = UInt(CGImageGetHeight(img))
    outBuffer.rowBytes = CGImageGetBytesPerRow(img)
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, nil, 0, 0, UInt32(boxSize), UInt32(boxSize), nil, UInt32(kvImageEdgeExtend))
    if error != nil && error != 0 {
        NSLog("error from convolution %ld", error)
    }
    
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let ctx = CGBitmapContextCreate(outBuffer.data, Int(outBuffer.width), Int(outBuffer.height), 8, outBuffer.rowBytes, colorSpace, CGImageAlphaInfo.NoneSkipLast.rawValue)
    
    let imageRef = CGBitmapContextCreateImage(ctx)!
    let returnImage = UIImage(CGImage: imageRef)
    
    free(pixelBuffer)
    
    return returnImage
}