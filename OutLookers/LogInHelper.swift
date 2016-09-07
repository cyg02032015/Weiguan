//
//  LogInHelper.swift
//  OutLookers
//
//  Created by C on 16/9/5.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class LogInHelper: NSObject {
    // 登录弹框页面跳转
    class func logViewTap(controller: UIViewController, type: LogViewTapType) {
        switch type {
        case .Wechat:
            let snsPlatform = UMSocialSnsPlatformManager.getSocialPlatformWithName(UMShareToWechatSession)
            snsPlatform.loginClickHandler(controller, UMSocialControllerService.defaultControllerService(), true, { response in
                if response.responseCode == UMSResponseCodeSuccess {
                    let dict = UMSocialAccountManager.socialAccountDictionary()
                    let snsAccount = dict[snsPlatform.platformName] as! UMSocialAccountEntity
                    self.serverLogin(2, uid: snsAccount.unionId, openId: snsAccount.openId, nickName: snsAccount.userName, headImgUrl: snsAccount.iconURL, userName: "")
                    
                } else {
                    LogError("微信登录错误 = \(response.message)")
                }
            })
        case .QQ:
            let snsPlatform = UMSocialSnsPlatformManager.getSocialPlatformWithName(UMShareToQQ)
            snsPlatform.loginClickHandler(controller, UMSocialControllerService.defaultControllerService(), true, { response in
                if response.responseCode == UMSResponseCodeSuccess {
                    let dict = UMSocialAccountManager.socialAccountDictionary()
                    let snsAccount = dict[snsPlatform.platformName] as! UMSocialAccountEntity
                    self.serverLogin(3, uid: snsAccount.usid, openId: snsAccount.openId, nickName: snsAccount.userName, headImgUrl: snsAccount.iconURL, userName: "")
                } else {
                    LogError("QQ登录错误 = \(response.message)")
                }
            })
            
        case .Weibo:
            let snsPlatform = UMSocialSnsPlatformManager.getSocialPlatformWithName(UMShareToSina)
            snsPlatform.loginClickHandler(controller, UMSocialControllerService.defaultControllerService(), true, { response in
                if response.responseCode == UMSResponseCodeSuccess {
                    let dict = UMSocialAccountManager.socialAccountDictionary()
                    let snsAccount = dict[snsPlatform.platformName] as! UMSocialAccountEntity
                    self.serverLogin(4, uid: snsAccount.usid, openId: "", nickName: snsAccount.userName, headImgUrl: snsAccount.iconURL, userName: snsAccount.userName)
                } else {
                    LogError("微博登录错误 = \(response.message)")
                }
            })
        case .Phone:
            let vc = LogViewController()
            controller.navigationController?.pushViewController(vc, animated: true)
        case .Iagree: LogInfo("同意协议")
        case .Register:
            let vc = Register1ViewController()
            controller.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    static func deleteUmengThirdAuth(plaformName: String) {
        UMSocialDataService.defaultDataService().requestUnOauthWithType(plaformName, completion: {response in
            LogInfo("response is \(response)")
        })
    }
    
    static func serverLogin(type: Int, uid: String, openId: String, nickName: String, headImgUrl: String, userName: String) {
        var req = ThirdLogReq()
        req.deviceDesc = globleSingle.deviceDesc
        req.deviceId = globleSingle.deviceId
        req.type = type
        req.uid = uid
        req.openId = openId
        req.nickname = nickName
        req.headImgUrl = headImgUrl
        req.userName = userName
        
        Server.thirdLogin(req, handler: { (success, msg, value) in
            if success {
                SVToast.showWithSuccess("登录成功")
                NSNotificationCenter.defaultCenter().postNotificationName(ReloadData, object: nil)
            } else {
                guard let m = msg else {return}
                SVToast.showWithError(m)
            }
        })
    }
    
    /// 点击加号按钮登录方法
    static func login(controller: UIViewController) {
        if UserSingleton.sharedInstance.isLogin() {
            let issuevc = IssueViewController()
            let navi = YGNavigationController(rootViewController: issuevc)
            controller.presentViewController(navi, animated: false, completion: {})
        } else {
            let logView = YGLogView()
            logView.animation()
            logView.tapLogViewClosure({ (type) in
                LogInHelper.logViewTap(controller, type: type)
            })
        }
    }
    
    static func logout() {
        _ = try? KeyChainSingle.sharedInstance.keychain.remove(kToken)
        _ = try? KeyChainSingle.sharedInstance.keychain.remove(kToken2)
        _ = try? KeyChainSingle.sharedInstance.keychain.remove(kUserId)
        _ = try? KeyChainSingle.sharedInstance.keychain.remove(kCookie)
        _ = try? KeyChainSingle.sharedInstance.keychain.remove(kCookiePath)
        _ = try? KeyChainSingle.sharedInstance.keychain.remove(kAuthType)
        _ = try? KeyChainSingle.sharedInstance.keychain.remove(kExpiresDate)
    }
}
