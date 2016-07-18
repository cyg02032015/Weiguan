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
    
    /// 发送获取验证码
    class func getVerifyCode(request: VerifyRequest, handler: (success: Bool, msg: String?, value: String?)->Void) {
        let parameters = [
            "userPhone" : request.userPhone,
            "userId" : request.userId
        ]
        HttpTool.post(API.getVerifyCode, parameters: parameters, complete: { (response) in
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
    
    /// 编辑资料-个人特色-个人特征
    class func getPersonCharacter(handler:(success: Bool, msg: String?, value: [PersonCharacter]?)->Void) {
        HttpTool.post(API.personCharacter, parameters: nil, complete: { (response) in
            let info = PersonCharacter(fromJson: response)
            if info.success == true {
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg, value: nil)
            }
            }) { (error) in
                handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }
    
    /// 机构认证
    class func organizationAuth(request: OrganizeRequest, handler: (success: Bool, msg: String?, value: String?)->Void) {
        let parameters = [
            "userId":request.userId,
            "type":request.type,
            "name":request.name,
            "license":request.license,
            "adds":request.adds,
            "linkman":request.linkman,
            "phone":request.phone,
            "photo":request.photo
        ]
        HttpTool.post(API.organizationAuth, parameters: parameters, complete: { (response) in
            let info = StringResponse(fromJson: response)
            if info.success == true {
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg!, value: nil)
            }
            }) { (error) in
                handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }
    
    /// 是否认证
    class func isAuth(request: BaseRequest, handler: (success: Bool, msg: String?, value: IsAuthResp?)->Void) {
        let parameters = ["userId":request.userId]
        HttpTool.post(API.isAuth, parameters: parameters, complete: { (response) in
            let info = IsAuthResp(fromJson: response)
            if info.success == true {
                handler(success: true, msg: nil, value: info)
            } else {
                handler(success: false, msg: info.msg!, value: nil)
            }
            }) { (error) in
                handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }
    
    /// 变更角色-删除原有认证
    class func modifyAuth(request: BaseRequest, handler: (success: Bool, msg: String?, value: String?)->Void) {
        let parameters = ["userId":request.userId]
        HttpTool.post(API.authDelete, parameters: parameters, complete: { (response) in
            let info = StringResponse(fromJson: response)
            if info.success == true {
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg!, value: nil)
            }
        }) { (error) in
            handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }
}
