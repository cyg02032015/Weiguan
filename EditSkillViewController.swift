//
//  EditSkillViewController.swift
//  OutLookers
//
//  Created by C on 16/6/21.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let noArrowIdentifier = "noArrowId"
private let arrowIdentifier = "arrowId"
private let workDetailIdentifier = "workDetailId"
private let skillSetIdentifier = "skillSetId"

private extension Selector {
    static let tapRelease = #selector(ReleaseNoticeViewController.tapRelease(_:))
}

class EditSkillViewController: YGBaseViewController {

    var tableView: UITableView!
    var releaseButton: UIButton!
    var selectDatePicker: YGSelectDateView!
    var pickerView: YGPickerView!
    lazy var recruits: [Recruit] = [Recruit]()
    lazy var provinceTitles = NSArray()
    var photoArray: [UIImage]!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        selectDatePicker = YGSelectDateView()
        UIApplication.sharedApplication().keyWindow!.addSubview(selectDatePicker)
        selectDatePicker.hidden = true
        selectDatePicker.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(selectDatePicker.superview!)
        }
        
        provinceTitles = CitiesData.sharedInstance().provinceTitle()
        pickerView = YGPickerView(frame: CGRectZero, delegate: self)
        pickerView.delegate = self
        UIApplication.sharedApplication().keyWindow!.addSubview(pickerView)
        pickerView.hidden = true
        pickerView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(pickerView.superview!)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if selectDatePicker != nil {
            selectDatePicker.removeFromSuperview()
            selectDatePicker = nil
        }
        
        if pickerView != nil {
            pickerView.removeFromSuperview()
            pickerView = nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "编辑才艺"
        setupSubViews()
    }
    
    func setupSubViews() {
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.registerClass(NoArrowEditCell.self, forCellReuseIdentifier: noArrowIdentifier)
        tableView.registerClass(ArrowEditCell.self, forCellReuseIdentifier: arrowIdentifier)
        tableView.registerClass(WorkDetailCell.self, forCellReuseIdentifier: workDetailIdentifier)
        tableView.registerClass(SkillSetCell.self, forCellReuseIdentifier: skillSetIdentifier)
        
        releaseButton = UIButton()
        releaseButton.setTitle("发布", forState: .Normal)
        releaseButton.titleLabel?.font = UIFont.systemFontOfSize(16)
        releaseButton.addTarget(self, action: .tapRelease, forControlEvents: .TouchUpInside)
        releaseButton.backgroundColor = kGrayColor
        view.addSubview(releaseButton)
        
        releaseButton.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(releaseButton.superview!)
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(tableView.superview!)
            make.top.equalTo(self.snp.topLayoutGuideBottom)
            make.bottom.equalTo(releaseButton.snp.top)
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension EditSkillViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier(noArrowIdentifier, forIndexPath: indexPath) as! NoArrowEditCell
                cell.textFieldEnable = false
                cell.setTextInCell("才艺类型", placeholder: "")
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCellWithIdentifier(noArrowIdentifier, forIndexPath: indexPath) as! NoArrowEditCell
                cell.delegate = self
                cell.setTextInCell("才艺名称", placeholder: "请输入才艺名称")
                return cell
            } else if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCellWithIdentifier(arrowIdentifier, forIndexPath: indexPath) as! ArrowEditCell
                cell.setTextInCell("才艺标价", placeholder: "请输入才艺标价  元/小时")
                return cell
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier(arrowIdentifier, forIndexPath: indexPath) as! ArrowEditCell
                cell.setTextInCell("服务地区 (选填)", placeholder: "请选择所在地区")
                return cell
            }
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier(workDetailIdentifier, forIndexPath: indexPath) as! WorkDetailCell
            cell.setTextInCell("才艺详情", placeholder: "请输入与您才艺相关的介绍")
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(skillSetIdentifier, forIndexPath: indexPath) as! SkillSetCell
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 2 { // 才艺标价
//                let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 2)) as! ArrowEditCell
//                selectDatePicker.animation()
//                selectDatePicker.tapSureClosure({ (date) in
//                    cell.tf.text = date.stringFromDate()
//                })
            }
            if indexPath.row == 3 {
                pickerView.animation()
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 4
        case 1: return 1
        case 2: return 1
        default: return 1
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 1: return 193 // 才艺详情
        case 0: return 56
        case 2: return 514
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 5 {
            return 0
        }
        return 10
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
}

extension EditSkillViewController: YGPickerViewDelegate, NoArrowEditCellDelegate {
    func pickerViewSelectedSure(sender: UIButton) {
        let city = pickerView.pickerView.delegate!.pickerView!(pickerView!.pickerView!, titleForRow: pickerView.pickerView.selectedRowInComponent(1), forComponent: 1)
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 3, inSection: 0)) as! ArrowEditCell
        cell.tf.text = city
    }
    
    func noArrowEditCellCheckText(text: String?) {
        
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension EditSkillViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return provinceTitles.count
        } else {
            let province = provinceTitles[pickerView.selectedRowInComponent(0)]
            let cities = CitiesData.sharedInstance().citiesWithProvinceName(province as! String)
            return cities.count > 0 ? cities.count : 0
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return (provinceTitles[row] as! String)
        } else {
            let province = provinceTitles[pickerView.selectedRowInComponent(0)]
            let cities = CitiesData.sharedInstance().citiesWithProvinceName(province as! String)
            return cities.count > row ? (cities[row] as! String) : ""
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            pickerView.reloadComponent(1)
        }
    }
}
