//
//  ScrollVerticalDelegate.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/7.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
enum ScrollState: Int {
    case DidEndDecelerating, BeginDragging, DidEndDragging
}

protocol ScrollVerticalDelegate: class {
    func customScrollViewStatus(state: ScrollState)
}