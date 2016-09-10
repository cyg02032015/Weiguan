//
//  CPAlertController.swift
//  OutLookers
//
//  Created by 宋碧海 on 16/9/9.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

extension UIViewController {

    //index只是defults的索引，从0开始
    func showAlertController(title: String?, message: String, cancel: String = "取消", defults: [String]?, preferredStyle: UIAlertControllerStyle = .Alert, handler: ((Int, UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        let cancelAction = UIAlertAction(title: cancel, style: .Cancel, handler: nil)
        alert.addAction(cancelAction)
        guard let _ = defults else { return }
        for (index, defult) in defults!.enumerate() {
            let defultAction = UIAlertAction(title: defult, style: .Default) { (alertAction) in
                if let _ = handler {
                    handler!(index, alertAction)
                }
            }
            alert.addAction(defultAction)
        }
        presentViewController(alert, animated: true, completion: nil)
    }
    

    //取消关注
    func cancelFollow(followUserId: String, handler: (success: Bool) -> Void) {
        Server.cancelFollow(followUserId, handler: { (success, msg, value) in
            handler(success: success)
        })
    }
}
