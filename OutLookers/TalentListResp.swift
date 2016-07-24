//
//  TalentListResp.swift
//  OutLookers
//
//  Created by C on 16/7/24.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class TalentListResp: BaseResponse {
    var order : String!
    var orderBy : String!
    var pageNo : Int!
    var pageSize : Int!
    var list : [TalentResult]!
    var totalCount : Int!
    var result: TalentListResp!
    
    override init(fromJson json: JSON!) {
        super.init(fromJson: json)
        if json == nil{
            return
        }
        let pageJson = json["page"]
        if pageJson != JSON.null {
            result = TalentListResp(fromJson: pageJson)
            return
        }
        order = json["order"].stringValue
        orderBy = json["orderBy"].stringValue
        pageNo = json["pageNo"].intValue
        pageSize = json["pageSize"].intValue
        
        list = [TalentResult]()
        let resultArray = json["result"].arrayValue
        for resultJson in resultArray{
            let value = TalentResult(fromJson: resultJson)
            list.append(value)
        }
        totalCount = json["totalCount"].intValue
    }
}


class TalentResult {
    var categoryId : Int!
    var categoryName : String!
    var city : String!
    var details : String!
    var id : Int!
    var name : String!
    var price : Float!
    var province : String!
    var state : String!
    var unit : Int!
    var userId : Int!
    var worksCover : String!
    
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        categoryId = json["categoryId"].intValue
        categoryName = json["categoryName"].stringValue
        city = json["city"].stringValue
        details = json["details"].stringValue
        id = json["id"].intValue
        name = json["name"].stringValue
        price = json["price"].floatValue
        province = json["province"].stringValue
        state = json["state"].stringValue
        unit = json["unit"].intValue
        userId = json["userId"].intValue
        worksCover = json["worksCover"].stringValue
    }
}