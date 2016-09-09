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
    var list : [DynamicResult]!
    var totalCount : Int!
    var result: DynamicListResp!
    
    override init(fromJson json: JSON!) {
        super.init(fromJson: json)
        if json == nil{
            return
        }
        
        let pageJson = json["page"]
        if pageJson != JSON.null {
            result = DynamicListResp(fromJson: pageJson)
            return
        }
        order = json["order"].stringValue
        orderBy = json["orderBy"].stringValue
        pageNo = json["pageNo"].intValue
        pageSize = json["pageSize"].intValue
        
        list = [DynamicResult]()
        let resultArray = json["result"].arrayValue
        for resultJson in resultArray{
            let value = DynamicResult(fromJson: resultJson)
            list.append(value)
        }
        totalCount = json["totalCount"].intValue
    }
}

class DynamicResult {
    var cover : String!
    var createTime : String!
    var detailsType : Int!
    var follow : Int!
    var id : Int!
    var isLike : Bool!
    var isVideo : Int!
    var likeCount : Int!
    var name : String!
    var photo : String!
    var picture : String!
    var replyCount : Int!
    var text : String!
    var userId : Int!
    
    init () {
        
    }
    
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        cover = json["cover"].stringValue ?? ""
        createTime = json["createTime"].stringValue ?? ""
        detailsType = json["detailsType"].intValue ?? 0
        follow = json["follow"].intValue ?? 0
        id = json["id"].intValue ?? 0
        isLike = json["isLike"].boolValue
        isVideo = json["isVideo"].intValue ?? 0
        likeCount = json["likeCount"].intValue ?? 0
        name = json["name"].stringValue ?? ""
        photo = json["photo"].stringValue ?? ""
        picture = json["picture"].stringValue ?? ""
        replyCount = json["replyCount"].intValue ?? 0
        text = json["text"].stringValue ?? ""
        userId = json["userId"].intValue ?? 0
    }}
