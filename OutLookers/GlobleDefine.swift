//
//  GlobleDefine.swift
//  SuperWay
//
//  Created by C on 15/9/17.
//  Copyright © 2015年 YoungKook. All rights reserved.
//

import UIKit
import Device

let scale: CGFloat = 1.15

// 屏幕适配宏常量
let ScreenWidth: CGFloat   = UIScreen.mainScreen().bounds.width
let ScreenHeight: CGFloat  = UIScreen.mainScreen().bounds.height
let NaviHeight: CGFloat    = 64
let TabbarHeight: CGFloat  = 49
let NavibarHeight: CGFloat = 44

/// 各种key
let kUmengAppkey = "576c94eee0f55a2551000538"

let kWechatAppId = "wxd930ea5d5a258f4f"
let kWechatSecret = "db426a9829e4b49a0dcac7b4162da6b6"
let kWechatUrl = "http://www.umeng.com/social" // 分享地址

let kQQAppId = "100424468"
let kQQAppSecret = "c7394704798a158208a74ab60104f0ba"
let kQQUrl = "http://www.umeng.com/social" // 分享地址

let kSinaAppkey = "126663232"
let kSinaAppSecret = "d39969613faa5fcc75859cf8406649eb"
let kSinaRedirectUrl = "http://sns.whalecloud.com/sina2/callback" // 分享回调地址

// 正则表达
let kMobileNumberReg: String      = "^1[3578][0-9]{9}$"

func kScale(a: CGFloat) -> CGFloat {
    if Device.size() == .Screen5_5Inch {
        return a * scale
    } else {
        return a
    }
}

func kSize(width: CGFloat, height: CGFloat) -> CGSize {
    if Device.size() == .Screen5_5Inch {
        return CGSize(width: width * scale, height: height * scale)
    } else {
        return CGSize(width: width, height: height)
    }
}

func kHeight(a: CGFloat) -> CGFloat {
    if Device.size() == .Screen5_5Inch {
        return a * scale
    } else {
        return a
    }
}


