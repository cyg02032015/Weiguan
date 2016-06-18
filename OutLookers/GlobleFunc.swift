//
//  GlobleFunc.swift
//  OutLookers
//
//  Created by C on 16/6/18.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

func LocalizedString(text: String) -> String {
    return NSLocalizedString(text, comment: "")
}

func configNavigation() {
    UINavigationBar.appearance().barTintColor = UIColor(hex: 0x333333)
    UINavigationBar.appearance().translucent = false
    UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
}