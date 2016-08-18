//
//  RegisterResp.swift
//  OutLookers
//
//  Created by C on 16/8/18.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class RegisterResp: BaseResponse {
    var result: RegisterObj!
    
    override init(fromJson json: JSON!) {
        super.init(fromJson: json)
        if json == nil {
            return
        }
        let resultJson = json["result"]
        if resultJson != JSON.null {
            result = RegisterObj(fromJson: resultJson)
        }
    }
}

class RegisterObj {
    var token : String!
    var token2 : String!
    var userId : Int!
    
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        token = json["token"].stringValue
        token2 = json["token2"].stringValue
        userId = json["userId"].intValue
    }
}
