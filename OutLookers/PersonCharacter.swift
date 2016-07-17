//
//  PersonCharacter.swift
//  OutLookers
//
//  Created by C on 16/7/17.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class PersonCharacter: BaseResponse {
    var id : Int!
    var name : String!
    var pid : Int!
    var result: [PersonCharacter]!
    
    override init(fromJson json: JSON!){
        super.init(fromJson: json)
        if json == nil{
            return
        }
        
        id = json["id"].intValue
        name = json["name"].stringValue
        pid = json["pid"].intValue
        result = [PersonCharacter]()
        let resultArray = json["result"].arrayValue
        for resultJson in resultArray {
            let value = PersonCharacter(fromJson: resultJson)
            result.append(value)
        }
    }

}