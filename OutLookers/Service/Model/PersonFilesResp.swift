//
//  PersonFilesResp.swift
//  OutLookers
//
//  Created by C on 16/7/24.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class PersonFilesResp: BaseResponse {
    var array : [String]!
    var bust : String!
    var characteristics : String!
    var constellation : String!
    var experience : String!
    var height : String!
    var hipline : String!
    var id : Int!
    var userId : Int!
    var waist : String!
    var weight : String!
    var result: PersonFilesResp!
    override init(fromJson json: JSON!){
        super.init(fromJson: json)
        if json == nil{
            return
        }
        
        let pageJson = json["result"]
        if pageJson != JSON.null {
            result = PersonFilesResp(fromJson: pageJson)
            return
        }
        
        array = [String]()
        let arrayArray = json["array"].arrayValue
        for arrayJson in arrayArray{
            array.append(arrayJson.stringValue)
        }
        bust = json["bust"].stringValue ?? ""
        characteristics = json["characteristics"].stringValue ?? ""
        constellation = json["constellation"].stringValue ?? ""
        experience = json["experience"].stringValue ?? ""
        height = json["height"].stringValue ?? ""
        hipline = json["hipline"].stringValue ?? ""
        id = json["id"].intValue
        userId = json["userId"].intValue
        waist = json["waist"].stringValue ?? ""
        weight = json["weight"].stringValue ?? ""
    }
}
