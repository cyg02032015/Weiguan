//
//  InvitationDetailViewController.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/22.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let invitationHeadCellId = "invitationHeadCellId"
private let invitationAddCellId = "invitationAddCellId"
private let invitationTalentCellId = "invitationTalentCellId"
private let invitationCircularCellId = "invitationCircularCellId"

class InvitationDetailViewController: YGBaseViewController {

    var tableView: UITableView!
    var circularPicker: YGPickerView!
    var jobPicker: YGPickerView!
    var talentPicker: YGPickerView!
    var toolView: InvitationToolView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }
    
    func setupSubViews() {
        title = "邀约"
        
        toolView = InvitationToolView()
        view.addSubview(toolView)
        toolView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(toolView.superview!)
            make.height.equalTo(kScale(44))
        }
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.tableFooterView = UIView()
        tableView.registerClass(InvitationHeadCell.self, forCellReuseIdentifier: invitationHeadCellId)
        tableView.registerClass(InvitationAddCell.self, forCellReuseIdentifier: invitationAddCellId)
        tableView.registerClass(InvitationTalentCell.self, forCellReuseIdentifier: invitationTalentCellId)
        tableView.registerClass(InvitationCircularCell.self, forCellReuseIdentifier: invitationCircularCellId)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(tableView.superview!)
            make.bottom.equalTo(toolView.snp.top)
        }
        
        circularPicker = YGPickerView(frame: CGRectZero, delegate: self)
        circularPicker.delegate = self
        circularPicker.title = "选择通告"
        
        jobPicker = YGPickerView(frame: CGRectZero, delegate: self)
        jobPicker.delegate = self
        jobPicker.title = "选择工作类型"
        
        talentPicker = YGPickerView(frame: CGRectZero, delegate: self)
        talentPicker.delegate = self
        talentPicker.title = "选择才艺"
    }
}

extension InvitationDetailViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else {
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(invitationHeadCellId, forIndexPath: indexPath) as! InvitationHeadCell
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier(invitationCircularCellId, forIndexPath: indexPath) as! InvitationCircularCell
//            let cell = tableView.dequeueReusableCellWithIdentifier(invitationAddCellId, forIndexPath: indexPath) as! InvitationAddCell
//            cell.addButton.setTitle("添加通告", forState: .Normal)
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(invitationTalentCellId, forIndexPath: indexPath) as! InvitationTalentCell
            cell.delegate = self
//            let cell = tableView.dequeueReusableCellWithIdentifier(invitationAddCellId, forIndexPath: indexPath) as! InvitationAddCell
//            cell.addButton.setTitle("添加才艺", forState: .Normal)
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            circularPicker.animation()
        } else if indexPath.section == 2 {
            talentPicker.animation()
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return kHeight(115)
        } else if indexPath.section == 1 {
            return kHeight(83)
//            return kHeight(60)
        } else {
            return kHeight(83)
//            return kHeight(60)
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.01
        } else {
            return kHeight(44)
        }
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 2 {
            return 0.01
        } else {
            return kHeight(10)
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        let label = UILabel.createLabel(16, textColor: UIColor(hex: 0x666666))
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(label.superview!).offset(kScale(15))
            make.centerY.equalTo(label.superview!)
        }
        if section == 1 {
            label.text = "添加通告（选填）"
        } else if section == 2 {
            label.text = "购买才艺"
        }
        return view
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .Delete
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        LogInfo("commit editing")
    }
}

extension InvitationDetailViewController: UIPickerViewDelegate, UIPickerViewDataSource, YGPickerViewDelegate {
    func pickerViewSelectedSure(sender: UIButton, pickerView: UIPickerView) {
        if pickerView == circularPicker.picker {
            delay(0.5) { [unowned self] in
                self.jobPicker.animation()
            }
        }
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
}

extension InvitationDetailViewController: InvitationTalentCellDelegate {
    func invitationTalentTapMinus(sender: UIButton, count: Int) {
        LogInfo("\(count)")
    }
    
    func invitationTalentTapPlush(sender: UIButton, count: Int) {
        LogError("\(count)")
    }
}