//
//  String+SBAdd.swift
//  SwiftExtensionExample
//
//  Created by 宋碧海 on 16/9/11.
//  Copyright © 2016年 songbihai. All rights reserved.
//

import UIKit
import Foundation

extension String {
    /// Objective-C length
    var length: Int {
        return self.characters.count
    }
    
    var intValue: Int? {
        return Int(self)
    }
    
    var doubleValue: Double? {
        return Double(self)
    }
    
    var floatValue: Float? {
        return Float(self)
    }
    
    /// nil or ""
    var isEmpty: Bool {
        return self.isEmptyString(self)
    }
    
    /// Objective-C '- (unichar)characterAtIndex:(NSUInteger)index'
    @warn_unused_result(message="don't use return Character")
    func character(atIndex: Int) -> Character? {
        if self.isEmpty { return nil }
        guard atIndex < self.length else { return nil }
        return self[self.startIndex.advancedBy(atIndex)]
    }
    
    /// Objective-C '- (NSString *)substringFromIndex:(NSUInteger)from'
    @warn_unused_result(message="don't use return String")
    func substringFromIndex(from: Int) -> String? {
        if self.isEmpty { return self }
        guard from < self.length else { return nil }
        return self.substringFromIndex(self.startIndex.advancedBy(from))
    }
    
    /// Objective-C '- (NSString *)substringToIndex:(NSUInteger)to'
    @warn_unused_result(message="don't use return String")
    func substringToIndex(to: Int) -> String? {
        if self.isEmpty { return self }
        guard to <= self.length else { return nil }
        return self.substringToIndex(self.startIndex.advancedBy(to))
    }
    
    /// Objective-C '- (NSString *)substringWithRange:(NSRange)range'
    @warn_unused_result(message="don't use return String")
    func substringWithRange(range: NSRange) -> String? {
        if self.isEmpty { return self }
        guard range.location < self.length else { return nil }
        guard range.location + range.length < self.length else { return nil }
        return self.substringWithRange(self.startIndex.advancedBy(range.location) ..< self.startIndex.advancedBy(range.location + range.length))
    }
    
    // Objective-C '- (NSRange)rangeOfString:(NSString *)searchString'
    @warn_unused_result(message="don't use return NSRange")
    func rangeOf(substring: String) -> NSRange? {
        let range = self.rangeOfString(substring)
        guard let subRange = range else { return nil }
        let start: Int = Int("\(subRange.startIndex)")!
        let end: Int = Int("\(subRange.endIndex)")!
        return NSMakeRange(start, end - start)
    }
}

extension String {
    private func isEmptyString(text: String?) -> Bool {
        guard let t = text else { return true }
        if self.length <= 0 || t == "" {
            return true
        } else {
            return false
        }
    }
}
