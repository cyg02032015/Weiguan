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

protocol RecruitInformationDelegate: class {
    func recruitInformationSureWithParams(recruit: Recruit)
}

class RecruitInformationViewController: YGBaseViewController {

    var tableView: UITableView!
    var sureButton : UIButton!
    var pickerView: YGPickerView!
    weak var delegate: RecruitInformationDelegate!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        pickerView = YGPickerView(frame: CGRectZero, delegate: self)
        pickerView.titleLabel.text = "才艺标价单位"
        UIApplication.sharedApplication().keyWindow!.addSubview(pickerView)
        pickerView.hidden = true
        pickerView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(pickerView.superview!)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        pickerView.removeFromSuperview()
        pickerView = nil
    }
    
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
        sureButton.userInteractionEnabled = false
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
    
    func checkParmas() {
        let cell0 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! ArrowEditCell
        let cell1 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0)) as! NoArrowEditCell
        if cell0.tf.text?.characters.count > 0 && cell1.tf.text?.characters.count > 0 {
            sureButton.userInteractionEnabled = true
            sureButton.backgroundColor = kRedColor
        } else {
            sureButton.userInteractionEnabled = false
            sureButton.backgroundColor = kGrayColor
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
            cell.delegate = self
            cell.setTextInCell("才艺标价", placeholder: "请输入整数")
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(noArrowIdentifier, forIndexPath: indexPath) as! NoArrowEditCell
            cell.delegate = self
            cell.setTextInCell("服务地区 (选填)", placeholder: "请输入整数 元/人")
            cell.textFieldEnable = false
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            let selectSkill = SelectSkillViewController()
            selectSkill.type = SelectSkillType.Back
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! ArrowEditCell
            selectSkill.tapItemInCollection({ [unowned self](text) in
                cell.tf.text = text
                self.checkParmas()
            })
            navigationController?.pushViewController(selectSkill, animated: true)
        }
        
        if indexPath.row == 2 {
            pickerView.animation()
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 56
    }
}

// MARK: -点击按钮 & NoArrowEditCellDelegate
extension RecruitInformationViewController: NoArrowEditCellDelegate {
    
    func tapSure(sender: UIButton) {
        let cell0 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! ArrowEditCell
        let cell1 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0)) as! NoArrowEditCell
        let cell2 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0)) as! NoArrowEditCell
        let recruit = Recruit(skill: cell0.tf.text!, skillPrice: cell1.tf.text!, service: cell2.tf.text)
        delegate.recruitInformationSureWithParams(recruit)
        navigationController?.popViewControllerAnimated(true)
    }
    
    func noArrowEditCellCheckText(text: String?) {
        self.checkParmas()
    }
}

extension RecruitInformationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 0
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 0
    }
}