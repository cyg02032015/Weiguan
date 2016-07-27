//
//  GlobleDefineResp.swift
//  OutLookers
//
//  Created by C on 16/7/27.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class GlobleDefineResp: BaseResponse {
    var result: GlobleDeineAPI!
    
    override init(fromJson json: JSON!) {
        super.init(fromJson: json)
        if json == nil{
            return
        }
        let r = json["result"]
        if r != JSON.null {
            result = GlobleDeineAPI(fromJson: r)
        }
    }
}

class GlobleDeineAPI {
    var citiesUrl : String!
    var citiesUrlVersion : String!
    var imageUrlPrefix : String!
    var videoUrlPrefix : String!
    
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        citiesUrl = json["citiesUrl"].stringValue
        citiesUrlVersion = json["citiesUrlVersion"].stringValue
        imageUrlPrefix = json["imageUrlPrefix"].stringValue
        videoUrlPrefix = json["videoUrlPrefix"].stringValue
    }
}