//
//  ScrollVerticalDelegate.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/7.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

protocol ScrollVerticalDelegate: class {
    func customScrollViewDidEndDecelerating(isScroll: Bool)
}