//
//  SettingViewController.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/26.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let arrowEidtCellId = "arrowEidtCellId"
private let noarrowEdictCellId = "noarrowEdictCellId"
private let logButtonCellId = "logButtonCellId"

class SettingViewController: YGBaseViewController {
    var titles = ["我的账号", "通知设置", "关于纯氧", "清除缓存"]
    var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }
    
    func setupSubViews() {
        title = "设置"
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = kBackgoundColor
        tableView.registerClass(ArrowEditCell.self, forCellReuseIdentifier: arrowEidtCellId)
        tableView.registerClass(NoArrowEditCell.self, forCellReuseIdentifier: noarrowEdictCellId)
        tableView.registerClass(LogButtonCell.self, forCellReuseIdentifier: logButtonCellId)
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
    }
}

extension SettingViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2 {
            let cell = tableView.dequeueReusableCellWithIdentifier(arrowEidtCellId, forIndexPath: indexPath) as! ArrowEditCell
            cell.setTextInCell(titles[indexPath.section], placeholder: "")
            cell.label.font = UIFont.customFontOfSize(14)
            return cell
        } else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCellWithIdentifier(noarrowEdictCellId, forIndexPath: indexPath) as! NoArrowEditCell
            cell.setTextInCell(titles[indexPath.section], placeholder: "")
            cell.label.font = UIFont.customFontOfSize(14)
            cell.textFieldEnable = false
            cell.tf.text = "0M"
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(logButtonCellId, forIndexPath: indexPath) as! LogButtonCell
            cell.label.text = "立即登录"
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return kHeight(50)
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kHeight(10)
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}