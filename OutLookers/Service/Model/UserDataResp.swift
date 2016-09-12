//
//  UserDataResp.swift
//  OutLookers
//
//  Created by C on 16/7/25.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserDataResp: BaseResponse {
    var result: UserData!
    
    override init(fromJson json: JSON!) {
        super.init(fromJson: json)
        if json == nil{
            return
        }
        let r = json["result"]
        if r != JSON.null {
            result = UserData(fromJson: r)
        }
    }
}

class UserData {
    var birthday : String!
    var city : String!
    var headImgUrl : String!
    var id : Int!
    var introduction : String!
    var nickname : String!
    var province : String!
    var sex : String!
    
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        birthday = json["birthday"].stringValue ?? ""
        city = json["city"].stringValue ?? ""
        headImgUrl = json["headImgUrl"].stringValue ?? ""
        id = json["id"].intValue
        introduction = json["introduction"].stringValue ?? ""
        nickname = json["nickname"].stringValue ?? ""
        province = json["province"].stringValue ?? ""
        sex = json["sex"].stringValue ?? ""
    }
}