//
//  ParticipateCircularResp.swift
//  OutLookers
//
//  Created by C on 16/7/24.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class ParticipateCircularResp: BaseResponse {
    
    var order : String!
    var orderBy : String!
    var pageNo : Int!
    var pageSize : Int!
    var list : [CircularList]!
    var totalCount : Int!
    var result: ParticipateCircularResp!
    
    override init(fromJson json: JSON!) {
        super.init(fromJson: json)
        if json == nil{
            return
        }
        let pageJson = json["page"]
        if pageJson != JSON.null {
            result = ParticipateCircularResp(fromJson: pageJson)
            return
        }
        order = json["order"].stringValue
        orderBy = json["orderBy"].stringValue
        pageNo = json["pageNo"].intValue
        pageSize = json["pageSize"].intValue
        
        
        list = [CircularList]()
        let resultArray = json["result"].arrayValue
        for resultJson in resultArray{
            let value = CircularList(fromJson: resultJson)
            list.append(value)
        }
        totalCount = json["totalCount"].intValue
    }
}

class CircularList {
    
    var cover : String!
    var endTime : String!
    var id : Int!
    var startTime : String!
    var state : String!
    var theme : String!
    var userId : Int!
    
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        cover = json["cover"].stringValue
        endTime = json["endTime"].stringValue
        id = json["id"].intValue
        startTime = json["startTime"].stringValue
        state = json["state"].stringValue
        theme = json["theme"].stringValue
        userId = json["userId"].intValue
    }
    
}