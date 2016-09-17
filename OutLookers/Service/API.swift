//
//  API.swift
//  OutLookers
//
//  Created by C on 16/6/15.
//  Copyright © 2016年 youngkook. All rights reserved.
//

import Foundation

let baseURL = "http://api.dev.chunyangapp.com"

struct API {
    static let report = baseURL + "/api/authentication/v1/report/create"
    /// 判断昵称是否存在
    static let isNicknameExists = baseURL + "/api/login/v1/isNicknameExists"
    /// 判断手机号是否存在
    static let isPhoneExists = baseURL + "/api/login/v1/isPhoneExists"
    /// 绑定第三方
    static let bingAccount = baseURL + "/api/login/v1/bind"
    /// 查看账号绑定状态
    static let checkBing = baseURL + "/api/login/v1/checkBind"
    /// 他的粉丝
    static let hFans = baseURL + "/api/authentication/v1/follow/others"
    /// 他的关注
    static let hFollows = baseURL + "/api/authentication/v1/followOthers/select"
    /// 关注已读
    static let releaseFollowRead = baseURL + "/api/release/v1/follow/read"
    /// 评论已读
    static let releaseReplyRead = baseURL + "/api/release/v1/reply/read"
    /// 点赞已读
    static let releaseLikeRead = baseURL + "/api/release/v1/like/read"
    /// 获取消息数量
    static let getMessageNum = baseURL + "/api/release/v1/num/get"
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
    static let getVerifyCode = baseURL + "/api/login/v1/code"
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
    /// 点赞
    static let like = baseURL + "/api/release/v1/like/create"
    /// 取消点赞 
    static let cancelLike = baseURL + "/api/release/v1/like/delete"
    /// 点赞列表
    static let likeList = baseURL + "/api/release/v1/likeList/get"
    /// 发表评论
    static let replyComment = baseURL + "/api/release/v1/reply/create"
    /// 评论列表
    static let commentList = baseURL + "/api/release/v1/replyList/get"
    /// 获取个人动态，关注，粉丝数量
    static let getDynamicFollowFansCount = baseURL + "/api/authentication/v1/content/get"
    /// 是否点赞
    static let isLike = baseURL + "/api/release/v1/isLike/get"
    /// 机构个人信息
    static let organizationInformation = baseURL + "/api/authentication/v1/agency/get"
    /// 修改机构信息
    static let modifyOrganization = baseURL + "/api/authentication/v1/agency/update"
    /// 全局常量
    static let globleDefine = baseURL + "/api/system/v1/constants"
    /// token
    static let getToken = baseURL + "/api/file/v1/getAppToken"
    /// 获取视频截图列表
    static let getSnapshots = baseURL + "/api/file/v1/getSnapshots"
    /// 意见反馈
    static let feedback = baseURL + "/api/authentication/v1/feedback/create"
    /// 才艺列表（4张图）
    static let talentListFourPic = baseURL + "/api/release/v1/userTalent/get"
    /// banner
    static let banner = baseURL + "/api/authentication/v1/banner/get"
    /// 手机号注册
    static let registerPhone = baseURL + "/api/login/v1/register"
    /// 完善用户信息
    static let perfectInformation = baseURL + "/api/login/v1/userinfo"
    /// 手机号登录
    static let phoneLogin = baseURL + "/api/login/v1/login"
    /// 令牌登录 
    static let tokenLogin = baseURL + "/api/login/v1/tokenin"
    /// 停止招募
    static let stopRecruit = baseURL + "/api/release/v1/announcement/stop"
    /// 第三方登录
    static let thirdLogin = baseURL + "/api/login/v1/otherLogin"
}