//
//  OGDataViewController.swift
//  OutLookers
//
//  Created by C on 16/7/9.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let ogDataCellIdentifier = "ogDataCellId"

class OGDataViewController: YGBaseViewController {

    var tableView: UITableView!
    var titles = ["纯氧认证", "机构类型", "所  在 地", "简      介"]
    var rights = ["阿里营业官方机构", "培训机构", "北京 海淀区", "机构介绍"]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }
    
    func setupSubViews() {
        LogWarn("viewdidload")
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(OGDataTableViewCell.self, forCellReuseIdentifier: ogDataCellIdentifier)
        tableView.separatorStyle = .None
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView()
        tableView.rowHeight = kHeight(46.5)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
    }
}

extension OGDataViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ogDataCellIdentifier, forIndexPath: indexPath) as! OGDataTableViewCell
        cell.leftLabel.text = titles[indexPath.row]
        cell.rightLabel.text = rights[indexPath.row]
        return cell
    }
}
