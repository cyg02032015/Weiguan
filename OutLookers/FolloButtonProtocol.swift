//
//  FolloButtonProtocol.swift
//  OutLookers
//
//  Created by C on 16/8/14.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

/// 关注按钮protocol
public protocol FollowProtocol {
    func modifyFollow(sender: UIButton)
}

extension FollowProtocol {
    public func modifyFollow(sender: UIButton) {
        sender.setImage(UIImage(named: ""), forState: .Normal)
        sender.setTitle("已关注", forState: .Normal)
        UIView.animateWithDuration(1, delay: 1, options: .TransitionNone, animations: {
            sender.alpha = 0
        }) { (complet) in
            sender.hidden = complet == true ? true : false
        }
    }
}