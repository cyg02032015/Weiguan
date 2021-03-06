//
//  IsFollowData.swift
//  OutLookers
//
//  Created by 宋碧海 on 16/9/8.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class IsFollowData {
    
    var userId : Int
    var followUserId : Int
    var concerned : Int
    var beConcerned : Int
    
    init(json: JSON) {
        userId       = json["userId"].intValue
        followUserId = json["followUserId"].intValue
        concerned    = json["concerned"].intValue
        beConcerned  = json["beConcerned"].intValue
    }
}


class IsFollowDataReq: BaseResponse {
    var result: IsFollowData!
    
    override init(fromJson json: JSON!) {
        super.init(fromJson: json)
        if json == nil{
            return
        }
        
        let resultJson = json["result"]
        if resultJson != JSON.null {
            result = IsFollowData(json: resultJson)
            return
        }
    }
}
