//
//  YGCityData.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/28.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class YGCityData: NSObject, NSCoding {
    
    var data: NSData!
    
    init(data: NSData) {
        super.init()
        self.data = data
    }
    // 将对象写入到文件中
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(data, forKey: "cityData")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        self.data = aDecoder.decodeObjectForKey("cityData") as! NSData
    }
    
    func saveCityData() {
        let path = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true).last!
        let filePath = (path as NSString).stringByAppendingPathComponent("city.data")
        print("filePath \(filePath)")
        NSKeyedArchiver.archiveRootObject(data, toFile: filePath)
    }
    
    class func loadCityData() -> CityResp! {
        let path = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true).last!
        let filePath = (path as NSString).stringByAppendingPathComponent("city.data")
        print("filePath \(filePath)")
        let d =  NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as! NSData
        let json = JSON(data: d)
        let cityResp = CityResp(fromJson: json)
        return cityResp
    }
}

class YGCityVersion: NSObject, NSCoding {
    
    var version: String!
    
    init(version: String) {
        super.init()
        self.version = version
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(version, forKey: "version")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        self.version = aDecoder.decodeObjectForKey("version") as! String
    }
    
    func saveCityVersion() {
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!
        let filePath = (path as NSString).stringByAppendingPathComponent("city.version")
        print("filePath \(filePath)")
        NSKeyedArchiver.archiveRootObject(version, toFile: filePath)
    }
    
    class func loadCityVersion() -> String? {
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!
        let filePath = (path as NSString).stringByAppendingPathComponent("city.version")
        print("filePath \(filePath)")
        let version =  NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as? String ?? ""
        return version
    }
}