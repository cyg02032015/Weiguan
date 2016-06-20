//
//  Recruit.swift
//  OutLookers
//
//  Created by Youngkook on 16/6/20.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import Foundation

struct Recruit {
    var skill: String!
    var skillPrice: String!
    var service: String?
    
    init (skill: String, skillPrice: String, service: String?) {
        self.skill = skill
        self.skillPrice = skillPrice
        self.service = service
    }
}