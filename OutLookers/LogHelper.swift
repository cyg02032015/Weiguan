//
//  LogHelper.swift
//  OutLookers
//
//  Created by C on 16/8/30.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import CocoaLumberjack

func LogInfo<T>(message: T) {
    #if DEBUG
        DDLogInfo("\(message)")
    #endif
}

func LogVerbose<T>(message: T) {
    #if DEBUG
        DDLogVerbose("\(message)")
    #endif
}

func LogError<T>(message: T) {
    #if DEBUG
        DDLogError("\(message)")
    #endif
}

func LogWarn<T>(message: T) {
    #if DEBUG
        DDLogWarn("\(message)")
    #endif
}

func LogDebug<T>(message: T) {
    #if DEBUG
        DDLogDebug("\(message)")
    #endif
}

func configCocoaLumberjack() {
    DDLog.addLogger(DDTTYLogger.sharedInstance())
    setenv("XcodeColors", "YES", 0)
    DDTTYLogger.sharedInstance().colorsEnabled = true
    DDTTYLogger.sharedInstance().setForegroundColor(UIColor.yellowColor(), backgroundColor: nil, forFlag: .Info)
    DDTTYLogger.sharedInstance().setForegroundColor(UIColor.cyanColor(), backgroundColor: nil, forFlag: .Debug)
    DDTTYLogger.sharedInstance().setForegroundColor(UIColor.greenColor(), backgroundColor: nil, forFlag: .Verbose)
    DDTTYLogger.sharedInstance().logFormatter = LogFormatter()
}
