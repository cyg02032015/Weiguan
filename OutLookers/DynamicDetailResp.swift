//
//  DynamicDetailResp.swift
//  OutLookers
//
//  Created by C on 16/7/24.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class DynamicDetailResp: BaseResponse {

    var cover : Int!
    var id : Int!
    var isVideo : String!
    var picture : String!
    var pictureList : [PictureList]!
    var talent : String?
    var talentList : [TalentList]!
    var text : String?
    var userId : Int!
    var result: DynamicDetailResp!
    
    override init(fromJson json: JSON!) {
        super.init(fromJson: json)
        if json == nil{
            return
        }
        let resultJson = json["result"]
        if resultJson != JSON.null {
            result = DynamicDetailResp(fromJson: resultJson)
            return
        }
        cover = json["cover"].intValue
        id = json["id"].intValue
        isVideo = json["isVideo"].stringValue
        picture = json["picture"].stringValue
        text = json["text"].stringValue
        userId = json["userId"].intValue
        
        pictureList = [PictureList]()
        let pictureListArray = json["pictureList"].arrayValue
        for pictureListJson in pictureListArray{
            let value = PictureList(fromJson: pictureListJson)
            pictureList.append(value)
        }
        
        talent = json["talent"].stringValue
        talentList = [TalentList]()
        let talentListArray = json["talentList"].arrayValue
        for talentListJson in talentListArray{
            let value = TalentList(fromJson: talentListJson)
            talentList.append(value)
        }
    }
}

class PictureList {
    
    var id : Int!
    var url : String!
    
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        id = json["id"].intValue
        url = json["url"].stringValue
    }
}

class TalentList {
    
    var categoryId : Int!
    var categoryName : String!
    var id : Int!
    var name : String!
    
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        categoryId = json["categoryId"].intValue
        categoryName = json["categoryName"].stringValue
        id = json["id"].intValue
        name = json["name"].stringValue
    }
}
