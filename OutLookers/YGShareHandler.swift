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
let kDeleteImg = "delete  copy 4"
let kEditImg = "edit"
let kHomeImg = "Return"
let kReportImg = "qq_c"

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
let kDelete = "删除"
let kHome = "返回首页"
let kReport = "举报"
let kEdit = "编辑"

class YGShareHandler {
    /**
     判断有没有安装app
     
     - returns: 返回一个元组 (选中的图片， 没选中的图片， 标题)
     */
    static func handleShareInstalled() -> (images: [UIImage], unSelectedImages: [UIImage], titles: [String]) {
        if YGWXApi.isWXAppInstalled() && YGQQApi.isQQAppInstalled() {
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
        } else if YGWXApi.isWXAppInstalled() && !YGQQApi.isQQAppInstalled() {
            let images = [UIImage(named: kSelectedTimeline)!,
                          UIImage(named: kSelectedWechat)!,
                          UIImage(named: kSelectedSina)!]
            let unSelectedImages = [UIImage(named: kUnSelectedTimeline)!,
                                    UIImage(named: kUnSelectedWechat)!,
                                    UIImage(named: kUnSelectedSina)!]
            let titles = [kTitleTimeline, kTitleWechat, kTitleSina]
            return (images, unSelectedImages, titles)
        } else if !YGWXApi.isWXAppInstalled() && YGQQApi.isQQAppInstalled() {
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
class YGQQApi {
    class func isQQAppInstalled() -> Bool {
        if UIApplication.sharedApplication().canOpenURL(NSURL(string: "mqq://")!) {
            return true
        } else {
            LogWarn("QQapp 安装返回失败")
            return false
        }
    }
}

class YGWXApi {
    class func isWXAppInstalled() -> Bool {
        if UIApplication.sharedApplication().canOpenURL(NSURL(string: "weixin://")!) {
            return true
        } else {
            LogWarn("微信app 安装返回失败")
            return false
        }
    }
}