//
//  HttpTool.swift
//  OutLookers
//
//  Created by Youngkook on 16/6/15.
//  Copyright © 2016年 youngkook. All rights reserved.
//

import Foundation
import Alamofire

public class Server {
    func get(url: String) -> Void {
        Alamofire.request(.GET, url).responseJSON { (response) in
            
        }
    }
    
    class func post(url: String, parameters: [String:AnyObject]?, complete:()->Void) -> Void {
        Alamofire.request(.POST, url, parameters: parameters, encoding: .JSON, headers: nil).responseJSON { (response) in
            switch response.result {
            case .Success(let Value):
                print("\(Value)")
            case .Failure(let Error):
                print("\(Error)")
            }
        }
    }
}