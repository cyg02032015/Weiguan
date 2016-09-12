//
//  HttpTool.swift
//  OutLookers
//
//  Created by Youngkook on 16/6/15.
//  Copyright © 2016年 youngkook. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


public class HttpTool {
    
    typealias Success = (response: JSON) -> ()
    typealias LogRegSuccess = (request: NSURLRequest?,response: NSHTTPURLResponse?, value: JSON) -> Void
    typealias Failure = (error: NSError) -> ()
    static var manager: Manager!
    static let alamofireManager: Manager = {
        if manager != nil {
            return manager
        } else {
            let config = NSURLSessionConfiguration.defaultSessionConfiguration()
            config.timeoutIntervalForRequest = 10
            let manager = Alamofire.Manager(configuration: config)
            return manager
        }
    }()
    
    func get(url: String) -> Void {
        Alamofire.request(.GET, url).responseJSON { (response) in
            
        }
    }
    
    
    class func post(url: String, parameters: [String: AnyObject]?, complete:Success, fail: Failure) {
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        let group = dispatch_group_create()
            dispatch_group_async(group, queue) {
                dispatch_group_enter(group)
                tokenLogin(success: { 
                    dispatch_group_leave(group)
                    }, failure: { 
                        dispatch_group_leave(group)
                        LogInHelper.logout()
                        TokenTool.removeCookies()
                })
        }
        
        dispatch_group_notify(group, queue) {
            var headers: [String:String]?
            if let cookiePath = KeyChainSingle.sharedInstance.keychain[kCookiePath], cookie = KeyChainSingle.sharedInstance.keychain[kCookie] {
                headers = [
                    "X-X-M" : Util.getCurrentTimestamp(),
                    "X-X-D" : globleSingle.deviceId,
                    "X-X-T" : cookie,
                    "Cookie" : cookiePath
                ]
                LogInfo("请求中的headers = \(headers)")
            }
            alamofireManager.request(.POST, url, parameters: parameters, encoding: .JSON, headers: headers).responseJSON { (response) in
                globleSingle.currentTime = nil
                LogVerbose("url = \(url)")
                if let p = parameters {
                    LogWarn("parameters = \(p)")
                }
                switch response.result {
                case .Success(let Value):
                    LogDebug("response = \(JSON(Value))")
                    complete(response: JSON(Value))
                case .Failure(let Error):
                    fail(error: Error)
                }
            }
        }

    }
    
    /// 专门用在登录注册以及忘记密码等等
    class func registerLogPost(url: String, parameters: [String: AnyObject]?, pwdOrToken: String , complete: LogRegSuccess, fail: Failure) {
        TokenTool.removeCookies()
        let headers: [String : String] = [
            "X-X-M": Util.getCurrentTimestamp(),
            "X-X-D": globleSingle.deviceId,
            "X-X-A": Util.getXXA(pwdOrToken)
        ]
        var realParameters = [String: AnyObject]()
        for (key, value) in parameters! {
            realParameters[key] = value
        }
        realParameters["deviceDesc"] = globleSingle.deviceDesc
        realParameters["appVersion"] = Int(appBuild())
        realParameters["appVersionName"] = appVersion()
        LogDebug("login headers = \(headers)")
        alamofireManager.request(.POST, url, parameters: realParameters, encoding: .JSON, headers: headers).responseJSON { (response) in
            globleSingle.currentTime = nil
            LogVerbose("url = \(url)")
            LogWarn("parameters = \(realParameters)")
            switch response.result {
            case .Success(let Value):
                LogDebug("response = \(JSON(Value))")
                complete(request: response.request,response: response.response, value: JSON(Value))
            case .Failure(let Error):
                fail(error: Error)
            }
        }
    }
    
//    class func deviceDesc() -> String {
        //        let infoDictionary = NSBundle.mainBundle().infoDictionary
        //        let appDisplayName: String? = infoDictionary?["CFBundleDisplayName"] as! String
        //        let majorVersion: String? = infoDictionary? ["CFBundleShortVersionString"] as! String//主程序版本号
        //        let minorVersion: String? = infoDictionary? [kCFBundleVersionKey as String] as! String//版本号（内部标示）
        //设备信息
//        let appVersion : String = UIDevice.currentDevice().systemVersion //ios版本
        //        let identifierNumber = UIDevice.currentDevice().identifierForVendor //设备udid
//        let systemName = UIDevice.currentDevice().systemName //系统名称
        //let model = UIDevice.currentDevice().model //设备型号
        //let localizedModel = UIDevice.currentDevice().localizedModel //设备区域化型号如A1533
//        return systemName + appVersion
//    }
    
    class func appVersion() -> String {
        return NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as! String
    }
    
    class func appBuild() -> String {
        return NSBundle.mainBundle().objectForInfoDictionaryKey(kCFBundleVersionKey as String) as! String
    }
    
//    class func versionBuild() -> String {
//        let version = appVersion(), build = appBuild()
//        
//        return version == build ? "\(version)" : "\(version)(\(build))"
//    }
}