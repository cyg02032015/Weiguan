//
//  FindHotmanResp.swift
//  OutLookers
//
//  Created by C on 16/7/24.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class FindHotmanResp: BaseResponse {
    var result: [FindeHotman]!
    
    override init(fromJson json: JSON!){
        super.init(fromJson: json)
        if json == nil{
            return
        }
        
        result = [FindeHotman]()
        let resultArray = json["result"].arrayValue
        for resultJson in resultArray{
            let value = FindeHotman(fromJson: resultJson)
            result.append(value)
        }
        
    }
}

class FindeHotman {
    
    var headImgUrl : String!
    var id : Int!
    var nickname : String!
    init (fromJson json: JSON!) {
        headImgUrl = json["headImgUrl"].stringValue ?? ""
        id = json["id"].intValue
        nickname = json["nickname"].stringValue ?? ""
    }
}