//
//  HotmanAuthShowResp.swift
//  OutLookers
//
//  Created by C on 16/7/24.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class HotmanAuthShowResp: BaseResponse {
    var archives : Bool!
    var dynamic : Bool!
    var mobile : Bool!
    var talent : Bool!
    var result : HotmanAuthShowResp!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    override init(fromJson json: JSON!){
        super.init(fromJson: json)
        if json == nil{
            return
        }
        
        let r = json["result"]
        if r != JSON.null {
            result = HotmanAuthShowResp(fromJson: r)
        }
        
        archives = json["archives"].boolValue
        dynamic = json["dynamic"].boolValue
        mobile = json["mobile"].boolValue
        talent = json["talent"].boolValue
    }
}
