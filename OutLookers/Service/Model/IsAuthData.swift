//
//  IsAuthData.swift
//  OutLookers
//
//  Created by 宋碧海 on 16/9/8.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class IsAuthData {
    /// 用户id
    var userId: Int!
    /// 是否认证
    var authentication: Bool!
    /// 认证类型（1红人，2机构，3粉丝）
    var type: Int!
    /// 审核状态（1：待审核，2审核通过）
    var state: Int!
    /// 返回认证角色
    var name: String!
    /// 头像url
    var headImgUrl: String!
    /// 个人简介
    var introduction: String!
    /// 用户昵称
    var nickname: String!
    /// 是否关注（0，未关注，1关注）
    var follow: Int!
    
    init(json: JSON) {
        userId         = json["userId"].intValue
        authentication = json["authentication"].boolValue
        type           = json["type"].intValue
        state          = json["state"].intValue
        name           = json["name"].stringValue ?? ""
        headImgUrl     = json["headImgUrl"].stringValue ?? ""
        introduction   = json["introduction"].stringValue ?? ""
        nickname       = json["nickname"].stringValue ?? ""
        follow         = json["follow"].intValue
    }
}
