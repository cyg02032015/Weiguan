//
//  API.swift
//  OutLookers
//
//  Created by C on 16/6/15.
//  Copyright © 2016年 youngkook. All rights reserved.
//

import Foundation

let baseURL = "http://139.129.106.27"

struct API {
    /// 发布图片视频
    static let releasePicVideo = baseURL + "/api/release/v1/dynamic/create"
    /// 查询才艺
    static let queryArtist = baseURL + "/api/release/v1/talent/select"
    /// 发布才艺
    static let releaseTalent = baseURL + "/api/release/v1/talent/create"
    /// 发布才艺-类型选择
    static let releaseTalentTypeSelect = baseURL + "/api/release/v1/talent/details"
    /// 编辑通告-招募需求
    static let editNoticeRecruitNeeds = baseURL + "/api/release/v1/recruitment/create"
    /// 发布通告
    static let releaseNotice = baseURL + "/api/release/v1/announcement/create"
    /// 动态详情
    static let dynamicDetail = baseURL + "/api/release/v1/dynamic/details"
    /// 动态删除
    static let dynamicDelete = baseURL + "/api/release/v1/dynamic/delete"
    /// 动态列表
    static let dynamicList = baseURL + "/api/release/v1/dynamic/list"
    /// 才艺列表
    static let talentList = baseURL + "/api/release/v1/talent/list"
    /// 才艺详情
    static let talentDetail = baseURL + "/api/release/v1/talent/detail"
    /// 才艺删除
    static let talentDelete = baseURL + "/api/release/v1/talent/delete"
    /// 关注
    static let follow = baseURL + "/api/release/v1/follow/create"
    /// 关注-动态
    static let followDynamic = baseURL + "/api/release/v1/followTalent/list"
    /// 发现-通告列表
    static let findNoticeList = baseURL + "/api/release/v1/announcement/list"
    /// 发现-通告详情
    static let findNoticeDetail = baseURL + "/api/release/v1/announcement/detail"
    /// 发现-红人
    static let findHotman = baseURL + "/api/release/v1/user/get"
    /// 编辑资料-个人特色-个人特征
    static let editProfile = baseURL + "/api/release/v1/features/select"
    /// 编辑资料-个人档案
    static let editProfilePersonDocument = baseURL + "/api/release/v1/archives/"
    /// 发送获取验证码
    static let getVerifyCode = baseURL + "/api/personal/v1/mobile/verify"
}