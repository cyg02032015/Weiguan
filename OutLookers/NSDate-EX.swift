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
    
    func stringFromCreate() -> String {
        return stringFromDateWith("yyyy-MM-dd HH:mm:ss.S")
    }
    
    func stringFromDate() -> String {
        return stringFromDateWith("yyyy-MM-dd HH:mm")
    }
    
    func getShowFormat() -> String {
        
        //获取当前时间
        let calendar = NSCalendar.currentCalendar()
        //判断是否是今天
        if calendar.isDateInToday(self) {
            //获取当前时间和系统时间的差距(单位是秒)
            //强制转换为Int
            let since = Int(NSDate().timeIntervalSinceDate(self))
            //  是否是刚刚
            if since < 60 {
                return "刚刚"
            }
            //  是否是多少分钟内
            if since < 60 * 60 {
                return "\(since/60)分钟前"
            }
            //  是否是多少小时内
            return "\(since / (60 * 60))小时前"
        }
        
        //判断是否是昨天
        var formatterString = "HH:mm"
        if calendar.isDateInYesterday(self) {
            formatterString = "昨天" + formatterString
        } else {
            //判断是否是一年内
            formatterString = "MM-dd " + formatterString
            //判断是否是更早期
            let comps = calendar.components(NSCalendarUnit.Year, fromDate: self, toDate: NSDate(), options: NSCalendarOptions(rawValue: 0))
            
            if comps.year >= 1 {
                formatterString = "yyyy- " + formatterString
            }
        }
        
        //按照指定的格式将日期转换为字符串
        //创建formatter
        let formatter = NSDateFormatter()
        //设置时间格式
        formatter.dateFormat = formatterString
        //设置时间区域
        formatter.locale = NSLocale(localeIdentifier: "en")
        
        //格式化
        return formatter.stringFromDate(self)
    }
}
