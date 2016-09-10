//
//  CityResp.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/28.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class CityResp {
    var province : [Province]!
    
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        province = [Province]()
        let dataArray = json["data"].arrayValue
        for dataJson in dataArray{
            let value = Province(fromJson: dataJson)
            province.append(value)
        }
    }
}

class Province {
    var citys: [City]!
    var id : Int!
    var name : String!
    var sort : Int!
    
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        citys = [City]()
        let childArray = json["child"].arrayValue
        for childJson in childArray{
            let value = City(fromJson: childJson)
            citys.append(value)
        }
        id = json["id"].intValue
        name = json["name"].stringValue
        sort = json["sort"].intValue
    }
}

class City {
    var id : Int!
    var name : String!
    var sort : Int!
    
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        id = json["id"].intValue
        name = json["name"].stringValue
        sort = json["sort"].intValue
    }
}

//class Data{
//    
//    var child : [Data]!
//    var id : Int!
//    var name : String!
//    var sort : Int!
//    
//    init(fromJson json: JSON!){
//        if json == nil{
//            return
//        }
//        child = [Data]()
//        let childArray = json["child"].arrayValue
//        for childJson in childArray{
//            child.append(childJson.stringValue)
//        }
//        id = json["id"].intValue
//        name = json["name"].stringValue
//        sort = json["sort"].intValue
//    }
//}