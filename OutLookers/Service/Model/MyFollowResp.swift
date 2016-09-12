//
//  MyFollowResp.swift
//  OutLookers
//
//  Created by C on 16/7/24.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class MyFollowResp: BaseResponse {
    
    var order : String!
    var orderBy : String!
    var pageNo : Int!
    var pageSize : Int!
    var list : [FollowList]!
    var totalCount : Int!
    var result: MyFollowResp!
    
    override init(fromJson json: JSON!) {
        super.init(fromJson: json)
        if json == nil{
            return
        }
        let pageJson = json["page"]
        if pageJson != JSON.null {
            result = MyFollowResp(fromJson: pageJson)
            return
        }
        order = json["order"].stringValue ?? ""
        orderBy = json["orderBy"].stringValue ?? ""
        pageNo = json["pageNo"].intValue
        pageSize = json["pageSize"].intValue
        
        list = [FollowList]()
        let resultArray = json["result"].arrayValue
        for resultJson in resultArray{
            let value = FollowList(fromJson: resultJson)
            list.append(value)
        }
        totalCount = json["totalCount"].intValue
    }
}

class FollowList {
    var fan : Int!
    var followUserId : Int!
    var id : Int!
    var name : String!
    var photo : String!
    var userId : Int!
    var detailsType: Int!
    
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        fan = json["fan"].intValue
        followUserId = json["followUserId"].intValue
        id = json["id"].intValue
        name = json["name"].stringValue ?? ""
        photo = json["photo"].stringValue ?? ""
        userId = json["userId"].intValue
        detailsType = json["detailsType"].intValue
    }
}
