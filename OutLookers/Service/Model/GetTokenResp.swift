//
//  GetTokenResp.swift
//  OutLookers
//
//  Created by C on 16/7/27.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class GetTokenResp: BaseResponse {
    var result: GetToken!
    
    override init(fromJson json: JSON!) {
        super.init(fromJson: json)
        if json == nil{
            return
        }
        let r = json["result"]
        if r != JSON.null {
            result = GetToken(fromJson: r)
        }
    }
}

class GetToken {
    var accessKeyId : String!
    var accessKeySecret : String!
    var bucket : String!
    var callbackBody : String!
    var callbackUrl : String!
    var dir : String!
    var expiration : String!
    var expirationMillis : Int!
    var region : String!
    var securityToken : String!
    
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        accessKeyId = json["accessKeyId"].stringValue
        accessKeySecret = json["accessKeySecret"].stringValue
        bucket = json["bucket"].stringValue
        callbackBody = json["callbackBody"].stringValue
        callbackUrl = json["callbackUrl"].stringValue
        dir = json["dir"].stringValue
        expiration = json["expiration"].stringValue
        expirationMillis = json["expirationMillis"].intValue
        region = json["region"].stringValue
        securityToken = json["securityToken"].stringValue
    }
}