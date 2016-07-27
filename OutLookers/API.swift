//
//  API.swift
//  OutLookers
//
//  Created by C on 16/6/15.
//  Copyright © 2016年 youngkook. All rights reserved.
//

import Foundation

let baseURL = "http://60.205.15.7"

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
    static let personCharacter = baseURL + "/api/personal/v1/features/select"
    /// 创建资料-个人档案
    static let editProfilePersonDocument = baseURL + "/api/personal/v1/archives/create"
    /// 是否绑定手机号
    static let isBindPhone = baseURL + "/api/personal/v1/mobile/whether"
    /// 手机号绑定
    static let phoneBind = baseURL + "/api/personal/v1/mobile/binding"
    /// 发送获取验证码
    static let getVerifyCode = baseURL + "/api/personal/v1/mobile/verify"
    /// 个人档案-查看
    static let showPersonFiles = baseURL + "/api/personal/v1/archives/select"
    /// 变更角色-删除原有认证
    static let authDelete = baseURL + "/api/authentication/v1/identity/delete"
    /// 机构认证
    static let organizationAuth = baseURL + "/api/authentication/v1/identity/agency"
    /// 是否认证
    static let isAuth = baseURL + "/api/authentication/v1/identity/isbinding"
    /// 粉丝认证
    static let fansAuth = baseURL + "/api/authentication/v1/identity/fans"
    /// 红人认证
    static let hotmanAuth = baseURL + "/api/authentication/v1/identity/reds"
    /// 红人认证资格显示
    static let hotmanAuthShow = baseURL + "/api/authentication/v1/identity/qualification"
    /// 提交报名-获取用户才艺
    static let commitEnrollGetUserTalent = baseURL + "/api/release/v1/registration/talent"
    /// 提交报名
    static let commitEnroll = baseURL + "/api/release/v1/announcement/register"
    /// 通告-报名人员
    static let circularEnrollPerson = baseURL + "/api/release/v1/announcement/user"
    /// 取消关注
    static let cancelFollow = baseURL + "/api/release/v1/follow/delete"
    /// 参与的通告
    static let participateCircular = baseURL + "/api/release/v1/announcement/participation"
    /// 我的关注
    static let myFollow = baseURL + "/api/authentication/v1/follow/users"
    /// 我的粉丝
    static let myFans = baseURL + "/api/authentication/v1/fans/users"
    /// 获取图片，视频地址
    static let getPicAndVideoURL = baseURL + "/api/release/v1/photo/get"
    /// 获取用户头像昵称
    static let getUserAvatarAndName = baseURL + "/api/release/v1/material/get"
    /// 添加作品集
    static let addworks = baseURL + "/api/release/v1/works/create"
    /// 获取作品集
    static let getworks = baseURL + "/api/release/v1/works/select"
    /// 通告-招募信息
    static let circularRecruitInformation = baseURL + "/api/release/v1/recruitment/list"
    /// 用户与用户是否是关注状态
    static let isFollowStatus = baseURL + "/api/authentication/v1/follow/each"
    /// 编辑资料
    static let informationUpdate = baseURL + "/api/authentication/v1/information/update"
    /// 查看基本资料
    static let informationGet = baseURL + "/api/authentication/v1/information/get"
    /// 首页-推荐红人
    static let recommentHotman = baseURL + "/api/authentication/v1/recommendRed/get"
    /// 全局常量
    static let globleDefine = baseURL + "/api/system/v1/constants"
    /// token
    static let getToken = baseURL + "/api/file/v1/getAppToken"
}