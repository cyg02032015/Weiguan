//
//  TokenTool.swift
//  OutLookers
//
//  Created by C on 16/8/20.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class TokenTool {
    
    class func isCookieExpired() -> Bool {
        guard let tokendate = Int(KeyChainSingle.sharedInstance.keychain[kExpiresDate] ?? "0"), currentTimestamp = Int(Util.getCurrentTimestamp()) else {fatalError("无法获取时间戳")}
        if tokendate < currentTimestamp { // 如果存储的时间戳小于当前时间戳过期  -- 过期
            return true
        } else {
            return false
        }
    }
    
    class func expiredDate(tokenDate: String) -> String {
        guard let tokendate = Int(tokenDate) else {fatalError("无法获取时间戳")}
        return "\(tokendate + 23 * 60 * 60 * 1000)" // cookie 一天过期  提前一小时刷新
    }
    
    class func saveCookieAndExpired(cookies: [NSHTTPCookie]) {
        for cookie in cookies {
            let array = cookie.value.componentsSeparatedByString("|")
            KeyChainSingle.sharedInstance.keychain[kExpiresDate] = self.expiredDate(array[1])
            KeyChainSingle.sharedInstance.keychain[kCookie] = cookie.value
            KeyChainSingle.sharedInstance.keychain[kCookiePath] = "X-X-U=" + cookie.value + ";" + "domin=" + cookie.domain + ";" + "path=" + cookie.path
        }
    }
}
