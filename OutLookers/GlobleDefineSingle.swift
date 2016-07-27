//
//  GlobleDefineSingle.swift
//  OutLookers
//
//  Created by C on 16/7/27.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let sharedGloble = GlobleDefineSingle()
class GlobleDefineSingle {
    class var sharedInstance: GlobleDefineSingle {
        return sharedGloble
    }
    
    var imagePath: String!
    var vedioPath: String!
    var citiesUrl: String!
    var version: String!
}
