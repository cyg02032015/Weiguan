//
//  String+EX.swift
//  jizhi
//
//  Created by C on 15/10/30.
//  Copyright © 2015年 YoungKook. All rights reserved.
//

import Foundation

// MD5加密
extension String {
    var myMD5: String {
        let cString = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let length = CUnsignedInt(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(cString!,length,result)
        
        return String(format: "%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x", result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15])
    }
}