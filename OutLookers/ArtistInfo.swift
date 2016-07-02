//
//  ArtistResponse.swift
//  OutLookers
//
//  Created by C on 16/7/2.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class ArtistInfo: BaseResponse {
    var categoryId : Int!
    var categoryName : String!
    var city : String!
    var details : String!
    var id : Int!
    var name : String!
    var price : Float!
    var province : String!
    var unit : Int!
    var userId : Int!
    var worksCover : String!
    var worksPicture : String!
    var worksVideo : String!
    var result: [ArtistInfo]!
    

    override init(fromJson json: JSON!){
        super.init(fromJson: json)
        if json == nil{
            return
        }
        categoryId = json["categoryId"].intValue
        categoryName = json["categoryName"].stringValue
        city = json["city"].stringValue
        details = json["details"].stringValue
        id = json["id"].intValue
        name = json["name"].stringValue
        price = json["price"].floatValue
        province = json["province"].stringValue
        unit = json["unit"].intValue
        userId = json["userId"].intValue
        worksCover = json["worksCover"].stringValue
        worksPicture = json["worksPicture"].stringValue
        worksVideo = json["worksVideo"].stringValue
        
        result = [ArtistInfo]()
        let resultArray = json["result"].arrayValue
        for resultJson in resultArray {
            let value = ArtistInfo(fromJson: resultJson)
            result.append(value)
        }
    }
}
