//
//  Server.swift
//  OutLookers
//
//  Created by C on 16/7/2.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

class Server {
    
    /// 发布通告
    class func getReleaseNotice(request: ReleaseNoticeRequest, handler: (success: Bool, msg: String?, value: String?)->Void) {
        let parameters = [
            "userId" : request.userId,
            "theme" : request.theme,
            "recruitment" : request.recruitment,
            "startTime" : request.startTime,
            "endTime" : request.endTime,
            "register" : request.register,
            "city" : request.city,
            "adds" : request.adds ?? "",
            "details" : request.details,
            "picture" : request.picture
        ]
        LogDebug(parameters)
        HttpTool.post(API.releaseNotice, parameters: parameters, complete: { (response) in
            let info = StringResponse(fromJson: response)
            if info.success == true {
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg, value: nil)
            }
            }) { (error) in
                handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }
    /// 发现-通告列表
    class func getFindNoticeList(handler: (success: Bool, msg: String?, value: [FindNoticeList]?)->Void) {
        HttpTool.post(API.findNoticeList, parameters: nil, complete: { (response) in
            let info = FindNoticeList(fromJson: response)
            if info.success == true {
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg, value: nil)
            }
            }) { (error) in
                handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }
}
