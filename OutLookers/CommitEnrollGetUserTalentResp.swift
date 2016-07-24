//
//  CommitEnrollGetUserTalentResp.swift
//  OutLookers
//
//  Created by C on 16/7/24.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class CommitEnrollGetUserTalentResp: BaseResponse {
    
    var result: [UserTalentList]!
    
    override init(fromJson json: JSON!){
        super.init(fromJson: json)
        if json == nil{
            return
        }
        guard let listArray = json["result"].dictionaryValue["list"]?.arrayValue else {return}
        result = [UserTalentList]()
        for listJson in listArray {
            let value = UserTalentList(fromJson: listJson)
            result.append(value)
        }
    }
}

class UserTalentList {
    var id : Int!
    var name : String!
    
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        id = json["id"].intValue
        name = json["name"].stringValue
    }
}