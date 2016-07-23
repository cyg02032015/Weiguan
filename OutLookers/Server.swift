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
    /// 发布图片、视频接口
    class func releasePicAndVideo(request: ReleasePicAndVideoReq, handler: (success: Bool, msg: String?, value: String?)->Void) {
        let parameters = [
            "userId" : UserSingleton.sharedInstance.userId,
            "text" : request.text ?? "",
            "cover" : request.cover,
            "talent" : request.talent ?? "",
            "isVideo" : request.isVideo,
            "picture" : request.picture
        ]
        HttpTool.post(API.releasePicVideo, parameters: parameters, complete: { (response) in
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
    
    /// 查询才艺接口
    class func searchTalent(handler: (success: Bool, msg: String?, value: [SearchTalent]?)->Void) {
        let parameters = [
            "userId" : UserSingleton.sharedInstance.userId
        ]
        HttpTool.post(API.queryArtist, parameters: parameters, complete: { (response) in
            let info = SearchTalent(fromJson: response)
            if info.success == true {
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg, value: nil)
            }
        }) { (error) in
            handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }
    
    /// 发布才艺
    class func releaseTalent(request: ReleaseTalentReq, handler: (success: Bool, msg: String?, value: String?)->Void) {
        let parameters = [
            "userId" : UserSingleton.sharedInstance.userId,
            "name" : request.name,
            "categoryId" : request.categoryId,
            "categoryName" : request.categoryName,
            "details" : request.details,
            "unit" : request.unit,
            "city" : request.city ?? "",
            "worksCover" : request.worksCover ?? "",
            "worksVideo" : request.worksVideo ?? "",
            "worksPicture" : request.worksPicture ?? "",
            "videoText": request.videoText ?? "",
            "pictureText": request.pictureText ?? "",
            "price" : request.price
            ]
        HttpTool.post(API.releaseTalent, parameters: parameters, complete: { (response) in
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
    
    /// 发布才艺-类型选择
    class func releaseTalentSelectType(handler: (success: Bool, msg: String?, value: [ReleaseTalentSelectType]?)->Void) {
        HttpTool.post(API.releaseTalentTypeSelect, parameters: nil, complete: { (response) in
            let info = ReleaseTalentSelectType(fromJson: response)
            if info.success == true {
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg, value: nil)
            }
        }) { (error) in
            handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }
    
    /// 编辑通告-招募需求
    class func editNoticeRecruitNeeds(request: EditCircularRecruitReq, handler: (success: Bool, msg: String?, value: EditCircularRecruitResp?)->Void) {
        let parameters = [
            "userId" : UserSingleton.sharedInstance.userId,
            "categoryId" : request.categoryId,
            "categoryName" : request.categoryName,
            "number" : request.number,
            "unit" : request.unit,
            "price" : request.price
            ]
        HttpTool.post(API.editNoticeRecruitNeeds, parameters: parameters, complete: { (response) in
            let info = EditCircularRecruitResp(fromJson: response)
            if info.success == true {
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg, value: nil)
            }
        }) { (error) in
            handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }
    
    /// 发布通告
    class func getReleaseNotice(request: ReleaseNoticeRequest, handler: (success: Bool, msg: String?, value: String?)->Void) {
        let parameters = [
            "userId" : UserSingleton.sharedInstance.userId,
            "theme" : request.theme,
            "recruitment" : request.recruitment,
            "startTime" : request.startTime,
            "endTime" : request.endTime,
            "register" : request.register,
            "city" : request.city,
            "adds" : request.adds ?? "",
            "details" : request.details,
            "picture" : request.picture,
            "cover" : request.cover
        ]
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
    
    /// 动态详情
    class func dynamicDetail(id: String, handler: (success: Bool, msg: String?, value: DynamicDetailResp?)->Void) {
        let parameters = ["id" : id]
        HttpTool.post(API.dynamicDetail, parameters: parameters, complete: { (response) in
            let info = DynamicDetailResp(fromJson: response)
            if info.success == true {
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg, value: nil)
            }
        }) { (error) in
            handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }
    
    /// 动态删除
    class func deleteDynamic(id: String, handler: (success: Bool, msg: String?, value: String?)->Void) {
        let parameters = ["id" : id]
        HttpTool.post(API.dynamicDelete, parameters: parameters, complete: { (response) in
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
    
    /// 动态列表
    class func dynamicList(pageNo: Int, state: Int, userId: String, isPerson: Bool, handler: (success: Bool, msg: String?, value: DynamicListResp?)->Void) {
        var parameters = [
            "pageNo" : "\(pageNo)",
            "pageSize" : "10",
            "state" : "\(state)",
            ]
        if isPerson {
            parameters["userId"] = UserSingleton.sharedInstance.userId
        }
        HttpTool.post(API.dynamicList, parameters: parameters, complete: { (response) in
            let info = DynamicListResp(fromJson: response)
            if info.success == true {
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg, value: nil)
            }
        }) { (error) in
            handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }
    
    /// 才艺列表
    
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
