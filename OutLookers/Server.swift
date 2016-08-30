//
//  Server.swift
//  OutLookers
//
//  Created by C on 16/7/2.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

let pageSize = 10

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
        LogWarn("parameters = \(parameters)")
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
    class func searchTalent(handler: (success: Bool, msg: String?, value: [SearchTalentList]?)->Void) {
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
        LogError(parameters)
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
    class func releaseTalentSelectType(handler: (success: Bool, msg: String?, value: [TalentSelectTypeList]?)->Void) {
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
            "unit" : request.unit ?? "",
            "price" : request.price ?? ""
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
    class func dynamicList(pageNo: Int,user: String ,state: Int, isPerson: Bool, isHome: Bool, isSquare: Bool, handler: (success: Bool, msg: String?, value: DynamicListResp?)->Void) {
        var parameters = [
            "pageNo" : "\(pageNo)",
            "pageSize" : "\(pageSize)",
            "state" : "\(state)",
            "user" : user
            ]
        if pageNo == 1 {
            parameters["time"] = NSDate().stringFromNowDate()
        }
        if isPerson {
            parameters["userId"] = UserSingleton.sharedInstance.userId
        }
        if isHome {
            parameters["isRecommend"] = "1"
        }
        if isSquare {
            parameters["square"] = "1"
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
    class func talentList(pageNo: Int, state: Int, handler: (success: Bool, msg: String?, value: TalentListResp?)->Void) {
        let parameters = [
            "userId" : UserSingleton.sharedInstance.userId,
            "pageNo" : "\(pageNo)",
            "pageSize" : "\(pageSize)",
            "state" : "\(state)",
            "time" : NSDate().stringFromNowDate()
            ]
        HttpTool.post(API.talentList, parameters: parameters, complete: { (response) in
            let info = TalentListResp(fromJson: response)
            if info.success == true {
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg, value: nil)
            }
        }) { (error) in
            handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }
    
    /// 才艺详情
    class func talentDetail(id: String, handler: (success: Bool, msg: String?, value: TalentDtailResp?)->Void) {
        let parameters = ["id" : id]
        HttpTool.post(API.talentDetail, parameters: parameters, complete: { (response) in
            let info = TalentDtailResp(fromJson: response)
            if info.success == true {
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg, value: nil)
            }
        }) { (error) in
            handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }
    
    /// 才艺删除
    class func deleteTalent(id: String, handler: (success: Bool, msg: String?, value: String?)->Void) {
        let parameters = ["id" : id]
        HttpTool.post(API.talentDelete, parameters: parameters, complete: { (response) in
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
    
    /// 关注
    class func followUser(followUserId: String, handler: (success: Bool, msg: String?, value: String?)->Void) {
        let parameters = [
            "followUserId" : followUserId,
            "userId" : UserSingleton.sharedInstance.userId
            ]
        HttpTool.post(API.follow, parameters: parameters, complete: { (response) in
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
    
    /// 关注-动态
    class func followDynamic(pageNo: Int, handler: (success: Bool, msg: String?, value: FollowDynamicResp?)->Void) {
        let parameters = [
            "userId" : UserSingleton.sharedInstance.userId,
            "pageNo" : "\(pageNo)",
            "pageSize" : "\(pageSize)",
        ]
        HttpTool.post(API.followDynamic, parameters: parameters, complete: { (response) in
            let info = FollowDynamicResp(fromJson: response)
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
    class func getFindNoticeList(pageNo: Int, state: Int, isPerson: Bool, handler: (success: Bool, msg: String?, value: FindNoticeListResp?)->Void) {
        var parameters = [
            "pageNo" : "\(pageNo)",
            "pageSize" : "\(pageSize)",
            "state" : "\(state)",
            "time" : NSDate().stringFromNowDate()
            ]
        if isPerson {
            parameters["userId"] = UserSingleton.sharedInstance.userId
        }
        HttpTool.post(API.findNoticeList, parameters: parameters, complete: { (response) in
            let info = FindNoticeListResp(fromJson: response)
            if info.success == true {
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg, value: nil)
            }
            }) { (error) in
                handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }
    
    /// 发现-通告详情
    class func findNoticeDetail(id: String, handler: (success: Bool, msg: String?, value: FindNoticeDetailResp?)->Void) {
        let parameters = ["id" : id]
        HttpTool.post(API.findNoticeDetail, parameters: parameters, complete: { (response) in
            let info = FindNoticeDetailResp(fromJson: response)
            if info.success == true {
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg, value: nil)
            }
        }) { (error) in
            handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }

    /// 发现-红人
    class func findHotman(handler: (success: Bool, msg: String?, value: [FindeHotman]?)->Void) {
        
        HttpTool.post(API.findHotman, parameters: nil, complete: { (response) in
            let info = FindHotmanResp(fromJson: response)
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
    
    /// 创建资料-个人档案
    class func personalFiles(req: PersonFilesReq, handler: (success: Bool, msg: String?, value: String?)->Void) {
        let parameters = [
            "userId" : UserSingleton.sharedInstance.userId,
            "height" : req.height,
            "weight" : req.weight,
            "bust" : req.bust,
            "waist" : req.waist,
            "hipline" : req.hipline,
            "constellation" : req.constellation,
            "characteristics" : req.characteristics,
            "experience" : req.experience
            ]
        HttpTool.post(API.editProfilePersonDocument, parameters: parameters, complete: { (response) in
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
    
    /// 是否绑定手机号
    class func isBindPhone(handler: (success: Bool, msg: String?, value: String?)->Void) {
        let parameters = [
            "userId" : UserSingleton.sharedInstance.userId
        ]
        HttpTool.post(API.isBindPhone, parameters: parameters, complete: { (response) in
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
    
    /// 绑定手机
    class func bindPhone(phone: String,smsCode: String, handler: (success: Bool, msg: String?, value: String?)->Void) {
        let parameters = [
            "userId" : UserSingleton.sharedInstance.userId,
            "userPhone" : phone,
            "smsCode" : smsCode
            ]
        HttpTool.post(API.phoneBind, parameters: parameters, complete: { (response) in
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
    
    /// 发送获取验证码
    class func getVerifyCode(phone: String, handler: (success: Bool, msg: String?, value: String?)->Void) {
        let parameters = [
            "phone" : phone,
            "deviceId": globleSingle.deviceId
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
    
    /// 个人档案-查看
    class func showPersonFiles(handler: (success: Bool, msg: String?, value: PersonFilesResp?)->Void) {
        let parameters = [
            "userId" : UserSingleton.sharedInstance.userId
        ]
        HttpTool.post(API.showPersonFiles, parameters: parameters, complete: { (response) in
            let info = PersonFilesResp(fromJson: response)
            if info.success == true {
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg, value: nil)
            }
        }) { (error) in
            handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }
    
    /// 变更角色-删除原有认证
    class func modifyAuth(handler: (success: Bool, msg: String?, value: String?)->Void) {
        let parameters = ["userId":UserSingleton.sharedInstance.userId]
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
    
    /// 机构认证
    class func organizationAuth(request: OrganizeRequest, handler: (success: Bool, msg: String?, value: String?)->Void) {
        let parameters = [
            "userId":UserSingleton.sharedInstance.userId,
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
    class func isAuth(handler: (success: Bool, msg: String?, value: IsAuthResp?)->Void) {
        let parameters = ["userId":UserSingleton.sharedInstance.userId]
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
    
    /// 粉丝认证
    class func fansAuth(redsId: String,handler: (success: Bool, msg: String?, value: String?)->Void) {
        let parameters = ["userId":UserSingleton.sharedInstance.userId, "redsId":redsId]
        HttpTool.post(API.fansAuth, parameters: parameters, complete: { (response) in
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
    
    /// 红人认证
    class func hotmanAuth(req: HotmanAuthReq, handler: (success: Bool, msg: String?, value: String?)->Void) {
        let parameters = ["userId":UserSingleton.sharedInstance.userId, "photo":req.photo, "name":req.name]
        HttpTool.post(API.hotmanAuth, parameters: parameters, complete: { (response) in
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
    
    /// 红人认证资格显示
    class func hotmanAuthShow(handler: (success: Bool, msg: String?, value: HotmanAuthShowResp?)->Void) {
        let parameters = ["userId":UserSingleton.sharedInstance.userId]
        HttpTool.post(API.hotmanAuthShow, parameters: parameters, complete: { (response) in
            let info = HotmanAuthShowResp(fromJson: response)
            if info.success == true {
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg!, value: nil)
            }
        }) { (error) in
            handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }
    
    /// 提交报名-获取用户才艺
    class func commitEnrollGetUserTalent(handler: (success: Bool, msg: String?, value: [UserTalentList]?)->Void) {
        let parameters = ["userId":UserSingleton.sharedInstance.userId]
        HttpTool.post(API.commitEnrollGetUserTalent, parameters: parameters, complete: { (response) in
            let info = CommitEnrollGetUserTalentResp(fromJson: response)
            if info.success == true {
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg!, value: nil)
            }
        }) { (error) in
            handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }
    
    /// 提交报名
    class func commitEnroll(req: CommitEnrollReq,handler: (success: Bool, msg: String?, value: String?)->Void) {
        let parameters = [
            "announcementId" : req.announcementId,
            "recruitmentId" : req.recruitmentId,
            "recruitmentName" : req.recruitmentName,
            "userId" : UserSingleton.sharedInstance.userId,
            "talentId" : req.talentId
            ]
        HttpTool.post(API.commitEnroll, parameters: parameters, complete: { (response) in
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

    /// 通告-报名人员
    class func circularEnrollPerson(announcementId: String,handler: (success: Bool, msg: String?, value: [EnrollPersonList]?)->Void) {
        let parameters = [
            "announcementId" : announcementId
        ]
        HttpTool.post(API.circularEnrollPerson, parameters: parameters, complete: { (response) in
            let info = CircularEnrollPersonResp(fromJson: response)
            if info.success == true {
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg!, value: nil)
            }
        }) { (error) in
            handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }
    
    /// 取消关注
    class func cancelFollow(followUserId: String, handler: (success: Bool, msg: String?, value: String?)->Void) {
        let parameters = [
            "followUserId" : followUserId,
            "userId" : UserSingleton.sharedInstance.userId
        ]
        HttpTool.post(API.cancelFollow, parameters: parameters, complete: { (response) in
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
    
    /// 参与的通告
    class func participateCircular(pageNo: Int, handler: (success: Bool, msg: String?, value: ParticipateCircularResp?)->Void) {
        let parameters = [
            "pageNo" : "\(pageNo)",
            "pageSize" : "\(pageSize)",
            "userId" : UserSingleton.sharedInstance.userId
            ]
        HttpTool.post(API.participateCircular, parameters: parameters, complete: { (response) in
            let info = ParticipateCircularResp(fromJson: response)
            if info.success == true {
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg, value: nil)
            }
        }) { (error) in
            handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }
    
    /// 我的关注
    class func myFollow(pageNo: Int, handler: (success: Bool, msg: String?, value: MyFollowResp?)->Void) {
        let parameters = [
            "pageNo" : "\(pageNo)",
            "pageSize" : "\(pageSize)",
            "userId" : UserSingleton.sharedInstance.userId
        ]
        HttpTool.post(API.myFollow, parameters: parameters, complete: { (response) in
            let info = MyFollowResp(fromJson: response)
            if info.success == true {
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg, value: nil)
            }
        }) { (error) in
            handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }
    
    /// 我的关注
    class func myFans(pageNo: Int, handler: (success: Bool, msg: String?, value: MyFansResp?)->Void) {
        let parameters = [
            "pageNo" : "\(pageNo)",
            "pageSize" : "\(pageSize)",
            "userId" : UserSingleton.sharedInstance.userId
        ]
        HttpTool.post(API.myFans, parameters: parameters, complete: { (response) in
            let info = MyFansResp(fromJson: response)
            if info.success == true {
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg, value: nil)
            }
        }) { (error) in
            handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }
    
    /// 获取图片，视频地址
    class func getPicAndVideoURL(idList: String, handler: (success: Bool, msg: String?, value: [PicAndVideoList]?)->Void) {
        let parameters = [
            "idList" : idList
        ]
        HttpTool.post(API.getPicAndVideoURL, parameters: parameters, complete: { (response) in
            let info = GetPicAndVideoResp(fromJson: response)
            if info.success == true {
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg, value: nil)
            }
        }) { (error) in
            handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }
    
    /// 获取用户头像昵称
    class func getAvatarAndName(idList: String, handler: (success: Bool, msg: String?, value: [AvatarNameList]?)->Void) {
        let parameters = [
            "idList" : idList
        ]
        HttpTool.post(API.getUserAvatarAndName, parameters: parameters, complete: { (response) in
            let info = AvatarAndNameResp(fromJson: response)
            if info.success == true {
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg, value: nil)
            }
        }) { (error) in
            handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }
    
    /// 添加作品集
    class func addworks(req: AddworksReq, handler: (success: Bool, msg: String?, value: String?)->Void) {
        let parameters = [
            "talentId" : req.talentId,
            "text" : req.text,
            "worksIds" : req.worksIds
            ]
        HttpTool.post(API.addworks, parameters: parameters, complete: { (response) in
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
    
    /// 获取作品集
    class func getWorks(talentId: String, handler: (success: Bool, msg: String?, value: [WorksList]?)->Void) {
        let parameters = [
            "talentId" : talentId
        ]
        HttpTool.post(API.getworks, parameters: parameters, complete: { (response) in
            let info = GetWorksResp(fromJson: response)
            if info.success == true {
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg, value: nil)
            }
        }) { (error) in
            handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }
    
    /// 通告-招募信息
    class func circularRecruitInformation(idList: String, handler: (success: Bool, msg: String?, value: [RecruitInformationList]?)->Void) {
        let parameters = [
            "idList" : idList
        ]
        HttpTool.post(API.circularRecruitInformation, parameters: parameters, complete: { (response) in
            let info = RecruitInformationResp(fromJson: response)
            if info.success == true {
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg, value: nil)
            }
        }) { (error) in
            handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }

    /// 编辑资料
    class func informationUpdate(req: EditDataReq, handler: (success: Bool, msg: String?, value: String?)->Void) {
        let parameters = [
            "id" : UserSingleton.sharedInstance.userId,
            "sex" : req.sex,
            "nickname" : req.nickname,
            "birthday" : req.birthday,
            "province" : req.province,
            "city" : req.city,
            "introduction" : req.introduction,
            "headImgUrl" : req.headImgUrl
            ]
        LogError(parameters)
        HttpTool.post(API.informationUpdate, parameters: parameters, complete: { (response) in
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
    
    /// 查看资料
    class func showInformation(handler: (success: Bool, msg: String?, value: UserData?)->Void) {
        let parameters = [
            "id" : UserSingleton.sharedInstance.userId
        ]
        HttpTool.post(API.informationGet, parameters: parameters, complete: { (response) in
            let info = UserDataResp(fromJson: response)
            if info.success == true {
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg, value: nil)
            }
        }) { (error) in
            handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }
    
    /// 首页推荐红人
    class func homeRecommendHotman(handler: (success: Bool, msg: String?, value: [HotmanList]?)->Void) {
        HttpTool.post(API.recommentHotman, parameters: nil, complete: { (response) in
            let info = RecommendHotmanResp(fromJson: response)
            if info.success == true {
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg, value: nil)
            }
        }) { (error) in
            handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }
    
    /// 点赞
    class func like(dynamicId: String, handler: (success: Bool, msg: String?, value: String?)->Void) {
        let parameters = [
            "userId" : UserSingleton.sharedInstance.userId,
            "dynamicId" : dynamicId
        ]
        HttpTool.post(API.like, parameters: parameters, complete: { (response) in
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
    
    /// 取消点赞
    class func cancelLike(dynamicId: String, handler: (success: Bool, msg: String?, value: String?)->Void) {
        let parameters = [
            "userId" : UserSingleton.sharedInstance.userId,
            "dynamicId" : dynamicId
        ]
        HttpTool.post(API.cancelLike, parameters: parameters, complete: { (response) in
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
    
    /// 点赞列表
    class func likeList(pageNo: Int, dynamicId: String?, handler: (success: Bool, msg: String?, value: LikeListResp?)->Void) {
        let parameters = [
            "userId" : UserSingleton.sharedInstance.userId,
            "dynamicId" : dynamicId ?? "",
            "pageNo" : "\(pageNo)",
            "pageSize" : "\(pageSize)",
            "time" : NSDate().stringFromNowDate()
        ]
        HttpTool.post(API.likeList, parameters: parameters, complete: { (response) in
            let info = LikeListResp(fromJson: response)
            if info.success == true {
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg, value: nil)
            }
        }) { (error) in
            handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }
    
    /// 发表评论
    class func replyComment(req: ReplyCommentReq, handler: (success: Bool, msg: String?, value: String?)->Void) {
        let parameters = [
            "userId" : UserSingleton.sharedInstance.userId,
            "dynamicId" : req.dynamicId,
            "replyId" : req.replyId ?? "0",
            "text" : req.text
        ]
        HttpTool.post(API.replyComment, parameters: parameters, complete: { (response) in
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
    
    /// 评论列表
    class func commentList(pageNo: Int, dynamicId: String?, handler: (success: Bool, msg: String?, value: CommentListResp?)->Void) {
        let parameters = [
            "userId" : UserSingleton.sharedInstance.userId,
            "dynamicId" : dynamicId ?? "",  // 个人信息请求值为0
            "pageNo" : "\(pageNo)",
            "pageSize" : "\(pageSize)"
        ]
        HttpTool.post(API.commentList, parameters: parameters, complete: { (response) in
            let info = CommentListResp(fromJson: response)
            if info.success == true {
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg, value: nil)
            }
        }) { (error) in
            handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }
    
    /// 获取个人动态，关注，粉丝数量
    class func getDynamicFollowFansCount(handler: (success: Bool, msg: String?, value: GetContent?)->Void) {
        let parameters = [
            "userId" : UserSingleton.sharedInstance.userId
        ]
        HttpTool.post(API.getDynamicFollowFansCount, parameters: parameters, complete: { (response) in
            let info = GetContentResp(fromJson: response)
            if info.success == true {
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg, value: nil)
            }
        }) { (error) in
            handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }
    
    /// 是否点赞
    class func isLike(dynamicId: String, handler: (success: Bool, msg: String?, value: String?)->Void) {
        let parameters = [
            "userId" : UserSingleton.sharedInstance.userId,
            "dynamicId" : dynamicId
        ]
        HttpTool.post(API.isLike, parameters: parameters, complete: { (response) in
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
    
    /// 机构个人信息
    class func organizationInformation(handler: (success: Bool, msg: String?, value: OGInfomation?)->Void) {
        let parameters = [
            "userId" : UserSingleton.sharedInstance.userId
        ]
        HttpTool.post(API.organizationInformation, parameters: parameters, complete: { (response) in
            let info = OrganizeInformationResp(fromJson: response)
            if info.success == true {
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg, value: nil)
            }
        }) { (error) in
            handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }
    
    /// 修改机构信息
    class func modifyOrganization(req: ModifyOGReq, handler: (success: Bool, msg: String?, value: String?)->Void) {
        let parameters = [
            "userId" : UserSingleton.sharedInstance.userId,
            "type" : req.type,
            "name" : req.name,
            "adds" : req.adds,
            "introduction" : req.introduction
        ]
        HttpTool.post(API.modifyOrganization, parameters: parameters, complete: { (response) in
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
    
    /// 全局常量
    class func globleDefine(handler: (success: Bool, msg: String?, value: GlobleDeineAPI?)->Void) {
        HttpTool.post(API.globleDefine, parameters: nil, complete: { (response) in
            let info = GlobleDefineResp(fromJson: response)
            if info.success == true {
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg, value: nil)
            }
            }) { (error) in
                handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }

    /// 上传token获取
    class func getUpdateFileToken(type: TokenType, handler: (success: Bool, msg: String?, value: GetToken?)->Void) {
        let parameters = ["type": type.rawValue]
        HttpTool.post(API.getToken, parameters: parameters, complete: { (response) in
            let info = GetTokenResp(fromJson: response)
            if info.success == true {
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg, value: nil)
            }
        }) { (error) in
            handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }
    
    /// 获取视频截图列表
    class func getSanpshots(id: String, handler: (success: Bool, msg: String?, value: [String]?)->Void) {
        let parameters = ["id":id]
        HttpTool.post(API.getSnapshots, parameters: parameters, complete: { (response) in
            let info = SnapshotsResp(fromJson: response)
            if info.success == true {
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg, value: nil)
            }
        }) { (error) in
            handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }
    
    /// 意见反馈
    class func feedback(req: FeedbackReq, handler: (success: Bool, msg: String?, value: String?)->Void) {
        let parameters = [
            "userId" : UserSingleton.sharedInstance.userId,
            "text" : req.text,
            "contact" : req.contact
        ]
        HttpTool.post(API.feedback, parameters: parameters, complete: { (response) in
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
    
    /// 才艺列表（4张图）
    class func talentList4(pageNo: Int, state: Int, user: String, handler: (success: Bool, msg: String?, value: [Result]?)->Void) {
        var parameters = [
            "pageNo" : "\(pageNo)",
            "pageSize" : "\(pageSize)",
            "state" : "\(state)",
            "userId" : user,
        ]
        if pageNo == 1 {
            parameters["time"] = NSDate().stringFromNowDate()
        }
        HttpTool.post(API.talentListFourPic, parameters: parameters, complete: { (response) in
            let info = TalentList4Resp(fromJson: response)
            if info.success == true {
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg, value: nil)
            }
        }) { (error) in
            handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }
    
    /// banner
    class func banner(handler: (success: Bool, msg: String?, value: [BannerList]?)->Void) {
        HttpTool.post(API.banner, parameters: nil, complete: { (response) in
            let info = BannerResp(fromJson: response)
            if info.success == true {
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg, value: nil)
            }
        }) { (error) in
            handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }
    
    /// 手机号注册
    class func registerPhone(phone: String, code: String, pwd: String, handler: (success: Bool, msg: String?, value: RegisterObj?)->Void) {
        let parameters = [
            "phone": phone,
            "deviceId": globleSingle.deviceId,
            "code": code,
            "passWd": pwd
        ]
        HttpTool.registerLogPost(API.registerPhone, parameters: parameters, pwdOrToken: pwd, complete: { (request, response, value) in
            let info = RegisterResp(fromJson: value)
            if info.success == true {
                if let headerFields = response?.allHeaderFields as? [String: String], URL = request?.URL {
                    let cookies = NSHTTPCookie.cookiesWithResponseHeaderFields(headerFields, forURL: URL)
                    TokenTool.saveCookieAndExpired(cookies)
                }
                KeyChainSingle.sharedInstance.saveTokenUserid(info.result)
                UserSingleton.sharedInstance.userId = info.result.userId
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg, value: nil)
            }

        }) { (error) in
            handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }
    
    /// 完善用户信息
    class func perfectInformation(req: PerfectInfomationReq, handler: (success: Bool, msg: String?, value: String?)->Void) {
        let parameters = [
            "userId": UserSingleton.sharedInstance.userId,
            "sex": req.sex,
            "nickname": req.nickname,
            "province": req.province,
            "city": req.city,
            "headImgUrl": req.headImgUrl
        ]
        HttpTool.post(API.perfectInformation, parameters: parameters, complete: { (response) in
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
    
    /// 手机号登录
    class func phoneLogin(phone: String, pwd: String, handler: (success: Bool, msg: String?, value: RegisterObj?)->Void) {
        let parameters = [
            "phone": phone,
            "passWd": pwd,
            "deviceId": globleSingle.deviceId
        ]
        HttpTool.registerLogPost(API.phoneLogin, parameters: parameters, pwdOrToken: pwd, complete: { (request, response, value) in
            let info = RegisterResp(fromJson: value)
            if info.success == true {
                if let headerFields = response?.allHeaderFields as? [String: String], URL = request?.URL {
                    let cookies = NSHTTPCookie.cookiesWithResponseHeaderFields(headerFields, forURL: URL)
                    TokenTool.saveCookieAndExpired(cookies)
                }
                KeyChainSingle.sharedInstance.saveTokenUserid(info.result)
                UserSingleton.sharedInstance.userId = info.result.userId
                UserSingleton.sharedInstance.nickname = info.result.nickname ?? ""
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg, value: nil)
            }
        }) { (error) in
            handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }
    
    /// 令牌登录
    class func tokenLogin(handler: (success: Bool, msg: String?, value: RegisterObj?)->Void) {
        guard let token = KeyChainSingle.sharedInstance.keychain[kToken] else {return}
        let parameters = [
            "token": token,
            "deviceId": globleSingle.deviceId
        ]
        HttpTool.registerLogPost(API.tokenLogin, parameters: parameters, pwdOrToken: token, complete: { (request, response, value) in
            let info = RegisterResp(fromJson: value)
            if info.success == true {
                if let headerFields = response?.allHeaderFields as? [String: String], URL = request?.URL {
                    let cookies = NSHTTPCookie.cookiesWithResponseHeaderFields(headerFields, forURL: URL)
                    TokenTool.saveCookieAndExpired(cookies)
                }
                KeyChainSingle.sharedInstance.keychain[kUserId] = info.result.userId
                UserSingleton.sharedInstance.userId = info.result.userId
                UserSingleton.sharedInstance.nickname = info.result.nickname ?? ""
                handler(success: true, msg: nil, value: info.result)
            } else {
                handler(success: false, msg: info.msg, value: nil)
            }
        }) { (error) in
            handler(success: false, msg: error.localizedDescription, value: nil)
        }
    }

    /// 停止招募
    class func stopRecruit(id: String, handler: (success: Bool, msg: String?, value: String?)->Void) {
        let parameters = [
            "id" : id,
            "userId" : UserSingleton.sharedInstance.userId
        ]
        HttpTool.post(API.stopRecruit, parameters: parameters, complete: { (response) in
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

}
