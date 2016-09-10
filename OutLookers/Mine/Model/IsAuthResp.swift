//
//  IsAuthResp.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/18.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON
class IsAuthResp: BaseResponse {
    
    var authentication : Bool!
    var type : UserType!
    var userId : Int!
    
    override init(fromJson json: JSON!){
        super.init(fromJson: json)
        if json == nil{
            return
        }
        guard let result = json["result"].dictionary else {return}
        authentication = result["authentication"]?.boolValue ?? false
        if result["type"]?.intValue == 1 {
            type = .HotMan
        } else if result["type"]?.intValue == 2 {
            type = .Organization
        } else if result["type"]?.intValue == 3 {
            type = .Fans
        } else {
            LogError("type is not 1,2,3")
        }
        if authentication == false {
           type = .Tourist
        }
        userId = result["userId"]?.intValue ?? 0
    }
}
