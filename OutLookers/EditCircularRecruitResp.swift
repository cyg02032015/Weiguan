//
//  EditCircularRecruitResp.swift
//  OutLookers
//
//  Created by C on 16/7/24.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class EditCircularRecruitResp: BaseResponse {
    
    var categoryId : Int!
    var categoryName : String!
    var id : Int!
    var number : Int!
    var price : Int!
    var unit : String!
    var userId : Int!
    var result: EditCircularRecruitResp!
    
    override init(fromJson json: JSON!){
        super.init(fromJson: json)
        if json == nil{
            return
        }
        categoryId = json["categoryId"].intValue
        categoryName = json["categoryName"].stringValue
        id = json["id"].intValue
        number = json["number"].intValue
        price = json["price"].intValue
        unit = json["unit"].stringValue
        userId = json["userId"].intValue
        
        let r = json["result"]
        if r != JSON.null {
            result = EditCircularRecruitResp(fromJson: r)
        }
    }
}
