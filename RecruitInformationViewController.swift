//
//  RecruitInformationViewController.swift
//  OutLookers
//
//  Created by C on 16/6/19.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//  招募信息

import UIKit

private let noArrowIdentifier = "noArrowId"
private let arrowIdentifier = "arrowId"

private extension Selector {
    static let tapSure = #selector(RecruitInformationViewController.tapSure(_:))
}

class RecruitInformationViewController: YGBaseViewController {

    var tableView: UITableView!
    var sureButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "招募信息"
        
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.registerClass(ArrowEditCell.self, forCellReuseIdentifier: arrowIdentifier)
        tableView.registerClass(NoArrowEditCell.self, forCellReuseIdentifier: noArrowIdentifier)
        
        sureButton = UIButton()
        sureButton.setTitle("确定", forState: .Normal)
        sureButton.titleLabel?.font = UIFont.systemFontOfSize(20)
        sureButton.addTarget(self, action: .tapSure, forControlEvents: .TouchUpInside)
        sureButton.backgroundColor = kGrayColor
        view.addSubview(sureButton)
        
        sureButton.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(sureButton.superview!)
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(tableView.superview!)
            make.top.equalTo(self.snp.topLayoutGuideBottom)
            make.bottom.equalTo(sureButton.snp.top)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
}

extension RecruitInformationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(arrowIdentifier, forIndexPath: indexPath) as! ArrowEditCell
            cell.setTextInCell("艺人类型", placeholder: "点击选择类型")
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier(noArrowIdentifier, forIndexPath: indexPath) as! NoArrowEditCell
            cell.setTextInCell("才艺标价", placeholder: "请输入整数")
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(noArrowIdentifier, forIndexPath: indexPath) as! NoArrowEditCell
            cell.setTextInCell("服务地区 (选填)", placeholder: "请输入整数 元/人")
            cell.textFieldEnable = false
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            let selectSkill = SelectSkillViewController()
            navigationController?.pushViewController(selectSkill, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 56
    }
}

// MARK: -点击按钮
extension RecruitInformationViewController {
    
    func tapSure(sender: UIButton) {
        debugPrint("确定")
    }
}