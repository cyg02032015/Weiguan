//
//  UserSingle.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/19.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let sharedUser = UserSingleton()
class UserSingleton {
    class var sharedInstance: UserSingleton {
        return sharedUser
    }
    
    var isSetPassword: Bool = false
    var originPwd: String!
    var newPwd: String!
}
