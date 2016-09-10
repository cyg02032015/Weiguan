//
//  RecuitInfomationResp.swift
//  OutLookers
//
//  Created by C on 16/7/24.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class RecruitInformationResp: BaseResponse {
    var result: [RecruitInformationList]!
    
    override init(fromJson json: JSON!){
        super.init(fromJson: json)
        if json == nil{
            return
        }
        
        result = [RecruitInformationList]()
        let resultArray = json["result"].arrayValue
        for resultJson in resultArray{
            let value = RecruitInformationList(fromJson: resultJson)
            result.append(value)
        }
    }
}

class RecruitInformationList {
    var categoryId : Int!
    var categoryName : String!
    var id : Int!
    var number : Int!
    var price : Int!
    var unit : Int!
    
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        categoryId = json["categoryId"].intValue
        categoryName = json["categoryName"].stringValue
        id = json["id"].intValue
        number = json["number"].intValue
        price = json["price"].intValue
        unit = json["unit"].intValue
    }
}
