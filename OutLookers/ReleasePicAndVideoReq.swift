
//
//  ReleasePicAndVideo.swift
//  OutLookers
//
//  Created by C on 16/7/23.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

struct ReleasePicAndVideoReq {
    /// 封面id
    var cover : String!
    /// 是否是视频（1：不是，2：是）
    var isVideo : String!
    /// 图片（视频）id
    var picture : String!
    /// 才艺id
    var talent : String?
    /// 文本内容
    var text : String?
    
    var userId : String!
}
