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
private let budgetPriceIdentifier = "budgetPriceId"

protocol RecruitInformationDelegate: class {
    func recruitInformationSureWithParams(recruit: Recruit)
}

class RecruitInformationViewController: YGBaseViewController {

    var tableView: UITableView!
    var pickerView: YGPickerView!
    lazy var skillUnitPickerArray = [String]()
    weak var delegate: RecruitInformationDelegate!
    var rightButton: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        skillUnitPickerArray = ["元/小时", "元/场", "元/次", "元/半天"]
        pickerView = YGPickerView(frame: CGRectZero, delegate: self)
        pickerView.titleLabel.text = "才艺标价单位"
        UIApplication.sharedApplication().keyWindow!.addSubview(pickerView)
        pickerView.delegate = self
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
        tableView.registerClass(BudgetPriceCell.self, forCellReuseIdentifier: budgetPriceIdentifier)
        
        rightButton = createNaviRightButton("确定")
        
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(tableView.superview!)
            make.top.equalTo(self.snp.topLayoutGuideBottom)
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
            cell.setTextInCell("才艺类型", placeholder: "点击选择类型")
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier(noArrowIdentifier, forIndexPath: indexPath) as! NoArrowEditCell
            cell.tf.keyboardType = .NumberPad
            cell.setTextInCell("招募数量", placeholder: "请输入整数")
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(budgetPriceIdentifier, forIndexPath: indexPath) as! BudgetPriceCell
            cell.tf.keyboardType = .NumberPad
            cell.delegate = self
            cell.setTextInCell("预算价格 (选填)", placeholder: "请输入整数", buttonText: "元/人")
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            let selectSkill = SelectSkillViewController()
            selectSkill.type = SelectSkillType.Back
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! ArrowEditCell
            selectSkill.tapItemInCollection({ (text) in
                cell.tf.text = text
            })
            navigationController?.pushViewController(selectSkill, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return kHeight(56)
    }
}

// MARK: -点击按钮 & NoArrowEditCellDelegate
extension RecruitInformationViewController: YGPickerViewDelegate, BudgetPriceCellDelegate {

    override func tapRightButton(sender: UIButton) {
        let cell0 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! ArrowEditCell
        let cell1 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0)) as! NoArrowEditCell
        let cell2 = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0)) as! BudgetPriceCell
        if cell0.tf.text?.characters.count <= 0 {
            YKToast.makeText("请选择才艺类型")
            return
        } else if cell1.tf.text?.characters.count <= 0 {
            YKToast.makeText("请选择招募数量")
            return
        }
        let recruit = Recruit(skill: cell0.tf.text!, recruitCount: cell1.tf.text!, budgetPrice: cell2.tf.text)
        delegate.recruitInformationSureWithParams(recruit)
        navigationController?.popViewControllerAnimated(true)
    }
    
    func budgetPriceButtonTap(sender: UIButton) {
        pickerView.animation()
    }
    
    func pickerViewSelectedSure(sender: UIButton) {
        let skillUnit = pickerView.picker.delegate!.pickerView!(pickerView!.picker!, titleForRow: pickerView.picker.selectedRowInComponent(0), forComponent: 0)
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0)) as! BudgetPriceCell
        cell.button.selected = true
        guard let unit = skillUnit else { fatalError("picker skill unit nil") }
        cell.setButtonText(unit)
    }
}

extension RecruitInformationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return skillUnitPickerArray.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return skillUnitPickerArray[row]
    }
    
}