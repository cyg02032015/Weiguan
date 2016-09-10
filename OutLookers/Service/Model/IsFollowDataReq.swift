//
//  IsFollowDataReq.swift
//  OutLookers
//
//  Created by 宋碧海 on 16/9/8.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

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
