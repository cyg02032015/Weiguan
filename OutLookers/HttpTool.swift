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
    
    func post(url: String, parameters: [String:AnyObject]?, complete:()->Void) -> Void {
        Alamofire.request(.POST, url, parameters: parameters, encoding: .JSON, headers: nil).responseJSON { (response) in
            if let data = response.result.value {
                
            } else {
                
            }
        }
    }
}