//
//  BannerResp.swift
//  OutLookers
//
//  Created by C on 16/8/10.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class BannerResp: BaseResponse {
    var result : [BannerList]!
    
    override init(fromJson json: JSON!){
        super.init(fromJson: json)
        if json == nil{
            return
        }
        result = [BannerList]()
        let resultArray = json["result"].arrayValue
        for resultJson in resultArray{
            let value = BannerList(fromJson: resultJson)
            result.append(value)
        }
    }
    
}


class BannerList {
    
    var id : Int!
    var isUser : Int!
    var name : String!
    var picture : String!
    var sort : Int!
    var url : String!
    var userId : Int!
    
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        id = json["id"].intValue
        isUser = json["isUser"].intValue
        name = json["name"].stringValue
        picture = json["picture"].stringValue
        sort = json["sort"].intValue
        url = json["url"].stringValue
        userId = json["userId"].intValue
    }
    
}