//
//  EditDataReq.swift
//  OutLookers
//
//  Created by C on 16/7/25.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

struct EditDataReq {
    
    /// 生日
    var birthday : String!
    /// 城市
    var city : String!
    /// 头像地址
    var headImgUrl : String!
    /// 用户id
    var id : String!
    /// 个人简介
    var introduction : String!
    /// 昵称
    var nickname : String!
    /// 省（如果没有传空）
    var province : String!
    /// 性别（值为1时是男性，值为2时是女性，值为0时是未知）
    var sex : String!

    
    
}
