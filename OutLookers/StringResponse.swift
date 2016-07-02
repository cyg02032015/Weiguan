//
//  StringResponse.swift
//  OutLookers
//
//  Created by C on 16/7/2.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class StringResponse: BaseResponse {

    var result: String!
    
    override init(fromJson json: JSON!){
        super.init(fromJson: json)
        if json == nil{
            return
        }
        result = json["result"].stringValue
    }
    
}
