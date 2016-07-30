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
        alamofireManager.request(.POST, url, parameters: parameters, encoding: .JSON, headers: nil).responseJSON { (response) in
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