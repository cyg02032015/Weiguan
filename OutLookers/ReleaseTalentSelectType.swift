//
//  ReleaseTalentSelectType.swift
//  OutLookers
//
//  Created by C on 16/7/23.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class ReleaseTalentSelectType: BaseResponse {

    var result: [TalentSelectTypeList]!
    
    override init(fromJson json: JSON!){
        super.init(fromJson: json)
        if json == nil{
            return
        }
        
        result = [TalentSelectTypeList]()
        guard let resultArray = json["result"].dictionaryValue["list"]?.arrayValue else { return }
        for resultJson in resultArray {
            let value = TalentSelectTypeList(fromJson: resultJson)
            result.append(value)
        }
    }
}

class TalentSelectTypeList {
    
   	var id : Int!
    var name : String!
    var pid : Int!
    
    init(fromJson json: JSON!) {
        if json == nil{
            return
        }
        id = json["id"].intValue
        name = json["name"].stringValue
        pid = json["pid"].intValue
    }
}
