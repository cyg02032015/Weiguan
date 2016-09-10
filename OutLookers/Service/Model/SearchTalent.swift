//
//  SearchTalent.swift
//  OutLookers
//
//  Created by C on 16/7/23.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class SearchTalent: BaseResponse {
    
    var result: [SearchTalentList]!
    
    override init(fromJson json: JSON!){
        super.init(fromJson: json)
        if json == nil{
            return
        }
        
        result = [SearchTalentList]()
        guard let resultArray = json["result"].dictionaryValue["list"]?.arrayValue else { return }
        for resultJson in resultArray {
            let value = SearchTalentList(fromJson: resultJson)
            result.append(value)
        }
    }
}

class SearchTalentList {
    
    var id : Int!
    var name : String!
    
    init(fromJson json: JSON!) {
        if json == nil{
            return
        }
        id = json["id"].intValue
        name = json["name"].stringValue
    }
}
