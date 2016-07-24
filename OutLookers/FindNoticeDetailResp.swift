//
//  FindNoticeDetailResp.swift
//  OutLookers
//
//  Created by C on 16/7/24.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class FindNoticeDetailResp: BaseResponse {
    var adds : String!
    var city : String!
    var cover : AnyObject!
    var details : String!
    var endTime : String!
    var id : Int!
    var picture : String!
    var pictureList : [PictureList]!
    var province : String!
    var recruitment : String!
    var recruitmentList : [RecruitmentList]!
    var register : String!
    var startTime : String!
    var theme : String!
    var userId : Int!
    var result: FindNoticeDetailResp!
    
    override init(fromJson json: JSON!) {
        super.init(fromJson: json)
        if json == nil{
            return
        }
        let pageJson = json["result"]
        if pageJson != JSON.null {
            result = FindNoticeDetailResp(fromJson: pageJson)
            return
        }
        adds = json["adds"].stringValue
        city = json["city"].stringValue
        cover = json["cover"].stringValue
        details = json["details"].stringValue
        endTime = json["endTime"].stringValue
        id = json["id"].intValue
        picture = json["picture"].stringValue
        province = json["province"].stringValue
        recruitment = json["recruitment"].stringValue
        register = json["register"].stringValue
        startTime = json["startTime"].stringValue
        theme = json["theme"].stringValue
        userId = json["userId"].intValue
        
        
        pictureList = [PictureList]()
        let pictureListArray = json["pictureList"].arrayValue
        for pictureListJson in pictureListArray{
            let value = PictureList(fromJson: pictureListJson)
            pictureList.append(value)
        }
        
        recruitmentList = [RecruitmentList]()
        let recruitmentListArray = json["recruitmentList"].arrayValue
        for recruitmentListJson in recruitmentListArray{
            let value = RecruitmentList(fromJson: recruitmentListJson)
            recruitmentList.append(value)
        }
    }
}

class RecruitmentList {
    
    var categoryId : Int!
    var categoryName : String!
    var id : Int!
    var number : Int!
    var price : Int!
    var unit : Int!
    
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        categoryId = json["categoryId"].intValue
        categoryName = json["categoryName"].stringValue
        id = json["id"].intValue
        number = json["number"].intValue
        price = json["price"].intValue
        unit = json["unit"].intValue
    }
}