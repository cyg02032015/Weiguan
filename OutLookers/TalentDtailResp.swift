//
//  TalentDtailResp.swift
//  OutLookers
//
//  Created by C on 16/7/24.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class TalentDtailResp: BaseResponse {
    
    var categoryId : Int!
    var categoryName : String!
    var city : String!
    var details : String!
    var headImgUrl : String!
    var id : Int!
    var name : String!
    var nickname : String!
    var price : Int!
    var province : String!
    var state : String!
    var unit : String!
    var userId : Int!
    var worksCover : String!
    var result: TalentDtailResp!
    
    override init(fromJson json: JSON!){
        super.init(fromJson: json)
        if json == nil{
            return
        }
        let resultJson = json["result"]
        if resultJson != JSON.null {
            result = TalentDtailResp(fromJson: resultJson)
            return
        }
        categoryId = json["categoryId"].intValue
        categoryName = json["categoryName"].stringValue
        city = json["city"].stringValue
        details = json["details"].stringValue
        headImgUrl = json["headImgUrl"].stringValue
        id = json["id"].intValue
        name = json["name"].stringValue
        nickname = json["nickname"].stringValue
        price = json["price"].intValue
        province = json["province"].stringValue
        state = json["state"].stringValue
        unit = json["unit"].stringValue
        userId = json["userId"].intValue
        worksCover = json["worksCover"].stringValue
    }
}


