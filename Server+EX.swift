//
//  Server+EX.swift
//  OutLookers
//
//  Created by 宋碧海 on 16/9/7.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

extension Server {
    //获取消息数量
    class func getMessageNum(userId: String = UserSingleton.sharedInstance.userId, handler: (success: Bool, msg: String?, value: MessageNumData?) -> Void) {
        let parameters = [
            "userId" : userId
        ]
        HttpTool.post(API.informationGet, parameters: parameters, complete: { (response) in
            let info = MessageNumDataReq(fromJson: response)
            if info.success == true {
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg, value: nil)
            }
        }) { (error) in
            handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }
    
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
    
    //是否认证
    class func isAuth(userId: String, user: String, handler: (success: Bool, msg: String?, value: IsAuthData?) -> Void) {
        let parameters = [
            "userId" : userId,
            "user" : user
        ]
        HttpTool.post(API.isAuth, parameters: parameters, complete: { (response) in
            let info = IsAuthDataReq(fromJson: response)
            if info.success == true {
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg, value: nil)
            }
            }) { (error) in
                handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }
    
    //是否关注
    class func isFollowStatus(userId: String, followUserId: String, handler: (success: Bool, msg: String?, value: IsFollowData?) -> Void) {
        let parameters = [
            "userId" : userId,
            "followUserId" : followUserId
        ]
        HttpTool.post(API.isFollowStatus, parameters: parameters, complete: { (response) in
            let info = IsFollowDataReq(fromJson: response)
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
