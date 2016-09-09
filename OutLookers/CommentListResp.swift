//
//  CommentListResp.swift
//  OutLookers
//
//  Created by C on 16/7/30.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class CommentListResp: BaseResponse {
    var order : String!
    var orderBy : String!
    var pageNo : Int!
    var pageSize : Int!
    var lists : [CommentList]!
    var totalCount : Int!
    var result: CommentListResp!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    override init(fromJson json: JSON!){
        super.init(fromJson: json)
        if json == nil{
            return
        }
        let pageJson = json["page"]
        if pageJson != JSON.null {
            result = CommentListResp(fromJson: pageJson)
            return
        }
        order = json["order"].stringValue
        orderBy = json["orderBy"].stringValue
        pageNo = json["pageNo"].intValue
        pageSize = json["pageSize"].intValue
        lists = [CommentList]()
        let resultArray = json["result"].arrayValue
        for resultJson in resultArray{
            let value = CommentList(fromJson: resultJson)
            lists.append(value)
        }
        totalCount = json["totalCount"].intValue
    }
}

class CommentList {
    var cover : String!
    var createTime : String!
    var headImgUrl : String!
    var id : Int!
    var nickname : String!
    var replyId : Int!
    var replyNickname : String!
    var text : String!
    var userId : Int!
    var detailsType: Int!
    var dynamicId: Int!
    
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        cover = json["cover"].stringValue ?? ""
        createTime = json["createTime"].stringValue ?? ""
        headImgUrl = json["headImgUrl"].stringValue ?? ""
        id = json["id"].intValue
        nickname = json["nickname"].stringValue ?? ""
        replyId = json["replyId"].intValue
        replyNickname = json["replyNickname"].stringValue ?? ""
        text = json["text"].stringValue ?? ""
        userId = json["userId"].intValue
        detailsType = json["detailsType"].intValue
        dynamicId = json["dynamicId"].intValue
    }
}