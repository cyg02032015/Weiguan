//
//  LogFormatter.swift
//  OutLookers
//
//  Created by C on 16/6/24.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import Foundation
import CocoaLumberjack.DDDispatchQueueLogFormatter

class LogFormatter: DDDispatchQueueLogFormatter {
    
    override func formatLogMessage(logMessage: DDLogMessage!) -> String {
        var logLevel: String!
        switch logMessage.flag {
        case DDLogFlag.Error: logLevel   = " ERROR "
        case DDLogFlag.Warning: logLevel = " WARN  "
        case DDLogFlag.Info: logLevel    = " INFO  "
        case DDLogFlag.Debug: logLevel   = " DEBUG "
        case DDLogFlag.Verbose: logLevel = "VERBOSE"
        default: logLevel = "DEBUG"
        }
        return "[\(logLevel)] [LINE:\(logMessage.line)] \(logMessage.message)"
    }
}