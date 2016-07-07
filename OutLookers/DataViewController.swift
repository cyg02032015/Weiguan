//
//  DataViewController.swift
//  OutLookers
//
//  Created by C on 16/7/7.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//  个人主页-资料

import UIKit

private let dataCellIdentifier = "dataCellId"
private let dataSecondCellIdentifier = "dataSecondId"

class DataViewController: YGBaseViewController {

    
    var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        LogWarn("viewdidload")
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(DataTableViewCell.self, forCellReuseIdentifier: dataCellIdentifier)
        tableView.registerClass(DataSecondCell.self, forCellReuseIdentifier: dataSecondCellIdentifier)
        tableView.separatorStyle = .None
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = kHeight(325)
        tableView.rowHeight = UITableViewAutomaticDimension
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
    }
}

// MARK: - UITableviewDelegate, UITableviewDatasource
extension DataViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(dataCellIdentifier, forIndexPath: indexPath) as! DataTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(dataSecondCellIdentifier, forIndexPath: indexPath) as! DataSecondCell
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return kScale(325)
        } else {
            return kScale(157)
        }
    }
}
