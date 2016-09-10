//
//  IsAuthDataReq.swift
//  OutLookers
//
//  Created by 宋碧海 on 16/9/8.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class IsAuthDataReq: BaseResponse {
    var result: IsAuthData!
    
    override init(fromJson json: JSON!) {
        super.init(fromJson: json)
        if json == nil{
            return
        }
        
        let resultJson = json["result"]
        if resultJson != JSON.null {
            result = IsAuthData(json: resultJson)
            return
        }
    }
}
