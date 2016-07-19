//
//  ModifyPasswordViewController.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/19.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let modifyCellId = "modifyCellId"

class ModifyPasswordViewController: YGBaseViewController {

    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }
    
    func setupSubViews() {
        title = "设置支付密码"
        tableView = UITableView()
        tableView.backgroundColor = kBackgoundColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(ModifyCell.self, forCellReuseIdentifier: modifyCellId)
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
    }
}

extension ModifyPasswordViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(modifyCellId, forIndexPath: indexPath) as! ModifyCell
        cell.label.text = ["修改支付密码", "找回支付密码"][indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            let vc = SetPasswordViewController()
            vc.type = .Modify
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = GetVerifyViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
