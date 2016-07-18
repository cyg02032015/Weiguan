//
//  MyReleaseViewController.swift
//  OutLookers
//
//  Created by C on 16/7/18.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let myReleaseCellId = "myReleaseCellId"

class MyReleaseViewController: YGBaseViewController {

    var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }
    
    func setupSubViews() {
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = kHeight(142)
        tableView.registerClass(MyReleaseCell.self, forCellReuseIdentifier: myReleaseCellId)
        tableView.separatorStyle = .None
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
    }
}

extension MyReleaseViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(myReleaseCellId, forIndexPath: indexPath) as! MyReleaseCell
        cell.delegate = self
        return cell
    }
}

extension MyReleaseViewController: MyReleaseCellDelegate {
    func myReleaseTapEdit(sender: UIButton) {
        LogInfo("编辑")
    }
    
    func myReleaseTapDetail(sender: UIButton) {
        LogInfo("查看详情")
    }
    
    func myReleaseTapStopRecruit(sender: UIButton) {
        LogInfo("停止招募")
    }
}
