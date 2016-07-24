//
//  CircularEnrollPersonResp.swift
//  OutLookers
//
//  Created by C on 16/7/24.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class CircularEnrollPersonResp: BaseResponse {
    
    var result: [EnrollPersonList]!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    override init(fromJson json: JSON!){
        super.init(fromJson: json)
        if json == nil{
            return
        }
        guard let listArray = json["result"].dictionaryValue["list"]?.arrayValue else {return}
        result = [EnrollPersonList]()
        for listJson in listArray{
            let value = EnrollPersonList(fromJson: listJson)
            result.append(value)
        }
    }
}

class EnrollPersonList {
    var headImgUrl : String!
    var id : Int!
    
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        headImgUrl = json["headImgUrl"].stringValue
        id = json["id"].intValue
    }
}
