//
//  NSDate-EX.swift
//  OutLookers
//
//  Created by C on 16/6/20.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import Foundation

extension NSDate {
    
    func stringFromDateWith(format: String) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = format //"yyyy-MM-dd HH:mm"
        formatter.timeZone = NSTimeZone.systemTimeZone()
        return formatter.stringFromDate(self)
    }
    
    func stringFromDate() -> String {
        return stringFromDateWith("yyyy-MM-dd HH:mm")
    }
}
