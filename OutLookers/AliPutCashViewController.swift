//
//  AliPutCashViewController.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/19.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let noArrowCellId = "noArrowCellId"

private extension Selector {
    static let tapCashButton = #selector(MyAccountViewController.tapCashButton(_:))
}

class AliPutCashViewController: YGBaseViewController {

    var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }

    func setupSubViews() {
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.backgroundColor = kBackgoundColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(NoArrowEditCell.self, forCellReuseIdentifier: noArrowCellId)
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
    }
    
    func tapCashButton(sender: UIButton) {
        
    }
}

extension AliPutCashViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(noArrowCellId, forIndexPath: indexPath) as! NoArrowEditCell
        cell.label.font = UIFont.customFontOfSize(16)
        cell.tf.font = UIFont.customFontOfSize(16)
        cell.indexPath = indexPath
        cell.delegate = self
        if indexPath.row == 0 {
            cell.setTextInCell("支付宝账号", placeholder: "请填写账号")
        } else if indexPath.row == 1 {
            cell.setTextInCell("支付宝姓名", placeholder: "请填写姓名")
        } else {
            cell.setTextInCell("金额(元)", placeholder: "账户余额30000")
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return kHeight(420)
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: kHeight(420)))
        
        let notice = UILabel.createLabel(12, textColor: UIColor(hex: 0xc0c0c0))
        notice.numberOfLines = 0
        notice.textAlignment = .Center
        view.addSubview(notice)
        notice.snp.makeConstraints { (make) in
            make.left.equalTo(notice.superview!).offset(kScale(61))
            make.right.equalTo(notice.superview!).offset(kScale(-61))
            make.bottom.equalTo(notice.superview!).offset(kScale(-20))
        }
        
        let label = UILabel.createLabel(14, textColor: UIColor(hex: 0xc0c0c0))
        label.textAlignment = .Center
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.right.equalTo(label.superview!)
            make.bottom.equalTo(notice.snp.top).offset(kScale(-10))
            make.height.equalTo(kScale(14))
        }
        
        let cashButton = UIButton()
        cashButton.setTitle("提现", forState: .Normal)
        cashButton.addTarget(self, action: .tapCashButton, forControlEvents: .TouchUpInside)
        cashButton.backgroundColor = kCommonColor
        cashButton.layer.cornerRadius = kScale(6)
        cashButton.titleLabel!.font = UIFont.customFontOfSize(16)
        view.addSubview(cashButton)
        cashButton.snp.makeConstraints(closure: { (make) in
            make.bottom.equalTo(label.snp.top).offset(kScale(-205))
            make.left.equalTo(cashButton.superview!).offset(kScale(38))
            make.right.equalTo(cashButton.superview!).offset(kScale(-38))
            make.height.equalTo(kScale(44))
        })
        
        label.text = "温馨提示"
        notice.text = "• 单次提现金额最低为1000元，最高10000元自动扣除提现金额2.5%的手续费，由支付宝收取\n• 3-10个工作日之内到账"
        return view
    }
}

extension AliPutCashViewController: NoArrowEditCellDelegate {
    func noarrowCellReturnText(text: String?, tuple: (section: Int, row: Int)) {
        LogInfo(text)
    }
}