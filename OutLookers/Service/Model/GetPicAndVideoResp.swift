//
//  GetPicAndVideoResp.swift
//  OutLookers
//
//  Created by C on 16/7/24.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class GetPicAndVideoResp: BaseResponse {
    
    var result: [PicAndVideoList]!
    
    override init(fromJson json: JSON!){
        super.init(fromJson: json)
        if json == nil{
            return
        }
        
        result = [PicAndVideoList]()
        let resultArray = json["result"].arrayValue
        for resultJson in resultArray{
            let value = PicAndVideoList(fromJson: resultJson)
            result.append(value)
        }
    }
}

class PicAndVideoList {
    var id : Int!
    var type : Int!
    var url : String!
    
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        
        id = json["id"].intValue
        type = json["type"].intValue
        url = json["url"].stringValue
    }
}