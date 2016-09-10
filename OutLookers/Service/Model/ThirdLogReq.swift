//
//  ThirdLogReq.swift
//  OutLookers
//
//  Created by C on 16/9/5.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

struct ThirdLogReq {
    /// 设备描述（手机品牌,型号,系统版本）
    var deviceDesc : String!
    /// 设备号
    var deviceId : String!
    /// 头像（微信和QQ  profile_image_url，微博USER_ICON）
    var headImgUrl : String!
    /// 昵称（微信和QQ screen_name ，微博NICK_NAME）
    var nickname : String!
    /// 开放id（微信和QQ  openid，微博 ""）
    var openId : String!
    /// 登录类型（微信2，QQ3，新浪微博4）
    var type : Int!
    /// 唯一标识（微信unionid，QQ uid，微博 uid） 需要校验header
    var uid : String!
    /// 用户名（微信和QQ ""，微博 userName）
    var userName: String!
}
