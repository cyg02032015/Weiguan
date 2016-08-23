
//
//  KeyChainSingle.swift
//  OutLookers
//
//  Created by C on 16/8/18.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import KeychainAccess

private let sharedKeyChain = KeyChainSingle()
class KeyChainSingle {
    var keychain: Keychain = Keychain(service: "com.chunyangapp.app")
    
    class var sharedInstance: KeyChainSingle {
        return sharedKeyChain
    }
    
    func saveTokenUserid(info: RegisterObj) {
        keychain[kToken] = info.token
        keychain[kToken2] = info.token2
        keychain[kUserId] = info.userId
    }
    
    func getUserId() -> String? {
        return keychain[kUserId]
    }
    
    func logOut() {
        _ = try? keychain.remove(kToken)
        _ = try? keychain.remove(kToken2)
        _ = try? keychain.remove(kUserId)
        _ = try? keychain.remove(kCookie)
        _ = try? keychain.remove(kExpiresDate)
    }
}

