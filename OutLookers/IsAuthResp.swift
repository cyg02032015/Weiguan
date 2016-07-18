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
    var type : Int!
    var userId : Int!
    
    override init(fromJson json: JSON!){
        super.init(fromJson: json)
        if json == nil{
            return
        }
        guard let result = json["result"].dictionary else {return}
        authentication = result["authentication"]?.boolValue ?? false
        type = result["type"]?.intValue ?? 0
        userId = result["userId"]?.intValue ?? 0
    }
}
