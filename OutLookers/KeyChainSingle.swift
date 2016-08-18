
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
    
}

