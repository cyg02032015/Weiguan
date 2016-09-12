//
//  BingAccountData.swift
//  OutLookers
//
//  Created by 宋碧海 on 16/9/10.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class BingAccountData {

    var type: Int!
    var nickname: String!
    
    init(json: JSON) {
        type = json["type"].intValue
        nickname = json["nickname"].stringValue ?? ""
    }
}

class BingAccountDataReq: BaseResponse {
    var result: BingAccountData!
    
    override init(fromJson json: JSON!) {
        super.init(fromJson: json)
        if json == nil{
            return
        }
        let r = json["result"]
        if r != JSON.null {
            result = BingAccountData(json: r)
        }
    }
}