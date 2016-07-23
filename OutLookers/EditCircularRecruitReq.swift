//
//  EditCircularRecruit.swift
//  OutLookers
//
//  Created by C on 16/7/24.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

struct EditCircularRecruitReq {
    /// 才艺类别id
    var categoryId : String!
    /// 才艺类别名称
    var categoryName : String!
    /// 招募人数
    var number : String!
    /// 价钱
    var price : String!
    /// 价钱单位 1：元/小时，2：元/场:3：元/次:4：元/半天:5：元/天:6：元/月:7：元/年
    var unit : String!
}
