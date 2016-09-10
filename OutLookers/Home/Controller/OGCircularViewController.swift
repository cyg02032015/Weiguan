//
//  OGCircularViewController.swift
//  OutLookers
//
//  Created by C on 16/7/9.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let ogCircularCellIdentifier = "ogCircularCellId"

class OGCircularViewController: YGBaseViewController {

    var tableView: UITableView!
    
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
        tableView.registerClass(OGCircularCell.self, forCellReuseIdentifier: ogCircularCellIdentifier)
        tableView.separatorStyle = .None
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView()
        tableView.rowHeight = kHeight(263)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
    }
}

extension OGCircularViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ogCircularCellIdentifier, forIndexPath: indexPath) as! OGCircularCell
        return cell
    }
}
