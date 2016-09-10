//
//  GetContentResp.swift
//  OutLookers
//
//  Created by C on 16/7/30.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class GetContentResp: BaseResponse {
    var result: GetContent!
    
    override init(fromJson json: JSON!) {
        super.init(fromJson: json)
        if json == nil{
            return
        }
        
        
        let resultJson = json["result"]
        if resultJson != JSON.null {
            result = GetContent(fromJson: resultJson)
            return
        }
    }
}

class GetContent {
    var dynamic : Int!
    var fan : Int!
    var follow : Int!
    
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        dynamic = json["dynamic"].intValue
        fan = json["fan"].intValue
        follow = json["follow"].intValue
    }
}