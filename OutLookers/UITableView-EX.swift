//
//  UITableView-EX.swift
//  OutLookers
//
//  Created by C on 16/7/2.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

extension UITableView {
    func cellForRowAt(section: Int, row: Int) -> UITableViewCell? {
        return self.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: section))
    }
}