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
    func get(url: String) -> Void {
        Alamofire.request(.GET, url).responseJSON { (response) in
            
        }
    }
    
    class func post(url: String, parameters: [String:AnyObject]?, complete:Success, fail: Failure) {
        LogDebug("url = \(url)")
        Alamofire.request(.POST, url, parameters: parameters, encoding: .JSON, headers: nil).responseJSON { (response) in
            switch response.result {
            case .Success(let Value):
                LogDebug(JSON(Value))
                complete(response: JSON(Value))
            case .Failure(let Error):
                fail(error: Error)
            }
        }
    }
}