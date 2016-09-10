//
//  LikeListResp.swift
//  OutLookers
//
//  Created by C on 16/7/30.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class LikeListResp: BaseResponse {
    var order : String!
    var orderBy : String!
    var pageNo : Int!
    var pageSize : Int!
    var lists : [LikeList]!
    var totalCount : Int!
    var result: LikeListResp!
    
    override init(fromJson json: JSON!){
        super.init(fromJson: json)
        if json == nil{
            return
        }
        let pageJson = json["page"]
        if pageJson != JSON.null {
            result = LikeListResp(fromJson: pageJson)
            return
        }
        order = json["order"].stringValue
        orderBy = json["orderBy"].stringValue
        pageNo = json["pageNo"].intValue
        pageSize = json["pageSize"].intValue
        lists = [LikeList]()
        let resultArray = json["result"].arrayValue
        for resultJson in resultArray{
            let value = LikeList(fromJson: resultJson)
            lists.append(value)
        }
        totalCount = json["totalCount"].intValue
    }
}

class LikeList {
    var cover : String!
    var createTime : String!
    var detailsType : Int!
    var follow : Int!
    var headImgUrl : String!
    var nickname : String!
    var userId : String!
    var dynamicId: Int!
    
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        cover = json["cover"].stringValue ?? ""
        createTime = json["createTime"].stringValue ?? ""
        detailsType = json["detailsType"].intValue
        follow = json["follow"].intValue
        headImgUrl = json["headImgUrl"].stringValue ?? ""
        nickname = json["nickname"].stringValue ?? ""
        userId = json["userId"].stringValue ?? ""
        dynamicId = json["dynamicId"].intValue
    }

}