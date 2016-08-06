//
//  Array+EX.swift
//  OutLookers
//
//  Created by Youngkook on 16/8/4.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

extension Array where Element: Equatable {
    
    mutating func removeObject(object: Element) {
        if let index = indexOf(object) {
            removeAtIndex(index)
        }
    }
    
    func dataWithImages() -> [NSData] {
        var datas = [NSData]()
        for img in self {
            if let data = UIImagePNGRepresentation(img as! UIImage) {
                datas.append(data)
            } else if let data = UIImageJPEGRepresentation(img as! UIImage, 0.9) {
                datas.append(data)
            }
        }
        return datas
    }
    
    
}