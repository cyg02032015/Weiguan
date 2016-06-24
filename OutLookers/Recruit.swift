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
    var recruitCount: String!
    var budgetPrice: String?
    
    init (skill: String, recruitCount: String, budgetPrice: String?) {
        self.skill = skill
        self.recruitCount = recruitCount
        self.budgetPrice = budgetPrice
    }
}