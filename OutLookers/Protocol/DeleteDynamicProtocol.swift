//
//  DeleteDynamicProtocol.swift
//  OutLookers
//
//  Created by 宋碧海 on 16/9/14.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

protocol DeleteDynamicProtocol {
    func deleteDynamic(id: String, handler: (Bool, String?) -> Void)
}

extension DeleteDynamicProtocol {
    func deleteDynamic(id: String, handler: (Bool, String?) -> Void) {
        Server.deleteDynamic(id) { (success, msg, value) in
            handler(success, msg)
        }
    }
}
