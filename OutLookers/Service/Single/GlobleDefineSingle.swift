//
//  GlobleDefineSingle.swift
//  OutLookers
//
//  Created by C on 16/7/27.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import Device

private let sharedGloble = GlobleDefineSingle()
class GlobleDefineSingle: NSObject {
    class var sharedInstance: GlobleDefineSingle {
        return sharedGloble
    }
    
    var imagePath: String!
    var vedioPath: String!
    var citiesUrl: String!
    var version: String!
    var videoSnapshotPrefix: String!
    var deviceId: String!
    var currentTime: String?
    /// 获取系统 “iPhone, 5S, 9.4.3”
    var deviceDesc: String {
        get {
            
            return "iPhone," + MyDevice.getSystemType() + "," + MyDevice.getSystemVersion()
        }
    }
}

class MyDevice {
    /// 获取系统版本
    static func getSystemVersion() -> String {
        return UIDevice.currentDevice().systemVersion
    }
    
    static func getSystemType() -> String {
        if Device.version().rawValue.hasPrefix("iPhone") {
           return (Device.version().rawValue as NSString).substringFromIndex("iPhone".characters.count)
        } else if Device.version().rawValue.hasPrefix("iPad") {
            return (Device.version().rawValue as NSString).substringFromIndex("iPad".characters.count)
        } else if Device.version().rawValue.hasPrefix("iPodTouch") {
            return (Device.version().rawValue as NSString).substringFromIndex("iPodTouch".characters.count)
        } else {
            return "无法获取"
        }
    }
}