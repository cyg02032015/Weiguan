//
//  String+Extension.swift
//  OutLookers
//
//  Created by Youngkook on 16/6/15.
//  Copyright © 2016年 youngkook. All rights reserved.
//

import Foundation

extension String {
    func noWhiteSpace() -> String {
        let noWhiteSpace = self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        return noWhiteSpace
    }
    
    func noChangeLine() -> String {
        let noChangLine = self.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
        return noChangLine
    }
    
}