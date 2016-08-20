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
    
    func isLogin() -> Bool {
        if let userid = KeyChainSingle.sharedInstance.getUserId() {
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
}
