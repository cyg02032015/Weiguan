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
    
    class func post(url: String, parameters: [String:AnyObject]?, complete:Success, fail: Failure) {
        tokenLogin(success: nil, failure: {
            KeyChainSingle.sharedInstance.logOut()
        })
        var headers: [String:String]?
        if let cookiePath = KeyChainSingle.sharedInstance.keychain[kCookiePath], cookie = KeyChainSingle.sharedInstance.keychain[kCookie] {
            headers = [
                "X-X-M" : Util.getCurrentTimestamp(),
                "X-X-D" : globleSingle.deviceId,
                "X-X-T" : cookie,
                "Cookie" : cookiePath
            ]
            LogInfo("请求中的headers = \(headers)")
        } else {
            LogError("cookie is nil")
        }
        alamofireManager.request(.POST, url, parameters: parameters, encoding: .JSON, headers: headers).responseJSON { (response) in
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
    
    class func registerLogPost(url: String, parameters: [String: AnyObject]?, pwdOrToken: String , complete: LogRegSuccess, fail: Failure) {
        let headers: [String : String] = [
            "X-X-M": Util.getCurrentTimestamp(),
            "X-X-D": globleSingle.deviceId,
            "X-X-A": Util.getXXA(pwdOrToken)
        ]
        alamofireManager.request(.POST, url, parameters: parameters, encoding: .JSON, headers: headers).responseJSON { (response) in
            LogVerbose("url = \(url)")
            if let p = parameters {
                LogWarn("parameters = \(p)")
            }
            switch response.result {
            case .Success(let Value):
                LogDebug("response = \(JSON(Value))")
                complete(request: response.request,response: response.response, value: JSON(Value))
            case .Failure(let Error):
                fail(error: Error)
            }
        }

    }
}