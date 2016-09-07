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
let kWechatAppId = "wx72e48cccc64e7dc4"
let kWechatSecret = "0eb8c7bf207fc3f7ae1d252b9f72ee8c"
let kWechatUrl = "http://www.umeng.com/social" // 分享地址

let kQQAppId = "1105476799"
let kQQAppSecret = "Q7VOdh5Em7ugARP7"
let kQQUrl = "http://www.umeng.com/social" // 分享地址

#if DEBUG
    let kUmengAppkey = "576c94eee0f55a2551000538"
    let kSinaAppkey = "821223363"
    let kSinaAppSecret = "02008c2efb2c66bb458ee04a46917b66"
    let sharePrefix = "http://h5.dev.chunyangapp.com"
    let kSinaRedirectUrl = "http://api.dev.chunyangapp.com/api/sina/v1/callback"
#else
    let kUmengAppkey = "57c2b739e0f55a4825001914"
    let kSinaAppkey = "3982685003"
    let kSinaAppSecret = "271a0f8dd5f04648d80f6dbca3e7bf4d"
    let sharePrefix = "http://h5.chunyangapp.com"
    let kSinaRedirectUrl = "http://api1.chunyangapp.com/api/sina/v1/callback"
#endif

let kOSSEndPoint = "http://oss-cn-hangzhou.aliyuncs.com/"

// placeholder
let kPlaceholder = UIImage(named: "Group 4123")
let kHeadPlaceholder = UIImage(named: "关注列表默认头像default")

// 正则表达
let kMobileNumberReg: String      = "^1[3578][0-9]{9}$"

// 通知
let kRecieveGlobleDefineNotification = "recieveGlobleDefine"
let kPlusButtonClickNotification = "PlusButtonClick"

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

/// 性别
enum SexType: String {
    case None = "0"
    case Male = "1"
    case Female = "2"
}


