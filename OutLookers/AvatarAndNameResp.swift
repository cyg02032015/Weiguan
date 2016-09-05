//
//  AvatarAndNameResp.swift
//  OutLookers
//
//  Created by C on 16/7/24.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class AvatarAndNameResp: BaseResponse {
    var result: [AvatarNameList]!
    
    override init(fromJson json: JSON!){
        super.init(fromJson: json)
        if json == nil{
            return
        }
        
        result = [AvatarNameList]()
        let resultArray = json["result"].arrayValue
        for resultJson in resultArray{
            let value = AvatarNameList(fromJson: resultJson)
            result.append(value)
        }
    }
}

class AvatarNameList {
    var headImgUrl : String!
    var id : Int!
    var nickname : String!
    var detailsType: Int!
    
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        headImgUrl = json["headImgUrl"].stringValue ?? ""
        id = json["id"].intValue
        nickname = json["nickname"].stringValue ?? ""
        detailsType = json["detailsType"].intValue
    }
}