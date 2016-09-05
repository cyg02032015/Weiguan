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
        var md5 = String(format: "%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x", result[0], result[1], result[2], result[3],
                         result[4], result[5], result[6], result[7],
                         result[8], result[9], result[10], result[11],
                         result[12], result[13], result[14], result[15])
        LogDebug("转换前 \(md5)")
        let index = md5.startIndex.advancedBy(3)
        let firstThree = md5.substringToIndex(index)  // md5 取前3到后3
        let last = md5.substringFromIndex(index)
        md5 = last + firstThree
        LogDebug("转换后 \(md5)")
        return md5
    }
    
    func noWhiteSpace() -> String {
        let noWhiteSpace = self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        return noWhiteSpace
    }
    
    func noChangeLine() -> String {
        let noChangLine = self.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
        return noChangLine
    }
    
    func addSnapshots() -> String {
        return globleSingle.videoSnapshotPrefix + self
    }
    
    func addVideoPath() -> String {
        return globleSingle.vedioPath + self
    }
    
    func addImagePath(size: CGSize = CGSize(width: 1080, height: 1080)) -> NSURL? {
        if self.lowercaseString.hasPrefix("http") {
            return NSURL.init(string: self)
        }
        guard let path = globleSingle.imagePath else {return nil}
        return NSURL(string: path + self + "@\(Int(size.width))h_\(Int(size.height))w.webp")!
    }
    
    func dateFromString(format: String = "yyyy-MM-dd HH:mm:ss.S") -> NSDate? {
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = NSTimeZone.systemTimeZone()
        let date = formatter.dateFromString(self) ?? NSDate()
        return date
    }
    
    
}