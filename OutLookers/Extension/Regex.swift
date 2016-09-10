//
//  Regex.swift
//  Demo
//
//  Created by C on 15/7/7.
//  Copyright (c) 2015年 SK. All rights reserved.
//

import Foundation

struct RegexHelper {
    let regex: NSRegularExpression?
    init(pattern: String) {
        do {
            regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive)
        } catch let error as NSError {
            print(error)
            regex = nil
        }
    }
    func match(input: String)->Bool{
        if let matches = regex?.matchesInString(input, options: [], range: NSMakeRange(0, input.characters.count)){
            return matches.count > 0
        } else {
            return false
        }
    }
}

infix operator =~ {
associativity none
precedence 130
}

func =~(match: String, pattern: String)-> Bool {
    return RegexHelper(pattern: pattern).match(match)
}
