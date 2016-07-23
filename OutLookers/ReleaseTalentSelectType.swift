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

   	var id : Int!
    var name : String!
    var pid : Int!
    var result: [ReleaseTalentSelectType]!
    
    override init(fromJson json: JSON!){
        super.init(fromJson: json)
        if json == nil{
            return
        }
        id = json["id"].intValue
        name = json["name"].stringValue
        pid = json["pid"].intValue
        
        result = [ReleaseTalentSelectType]()
        guard let resultArray = json["result"].dictionaryValue["list"]?.arrayValue else { return }
        for resultJson in resultArray {
            let value = ReleaseTalentSelectType(fromJson: resultJson)
            result.append(value)
        }
    }

}
