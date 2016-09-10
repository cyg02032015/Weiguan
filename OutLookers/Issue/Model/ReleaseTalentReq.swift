//
//  ReleaseTalentReq.swift
//  OutLookers
//
//  Created by C on 16/7/23.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

struct ReleaseTalentReq {
    /// 才艺类别id
    var categoryId : String!
    /// 才艺类别名称
    var categoryName : String!
    /// 城市id
    var city : String?
    /// 才艺详情
    var details : String!
    /// 才艺名称
    var name : String!
    /// 图片文字
    var pictureText : String?
    /// 才艺标价
    var price : String!
    /// 价钱单位  1：元/小时，2：元/场:3：元/次:4：元/半天:5：元/天:6：元/月:7：元/年'
    var unit : String!
    
    var userId : String!
    /// 视频文字
    var videoText : String?
    /// 作品集封面
    var worksCover : String?
    /// 作品集图片
    var worksPicture : String?
    /// 作品集视频
    var worksVideo : String?
}