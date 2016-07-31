//
//  OrganizeInformationResp.swift
//  OutLookers
//
//  Created by C on 16/7/30.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class OrganizeInformationResp: BaseResponse {
    var result: OGInfomation!
    
    override init(fromJson json: JSON!) {
        super.init(fromJson: json)
        if json == nil{
            return
        }
        
        
        let resultJson = json["result"]
        if resultJson != JSON.null {
            result = OGInfomation(fromJson: resultJson)
            return
        }
    }
}

class OGInfomation {
    var adds : String!
    var introduction : String!
    var name : String!
    var type : String!
    var userId : Int!
    
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        adds = json["adds"].stringValue
        introduction = json["introduction"].stringValue
        name = json["name"].stringValue
        type = json["type"].stringValue
        userId = json["userId"].intValue
    }

}