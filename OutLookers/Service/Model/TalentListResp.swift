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
        order = json["order"].stringValue ?? ""
        orderBy = json["orderBy"].stringValue ?? ""
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
    var categoryId: String!
    var categoryName: String!
    var city: String!
    var details : String!
    var id: String!
    var name: String!
    var price: Int!
    var province: String!
    var state: String!
    var unit: String!
    var userId: Int!
    var worksCover: String!
    
    var nickname: String!
    var headImgUrl: String!
    var createTime: String!
    var pictureNum: Int!
    var detailsType: Int!
    var picture: String!
    var follow: Int!
    
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        categoryId = json["categoryId"].stringValue ?? ""
        categoryName = json["categoryName"].stringValue ?? ""
        city = json["city"].stringValue ?? ""
        details = json["details"].stringValue ?? ""
        id = json["id"].stringValue ?? ""
        name = json["name"].stringValue ?? ""
        price = json["price"].intValue
        province = json["province"].stringValue ?? ""
        state = json["state"].stringValue ?? ""
        unit = json["unit"].stringValue ?? ""
        userId = json["userId"].intValue
        worksCover = json["worksCover"].stringValue ?? ""
        nickname = json["nickname"].stringValue ?? ""
        headImgUrl = json["headImgUrl"].stringValue ?? ""
        createTime = json["createTime"].stringValue ?? ""
        pictureNum = json["pictureNum"].intValue
        detailsType = json["detailsType"].intValue
        picture = json["picture"].stringValue ?? ""
        follow = json["follow"].intValue
    }
}