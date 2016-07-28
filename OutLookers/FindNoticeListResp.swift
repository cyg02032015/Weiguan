//
//  FindNoticeList.swift
//  OutLookers
//
//  Created by C on 16/7/2.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class FindNoticeListResp: BaseResponse {
    
    var order : String!
    var orderBy : String!
    var pageNo : Int!
    var pageSize : Int!
    var totalCount : Int!
    var findNoticeResult: [FindNotice]!
    var result: FindNoticeListResp!
    
    override init(fromJson json: JSON!){
        super.init(fromJson: json)
        if json == nil{
            return
        }
        
        let pageJson = json["page"]
        if pageJson != JSON.null {
            result = FindNoticeListResp(fromJson: pageJson)
            return
        }
        
        order = json["order"].stringValue
        orderBy = json["orderBy"].stringValue
        pageNo = json["pageNo"].intValue
        pageSize = json["pageSize"].intValue
        totalCount = json["totalCount"].intValue
        
        
        findNoticeResult = [FindNotice]()
        let resultArray = json["result"].arrayValue
        for resultJson in resultArray {
            let value = FindNotice(fromJson: resultJson)
            findNoticeResult.append(value)
        }
    }
}

class FindNotice {
    var adds : String!
    var city : String!
    var details : String!
    var endTime : String!
    var id : Int!
    var picture : String!
    var province : String!
    var recruitment : String!
    var register : String!
    var startTime : String!
    var state : String!
    var theme : String!
    var userId : Int!
    var cover: String!
    
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        adds = json["adds"].stringValue
        city = json["city"].stringValue
        details = json["details"].stringValue
        endTime = json["endTime"].stringValue
        id = json["id"].intValue
        picture = json["picture"].stringValue
        province = json["province"].stringValue
        recruitment = json["recruitment"].stringValue
        register = json["register"].stringValue
        startTime = json["startTime"].stringValue
        state = json["state"].stringValue
        theme = json["theme"].stringValue
        userId = json["userId"].intValue
        cover = json["cover"].stringValue
    }
}
