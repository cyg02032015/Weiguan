//
//  EditDataViewController.swift
//  OutLookers
//
//  Created by C on 16/7/14.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let headImgCellId = "headImgCellId"
private let noArrowEditCellId = "noArrowEditCellId"
private let arrowEditCellId = "arrowEditCellId"
private let phoneBindCellId = "phoneBindCellId"

class EditDataViewController: YGBaseViewController {

    lazy var provinceTitles = NSArray()
    lazy var skillUnitPickerArray = [String]()
    var cityPickerView: YGPickerView!
    var isProvincePicker = false  // 区分PickerView数据源
    var tableView: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        
        provinceTitles = CitiesData.sharedInstance().provinceTitle()
        skillUnitPickerArray = ["元/小时", "元/场", "元/次", "元/半天"]
        cityPickerView = YGPickerView(frame: CGRectZero, delegate: self)
        cityPickerView.delegate = self
        
    }
    
    func setupSubViews() {
        title = "编辑资料"
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(HeadImgCell.self, forCellReuseIdentifier: headImgCellId)
        tableView.registerClass(NoArrowEditCell.self, forCellReuseIdentifier: noArrowEditCellId)
        tableView.registerClass(ArrowEditCell.self, forCellReuseIdentifier: arrowEditCellId)
        tableView.registerClass(PhoneBindCell.self, forCellReuseIdentifier: phoneBindCellId)
        tableView.separatorStyle = .None
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
    }
}

extension EditDataViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 5
        } else if section == 2 {
            return 1
        } else {
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(headImgCellId, forIndexPath: indexPath) as! HeadImgCell
            cell.delegate = self
            return cell
        } else if indexPath.section == 1{
            if indexPath.row == 0 || indexPath.row == 4 {
                let cell = tableView.dequeueReusableCellWithIdentifier(noArrowEditCellId, forIndexPath: indexPath) as! NoArrowEditCell
                cell.indexPath = indexPath
                cell.label.textColor = UIColor(hex: 0x777777)
                if indexPath.row == 0 {
                    cell.setTextInCell("昵   称", placeholder: "请输入昵称")
                } else {
                    cell.setTextInCell("简   介", placeholder: "未填写")
                }
                return cell
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier(arrowEditCellId, forIndexPath: indexPath) as! ArrowEditCell
                cell.label.textColor = UIColor(hex: 0x777777)
                if indexPath.row == 1 {
                    cell.setTextInCell("常居地", placeholder: "请选择城市")
                } else if indexPath.row == 2 {
                    cell.setTextInCell("年   龄", placeholder: "请选择年龄")
                } else {
                    cell.setTextInCell("性   别", placeholder: "请选择性别")
                }
                return cell
            }
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCellWithIdentifier(phoneBindCellId, forIndexPath: indexPath) as! PhoneBindCell
            cell.delegate = self
            cell.setTextInCell("手机绑定", placeholder: "")
            cell.tf.text = "1534314123"
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(arrowEditCellId, forIndexPath: indexPath) as! ArrowEditCell
            cell.label.textColor = UIColor(hex: 0x777777)
            cell.setTextInCell("个人档案", placeholder: "")
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return kHeight(112)
        } else {
            return kHeight(46)
        }
    }
}

extension EditDataViewController: HeadImgCellDelegate, PhoneBindCellDelegate {
    func headImgTap(imgView: TouchImageView) {
        LogInfo("imgview = \(imgView)")
    }
    
    func phoneBindTapBind(sender: UIButton) {
        LogInfo("phone bind")
    }
}

extension EditDataViewController: YGPickerViewDelegate {
    func pickerViewSelectedSure(sender: UIButton, pickerView: YGPickerView) {
        let city = cityPickerView.picker.delegate!.pickerView!(cityPickerView!.picker!, titleForRow: cityPickerView.picker.selectedRowInComponent(1), forComponent: 1)
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 3, inSection: 0)) as! ArrowEditCell
        cell.tf.text = city
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension EditDataViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        if isProvincePicker {
            return 2
        } else {
            return 1
        }
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if isProvincePicker {
            if component == 0 {
                return provinceTitles.count
            } else {
                let province = provinceTitles[pickerView.selectedRowInComponent(0)]
                let cities = CitiesData.sharedInstance().citiesWithProvinceName(province as! String)
                return cities.count > 0 ? cities.count : 0
            }
        } else {
            return skillUnitPickerArray.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if isProvincePicker {
            if component == 0 {
                return (provinceTitles[row] as! String)
            } else {
                let province = provinceTitles[pickerView.selectedRowInComponent(0)]
                let cities = CitiesData.sharedInstance().citiesWithProvinceName(province as! String)
                return cities.count > row ? (cities[row] as! String) : ""
            }
        } else {
            return skillUnitPickerArray[row]
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if isProvincePicker {
            if component == 0 {
                pickerView.reloadComponent(1)
            }
        }
    }
}
