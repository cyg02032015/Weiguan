//
//  PersonalData.swift
//  OutLookers
//
//  Created by 宋碧海 on 16/9/7.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class PersonalData {

    /// 生日
    var birthday : String!
    /// 城市
    var city : String!
    /// 头像地址
    var headImgUrl : String!
    /// 用户id
    var id : Int!
    /// 个人简介
    var introduction : String!
    /// 昵称
    var nickname : String!
    /// 省（如果没有传空）
    var province : String!
    /// 性别（值为1时是男性，值为2时是女性，值为0时是未知）
    var sex : Int!
    
    init(json: JSON) {
        birthday     = json["birthday"].stringValue     ?? ""
        city         = json["city"].stringValue         ?? ""
        headImgUrl   = json["headImgUrl"].stringValue   ?? ""
        id           = json["id"].intValue
        introduction = json["introduction"].stringValue ?? ""
        nickname     = json["nickname"].stringValue     ?? ""
        province     = json["province"].stringValue     ?? ""
        sex          = json["sex"].intValue
    }
}
