//
//  AccountViewController.swift
//  OutLookers
//
//  Created by C on 16/7/31.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let arrowEditCellId = "arrowEditCellId"
private let accountCellId = "accountCellId"

class AccountViewController: YGBaseViewController {
    
    var imgs = ["Groupphone", "wechat_c", "qq_c", "sina_weibo_c"]
    var titles = ["手机号", "微信号", "QQ号", "新浪微博"]
    var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }
    
    func setupSubViews() {
        title = "我的账号"
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = kHeight(50)
        tableView.registerClass(ArrowEditCell.self, forCellReuseIdentifier: arrowEditCellId)
        tableView.registerClass(AccountCell.self, forCellReuseIdentifier: accountCellId)
        tableView.separatorStyle = .None
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
    }
}

extension AccountViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 4
        default: return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(arrowEditCellId, forIndexPath: indexPath) as! ArrowEditCell
            cell.setTextInCell("登录密码", placeholder: "修改密码")
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(accountCellId, forIndexPath: indexPath) as! AccountCell
            cell.setImgAndText(imgs[indexPath.row], text: titles[indexPath.row])
            if indexPath.row == 0 {
                cell.bindButton.hidden = true
                cell.rightLabel.hidden = false
                cell.rightLabel.text = "188****1231"
            }
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kHeight(10)
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}
