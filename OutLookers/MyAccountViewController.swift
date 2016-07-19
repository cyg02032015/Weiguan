//
//  MyAccountViewController.swift
//  OutLookers
//
//  Created by C on 16/7/18.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let myAccountHeadCellId = "myAccountHeadCellId"
private let myAccountCellId = "myAccountCellId"

private extension Selector {
    static let tapCashButton = #selector(MyAccountViewController.tapCashButton(_:))
}

class MyAccountViewController: YGBaseViewController {

    var tableView: UITableView!
    lazy var imgs = ["Group 3", "group1", "Group 5"]
    lazy var titles = ["交易记录", "交易密码", "账号绑定"]
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        LogInfo("\(UserSingleton.sharedInstance.newPwd)   \(UserSingleton.sharedInstance.originPwd)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }
    
    func setupSubViews() {
        title = "我的账户"
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.backgroundColor = kBackgoundColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(MyAccountHeadCell.self, forCellReuseIdentifier: myAccountHeadCellId)
        tableView.registerClass(MyAccountCell.self, forCellReuseIdentifier: myAccountCellId)
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
    }
    
    func tapCashButton(sender: UIButton) {
        let vc = PutCashViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MyAccountViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 3
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(myAccountHeadCellId, forIndexPath: indexPath) as! MyAccountHeadCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(myAccountCellId, forIndexPath: indexPath) as! MyAccountCell
            cell.imgView.image = UIImage(named: imgs[indexPath.row])
            cell.label.text = titles[indexPath.row]
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                let vc = TransactionDetailViewController()
                navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.row == 1 {
                if UserSingleton.sharedInstance.isSetPassword {
                    let vc = ModifyPasswordViewController()
                    navigationController?.pushViewController(vc, animated: true)
                } else {
                    let vc = GetVerifyViewController()
                    navigationController?.pushViewController(vc, animated: true)
                }
            } else {
                let vc = BindAccountViewController()
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return kHeight(191)
        } else {
            return kHeight(44)
        }
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return kHeight(10)
        } else {
            return kHeight(100)
        }
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            let view = UIView(frame: CGRect(origin: CGPointZero, size: CGSize(width: ScreenWidth, height: kHeight(10))))
            view.backgroundColor = kBackgoundColor
            return view
        } else {
            let view = UIView(frame: CGRect(origin: CGPointZero, size: CGSize(width: ScreenWidth, height: kHeight(100))))
            view.backgroundColor = kBackgoundColor
            let cashButton = UIButton()
            cashButton.setTitle("提现", forState: .Normal)
            cashButton.addTarget(self, action: .tapCashButton, forControlEvents: .TouchUpInside)
            cashButton.backgroundColor = kCommonColor
            cashButton.layer.cornerRadius = kScale(6)
            cashButton.titleLabel!.font = UIFont.customFontOfSize(16)
            view.addSubview(cashButton)
            cashButton.snp.makeConstraints(closure: { (make) in
                make.top.equalTo(cashButton.superview!).offset(kScale(44))
                make.left.equalTo(cashButton.superview!).offset(kScale(38))
                make.right.equalTo(cashButton.superview!).offset(kScale(-38))
                make.height.equalTo(kScale(44))
            })
            return view
        }
    }
}
