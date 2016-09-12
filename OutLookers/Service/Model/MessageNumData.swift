//
//  MessageNumData.swift
//  OutLookers
//
//  Created by 宋碧海 on 16/9/8.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class MessageNumData {
    /// 点赞数量
    var like: Int!
    /// 评论数量
    var reply: Int!
    /// 关注数量
    var follow: Int!
    
    init(json: JSON) {
        like = json["like"].intValue
        reply = json["reply"].intValue
        follow = json["follow"].intValue
    }
}

class MessageNumDataReq: BaseResponse {
    var result: MessageNumData!
    
    override init(fromJson json: JSON!) {
        super.init(fromJson: json)
        if json == nil{
            return
        }
        
        let resultJson = json["result"]
        if resultJson != JSON.null {
            result = MessageNumData(json: resultJson)
            return
        }
    }
}
