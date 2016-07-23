//
//  DynamicListResp.swift
//  OutLookers
//
//  Created by C on 16/7/24.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class DynamicListResp: BaseResponse {

    var order : String!
    var orderBy : String!
    var pageNo : Int!
    var pageSize : Int!
    var dynamicResult : [DynamicResult]!
    var totalCount : Int!
    var result: DynamicListResp!
    
    override init(fromJson json: JSON!) {
        super.init(fromJson: json)
        if json == nil{
            return
        }
        order = json["order"].stringValue
        orderBy = json["orderBy"].stringValue
        pageNo = json["pageNo"].intValue
        pageSize = json["pageSize"].intValue
        
        let pageJson = json["page"]
        if pageJson != JSON.null {
            result = DynamicListResp(fromJson: pageJson)
        }
        
        dynamicResult = [DynamicResult]()
        let resultArray = json["result"].arrayValue
        for resultJson in resultArray{
            let value = DynamicResult(fromJson: resultJson)
            dynamicResult.append(value)
        }
        totalCount = json["totalCount"].intValue
    }
}

class DynamicResult {
    var cover : String!
    var createTime : String!
    var id : Int!
    var isVideo : Int!
    var name : String!
    var photo : String!
    var picture : String!
    var text : String!
    var userId : Int!
    init(fromJson json: JSON!) {
        if json == nil{
            return
        }
        cover = json["cover"].stringValue
        createTime = json["createTime"].stringValue
        id = json["id"].intValue
        isVideo = json["isVideo"].intValue
        name = json["name"].stringValue
        photo = json["photo"].stringValue
        picture = json["picture"].stringValue
        text = json["text"].stringValue
        userId = json["userId"].intValue
    }
}
