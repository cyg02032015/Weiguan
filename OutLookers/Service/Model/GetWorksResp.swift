//
//  GetWorksResp.swift
//  OutLookers
//
//  Created by C on 16/7/24.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class GetWorksResp: BaseResponse {
    var result: [WorksList]!
    
    override init(fromJson json: JSON!){
        super.init(fromJson: json)
        if json == nil{
            return
        }
        
        result = [WorksList]()
        let resultArray = json["result"].arrayValue
        for resultJson in resultArray{
            let value = WorksList(fromJson: resultJson)
            result.append(value)
        }
    }
}

class WorksList {
    var createTime : String!
    var id : Int!
    var talentId : Int!
    var text : String!
    var worksIds : String!
    var list: [TalentPhotoModel]!
    
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        createTime = json["createTime"].stringValue ?? ""
        id = json["id"].intValue
        talentId = json["talentId"].intValue
        text = json["text"].stringValue ?? ""
        worksIds = json["worksIds"].stringValue ?? ""
        let lists = json["list"].arrayValue
        list = [TalentPhotoModel]()
        for listJson in lists {
            let model = TalentPhotoModel(json: listJson)
            list.append(model)
        }
        
    }
}