//
//  UserSingle.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/19.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

enum UserType: Int {
    case Tourist = 0  // 游客
    case HotMan = 1   // 网红
    case Organization = 2  // 机构
    case Fans = 3   // 粉丝
}

private let sharedUser = UserSingleton()
class UserSingleton {
    class var sharedInstance: UserSingleton {
        return sharedUser
    }
    var type: UserType = .Tourist
    var isSetPassword: Bool = false
    var originPwd: String!
    var newPwd: String!
    var userId: String = ""
    var nickname: String = ""
    
    func isLogin() -> Bool {
        if let userid = self.getUserId() {
            self.userId = userid
            if userid.characters.count > 0 {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    func saveUserId(userid: String) {
        KeyChainSingle.sharedInstance.keychain[kUserId] = userid
    }
    
    func saveTokenUserid(info: RegisterObj) {
        KeyChainSingle.sharedInstance.keychain[kToken] = info.token
        KeyChainSingle.sharedInstance.keychain[kToken2] = info.token2
        KeyChainSingle.sharedInstance.keychain[kUserId] = info.userId
        KeyChainSingle.sharedInstance.keychain[kAuthType] = "\(info.authenticationType)"
    }
    
    func getUserId() -> String? {
        return KeyChainSingle.sharedInstance.keychain[kUserId]
    }
}
