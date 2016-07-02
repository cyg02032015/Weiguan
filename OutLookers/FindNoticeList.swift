//
//  FindNoticeList.swift
//  OutLookers
//
//  Created by C on 16/7/2.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class FindNoticeList: BaseResponse {
    
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
    var theme : String!
    var userId : Int!
    var result: [FindNoticeList]!

    override init(fromJson json: JSON!){
        super.init(fromJson: json)
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
        theme = json["theme"].stringValue
        userId = json["userId"].intValue
        
        result = [FindNoticeList]()
        let resultArray = json["result"].arrayValue
        for resultJson in resultArray {
            let value = FindNoticeList(fromJson: resultJson)
            result.append(value)
        }
    }
    
}