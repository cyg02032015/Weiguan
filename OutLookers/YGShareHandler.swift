//
//  YGShareSDK.swift
//  OutLookers
//
//  Created by Youngkook on 16/6/24.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

let kSelectedTimeline = "wechat_moment_c"
let kSelectedWechat = "wechat_c"
let kSelectedSina = "sina_weibo_c"
let kSelectedQzone = "qzone_c"
let kSelectedQQ = "qq_c"

let kUnSelectedTimeline = "wechat_moment－Unchecked"
let kUnSelectedWechat = "wechat_Unchecked"
let kUnSelectedSina = "sina_weibo_Unchecked"
let kUnSelectedQzone = "qzone_Unchecked"
let kUnSelectedQQ = "qq_Unchecked"

let kTitleTimeline = "朋友圈"
let kTitleWechat = "微信"
let kTitleSina = "微博"
let kTitleQzone = "空间"
let kTitleQQ = "QQ"

class YGShareHandler {
    /**
     判断有没有安装app
     
     - returns: 返回一个元组 (选中的图片， 没选中的图片， 标题)
     */
    class func handleShareInstalled() -> (images: [UIImage], unSelectedImages: [UIImage], titles: [String]) {
        if WXApi.isWXAppInstalled() && QQApi.isQQAppInstalled() {
            let images = [UIImage(named: kSelectedTimeline)!,
                          UIImage(named: kSelectedWechat)!,
                          UIImage(named: kSelectedSina)!,
                          UIImage(named: kSelectedQzone)!,
                          UIImage(named: kSelectedQQ)!]
            let unSelectedImages = [UIImage(named: kUnSelectedTimeline)!,
                                    UIImage(named: kUnSelectedWechat)!,
                                    UIImage(named: kUnSelectedSina)!,
                                    UIImage(named: kUnSelectedQzone)!,
                                    UIImage(named: kUnSelectedQQ)!]
            let titles = [kTitleTimeline, kTitleWechat, kTitleSina, kTitleQzone, kTitleQQ]
            return (images, unSelectedImages, titles)
        } else if WXApi.isWXAppInstalled() && !QQApi.isQQAppInstalled() {
            let images = [UIImage(named: kSelectedTimeline)!,
                          UIImage(named: kSelectedWechat)!,
                          UIImage(named: kSelectedSina)!]
            let unSelectedImages = [UIImage(named: kUnSelectedTimeline)!,
                                    UIImage(named: kUnSelectedWechat)!,
                                    UIImage(named: kUnSelectedSina)!]
            let titles = [kTitleTimeline, kTitleWechat, kTitleSina]
            return (images, unSelectedImages, titles)
        } else if !WXApi.isWXAppInstalled() && QQApi.isQQAppInstalled() {
            let images = [UIImage(named: kSelectedSina)!,
                          UIImage(named: kSelectedQzone)!,
                          UIImage(named: kSelectedQQ)!]
            let unSelectedImages = [UIImage(named: kUnSelectedSina)!,
                                    UIImage(named: kUnSelectedQzone)!,
                                    UIImage(named: kUnSelectedQQ)!]
            let titles = [kTitleSina, kTitleQzone, kTitleQQ]
            return (images, unSelectedImages, titles)
        } else {
            let images = [UIImage(named: kSelectedSina)!]
            let unSelectedImages = [UIImage(named: kUnSelectedSina)!]
            let titles = [kTitleSina]
            return (images, unSelectedImages, titles)
        }
    }
}

// 判断用户安装木有qq
class QQApi {
    class func isQQAppInstalled() -> Bool {
        if UIApplication.sharedApplication().canOpenURL(NSURL(string: "mqq://")!) {
            return true
        } else {
            return false
        }
    }
}