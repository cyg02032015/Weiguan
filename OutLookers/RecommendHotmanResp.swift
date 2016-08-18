//
//  RecommendHotmanResp.swift
//  OutLookers
//
//  Created by C on 16/7/25.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class RecommendHotmanResp: BaseResponse {
    var result: [HotmanList]!
    
    override init(fromJson json: JSON!){
        super.init(fromJson: json)
        if json == nil{
            return
        }
        
        result = [HotmanList]()
        let resultArray = json["result"].arrayValue
        for resultJson in resultArray{
            let value = HotmanList(fromJson: resultJson)
            result.append(value)
        }
    }
    
}

class HotmanList {
    /// 头像地址
    var headImgUrl : String!
    /// 认证名称
    var name : String!
    /// 昵称
    var nickname : String!
    var userId: String!
    
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        userId = json["userId"].stringValue
        headImgUrl = "\(json["headImgUrl"].stringValue)"
        name = json["name"].stringValue
        nickname = json["nickname"].stringValue
    }
}