//
//  Server+EX.swift
//  OutLookers
//
//  Created by 宋碧海 on 16/9/7.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

extension Server {
    //获取个人基本资料
    class func getInformation(userId: String, handler: (success: Bool, msg: String?, value: PersonalData?) -> Void) {
        let parameters = [
            "userId" : userId
        ]
        HttpTool.post(API.informationGet, parameters: parameters, complete: { (response) in
                let info = PersonalDataReq(fromJson: response)
                if info.success == true {
                    handler(success: true, msg: nil, value: info.result)
                } else {
                    handler(success: false, msg: info.msg, value: nil)
                }
            }) { (error) in
               handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }
    
    class func isFollowStatus(userId: String, followUserId: String, handler: (success: Bool, msg: String?, value: PersonalData?) -> Void) {
        let parameters = [
            "userId" : userId,
            "followUserId" : followUserId
        ]
        HttpTool.post(API.isFollowStatus, parameters: parameters, complete: { (response) in
            
            }) { (error) in
                
        }
    }
}
