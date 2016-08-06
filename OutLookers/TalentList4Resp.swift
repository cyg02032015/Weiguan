//
//  TalentList4Resp.swift
//  OutLookers
//
//  Created by C on 16/8/6.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class TalentList4Resp: BaseResponse {
    var order : String!
    var orderBy : String!
    var pageNo : Int!
    var pageSize : Int!
    var result : [Result]!
    var totalCount : Int!
    
    override init(fromJson json: JSON!){
        super.init(fromJson: json)
        if json == nil{
            return
        }
        order = json["order"].stringValue
        orderBy = json["orderBy"].stringValue
        pageNo = json["pageNo"].intValue
        pageSize = json["pageSize"].intValue
        result = [Result]()
        let resultArray = json["result"].arrayValue
        for resultJson in resultArray{
            let value = Result(fromJson: resultJson)
            result.append(value)
        }
        totalCount = json["totalCount"].intValue
    }
}

class Result{
    
    var categoryName : String!
    var city : AnyObject!
    var createTime : String!
    var details : String!
    var id : Int!
    var list : [List]!
    var name : String!
    var picture : String!
    var pictureNum : Int!
    var price : Int!
    var state : String!
    var unit : String!
    var worksCover : String!
    
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        categoryName = json["categoryName"].stringValue
        city = json["city"].stringValue
        createTime = json["createTime"].stringValue
        details = json["details"].stringValue
        id = json["id"].intValue
        list = [List]()
        let listArray = json["list"].arrayValue
        for listJson in listArray{
            let value = List(fromJson: listJson)
            list.append(value)
        }
        name = json["name"].stringValue
        picture = json["picture"].stringValue
        pictureNum = json["pictureNum"].intValue
        price = json["price"].intValue
        state = json["state"].stringValue
        unit = json["unit"].stringValue
        worksCover = json["worksCover"].stringValue
    }
    
}

class List {
    
    var id : Int!
    var type : Int!
    var url : String!
    
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        id = json["id"].intValue
        type = json["type"].intValue
        url = json["url"].stringValue
    }
    
}