//
//  SnapshotsResp.swift
//  OutLookers
//
//  Created by C on 16/8/2.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class SnapshotsResp: BaseResponse {
    var result : [String]!
    
    override init(fromJson json: JSON!){
        super.init(fromJson: json)
        if json == nil{
            return
        }
        result = [String]()
        let resultArray = json["result"].arrayValue
        for resultJson in resultArray{
            result.append(resultJson.stringValue)
        }
        success = json["success"].boolValue
    }
}
