//
//  talentPhotoModel.swift
//  OutLookers
//
//  Created by 宋碧海 on 16/9/12.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class TalentPhotoModel {
    var id: Int!
    var url: String!
    var width: Int!
    var height: Int!
    
    init(json: JSON) {
        id = json["id"].intValue
        url = json["url"].stringValue ?? ""
        width = json["width"].intValue
        height = json["height"].intValue
    }
}
