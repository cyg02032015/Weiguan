//
//  GlobleFunc.swift
//  OutLookers
//
//  Created by C on 16/6/18.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import Accelerate
import Alamofire
import SwiftyJSON
import KeychainAccess

func LocalizedString(text: String) -> String {
    return NSLocalizedString(text, comment: "")
}


func configNavigation() {
    UINavigationBar.appearance().barTintColor = UIColor.whiteColor()
    UINavigationBar.appearance().translucent = true
    UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.blackColor(), NSFontAttributeName:UIFont.customNumFontOfSize(20)]
}

func configUMeng() {
    UMSocialData.setAppKey(kUmengAppkey)
    #if DEBUG
//    UMSocialData.openLog(true)
    #endif
    //设置微信AppId、appSecret，分享url
    UMSocialWechatHandler.setWXAppId(kWechatAppId, appSecret: kWechatSecret, url: kWechatUrl)
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    UMSocialQQHandler.setQQWithAppId(kQQAppId, appKey: kQQAppSecret, url: kQQUrl)
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
    UMSocialSinaSSOHandler.openNewSinaSSOWithAppKey(kSinaAppkey, secret: kSinaAppSecret, redirectURL: kSinaRedirectUrl)
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
    let inProvider = CGImageGetDataProvider(img!)
    let inBitmapData = CGDataProviderCopyData(inProvider!)
    
    // 设置从CGImage获取对象的属性
    inBuffer.width = UInt(CGImageGetWidth(img!))
    inBuffer.height = UInt(CGImageGetHeight(img!))
    inBuffer.rowBytes = CGImageGetBytesPerRow(img!)
    inBuffer.data = UnsafeMutablePointer<Void>(CFDataGetBytePtr(inBitmapData))
    pixelBuffer = malloc(CGImageGetBytesPerRow(img!) * CGImageGetHeight(img!))
    if pixelBuffer == nil {
        NSLog("No pixel buffer!")
    }
    
    outBuffer.data = pixelBuffer
    outBuffer.width = UInt(CGImageGetWidth(img!))
    outBuffer.height = UInt(CGImageGetHeight(img!))
    outBuffer.rowBytes = CGImageGetBytesPerRow(img!)
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, nil, 0, 0, UInt32(boxSize), UInt32(boxSize), nil, UInt32(kvImageEdgeExtend))
    if error != nil && error != 0 {
        NSLog("error from convolution %ld", error)
    }
    
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let ctx = CGBitmapContextCreate(outBuffer.data, Int(outBuffer.width), Int(outBuffer.height), 8, outBuffer.rowBytes, colorSpace, CGImageAlphaInfo.NoneSkipLast.rawValue)
    
    let imageRef = CGBitmapContextCreateImage(ctx!)!
    let returnImage = UIImage(CGImage: imageRef)
    
    free(pixelBuffer)
    
    return returnImage
}

/// 获取全局变量  当获取成功后会通知首页加载数据
func configGlobleDefine() {
    SVToast.show()
    Server.globleDefine { (success, msg, value) in
        if success {
            guard let item = value else {return}
            globleSingle.version = item.citiesUrlVersion
            globleSingle.vedioPath = item.videoUrlPrefix
            globleSingle.imagePath = item.imageUrlPrefix
            globleSingle.citiesUrl = item.citiesUrl
            globleSingle.videoSnapshotPrefix = item.videoSnapshotPrefix
            NSNotificationCenter.defaultCenter().postNotificationName(kRecieveGlobleDefineNotification, object: nil, userInfo: nil)
            if YGCityVersion.loadCityVersion() == "" || YGCityVersion.loadCityVersion() != item.citiesUrlVersion { // 如果版本不存在或者版本不一致
                let version = YGCityVersion(version: item.citiesUrlVersion) // 保存版本号
                version.saveCityVersion()
                Alamofire.request(.GET, item.citiesUrl, parameters: nil, encoding: .JSON).responseData(completionHandler: { (response) in
                    switch response.result {
                    case .Success(let value):
                        let cityData = YGCityData(data: value)
                        cityData.saveCityData()
                    case .Failure(let error):
                        LogError("获取城市列表失败 \(error)")
                    }
                })
            }
        } else {
            SVToast.dismiss()
            SVToast.showWithError(msg!)
        }
    }
}

/// 令牌登录
// 每一次的网络请求都要判断cookie是否过期   如果cookie过期有token 则token登录
// 在token 登录失败的情况下删除用户的数据   让用户重新手动登录
func tokenLogin(success succ: (()->Void)? = nil, failure fail: (()->Void)? = nil) {
    if TokenTool.isCookieExpired() {
        if !isEmptyString(KeyChainSingle.sharedInstance.keychain[kToken]) {
            Server.tokenLogin { (success, msg, value) in
                if success {
                    LogVerbose("============================")
                    LogDebug("秘钥登录 = \(value)\n\(msg)")
                    LogVerbose("============================")
                    if let s = succ {
                        s()
                    }
                } else {
                    if let f = fail {
                        f()
                    }
                }
            }
        } else {
            LogVerbose("============================")
            LogError("token is nil")
            LogVerbose("============================")
            if let f = fail {
                f()
            }
        }
    } else {
        LogVerbose("*****************************************")
        LogDebug("cookie 没有过期")
        LogVerbose("*****************************************")
        if let s = succ {
            s()
        }
    }
}

/// 获取设备唯一ID -- 存储在keychain里  当用户还原出厂配置时会干掉
func keyChainGetDeviceId() {
    let keychain = KeyChainSingle.sharedInstance.keychain
    if keychain[kUUID] == nil {
        let uuid = NSUUID().UUIDString
        keychain[kUUID] = uuid
        globleSingle.deviceId = uuid
    } else {
        globleSingle.deviceId = keychain[kUUID]
    }
}
