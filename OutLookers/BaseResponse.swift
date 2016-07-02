//
//  BaseResponse.swift
//  OutLookers
//
//  Created by C on 16/7/2.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class BaseResponse {
    
    var success : Bool!
    var code: Int?
    var msg: String?
    
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        success = json["success"].boolValue
        if let code = json["code"].int {
            self.code = code
        }
        if let msg = json["message"].dictionaryValue["global"]?.stringValue {
            self.msg = msg
        }
    }
}
