//
//  PersonFileViewController.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/14.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let arrowEditCellId = "arrowEditCellId"
private let bwhCellId = "bwhCellId"
private let personStyleCellId = "personStyleCellId"

private extension Selector {
    static let tapCommit = #selector(PersonFileViewController.tapCommit(_:))
}

class PersonFileViewController: YGBaseViewController {

    var sectionTitles = ["基本资料", "个人特征", "通告经验"]
    var sectionImages = ["data", "Features", "Announcement-1"]
    var commitButton: UIButton!
    var tableView: UITableView!
    lazy var personFile = PersonFile()
    lazy var heights = [String]()
    lazy var weights = [String]()
    lazy var constellations = ["白羊座", "金牛座", "双子座", "巨蟹座", "狮子座", "处女座", "天秤座", "天蝎座", "射手座", "摩羯座", "水瓶座", "双鱼座"]
    var heightPickerView: YGPickerView!
    var weightPickerView: YGPickerView!
    var constellationPicerkView: YGPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 100...220 {
            heights.append("\(i)")
        }
        for i in 20...150 {
            weights.append("\(i)")
        }
        heightPickerView = YGPickerView(frame: CGRectZero, delegate: self)
        heightPickerView.delegate = self
        weightPickerView = YGPickerView(frame: CGRectZero, delegate: self)
        weightPickerView.delegate = self
        constellationPicerkView = YGPickerView(frame: CGRectZero, delegate: self)
        constellationPicerkView.delegate = self
        setupSubViews()
    }
    
    func setupSubViews() {
        title = "个人档案"
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = kLineColor
        tableView.backgroundColor = kBackgoundColor
        tableView.registerClass(ArrowEditCell.self, forCellReuseIdentifier: arrowEditCellId)
        tableView.registerClass(BWHTableViewCell.self, forCellReuseIdentifier: bwhCellId)
        tableView.registerClass(PersonStyleCell.self, forCellReuseIdentifier: personStyleCellId)
        view.addSubview(tableView)
        
        commitButton = Util.createReleaseButton("提交")
        commitButton.addTarget(self, action: .tapCommit, forControlEvents: .TouchUpInside)
        view.addSubview(commitButton)
        commitButton.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(commitButton.superview!)
            make.height.equalTo(kScale(44))
        }
        
        
        tableView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(tableView.superview!)
            make.bottom.equalTo(commitButton.snp.top)
        }
    }
    
    func tapCommit(sender: UIButton) {
        LogInfo(personFile)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension PersonFileViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        } else {
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row != 2 {
                let cell = tableView.dequeueReusableCellWithIdentifier(arrowEditCellId, forIndexPath: indexPath) as! ArrowEditCell
                cell.tf.font = UIFont.customFontOfSize(16)
                cell.label.font = UIFont.customFontOfSize(16)
                cell.label.textColor = UIColor(hex: 0x777777)
                if indexPath.row == 0 {
                    cell.setTextInCell("身高", placeholder: "请选择身高CM")
                } else if indexPath.row == 1 {
                    cell.setTextInCell("体重", placeholder: "请选择体重KG")
                } else if indexPath.row == 3 {
                    cell.setTextInCell("星座", placeholder: "请选择星座")
                }
                return cell
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier(bwhCellId, forIndexPath: indexPath) as! BWHTableViewCell
                cell.delegate = self
                return cell
            }
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier(personStyleCellId, forIndexPath: indexPath) as! PersonStyleCell
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                heightPickerView.picker.reloadAllComponents()
                heightPickerView.animation()
            } else if indexPath.row == 1 {
                weightPickerView.picker.reloadAllComponents()
                weightPickerView.animation()
            } else if indexPath.row == 3 {
                constellationPicerkView.picker.reloadAllComponents()
                constellationPicerkView.animation()
            }
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return kHeight(46)
        } else if indexPath.section == 1 {
            return kHeight(124)
        } else {
            return kHeight(79)
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = PersonFileHeadView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: kScale(46)))
        view.delegate = self
        view.section = section
        view.imgView.image = UIImage(named: sectionImages[section])
        view.label.text = sectionTitles[section]
        if section == 1 {
            view.editButton.hidden = false
        } else {
            view.editButton.hidden = true
        }
        return view
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kHeight(46)
    }
}

extension PersonFileViewController: PersonFileHeadViewDelegate, BWHCellDelegate {
    func personFileTapEditButton(sender: UIButton) {
        LogInfo("section = \(sender.tag)")
    }
    
    func bwhCellTextFieldEndEdting(textField: UITextField) {
        if textField.tag == bTag {
            personFile.bust = textField.text
        } else if textField.tag == wTag {
            personFile.waist = textField.text
        } else {
            personFile.hipline = textField.text
        }
    }
}

extension PersonFileViewController: UIPickerViewDelegate, UIPickerViewDataSource, YGPickerViewDelegate {
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == heightPickerView.picker {
            return heights.count
        } else if pickerView == weightPickerView.picker {
            return weights.count
        } else {
            return constellations.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == heightPickerView.picker {
            return heights[row]
        } else if pickerView == weightPickerView.picker {
            return weights[row]
        } else {
            return constellations[row]
        }
    }
    
    func pickerViewSelectedSure(sender: UIButton, pickerView: YGPickerView) {
        let text = pickerView.picker.delegate!.pickerView!(pickerView.picker, titleForRow: pickerView.picker.selectedRowInComponent(0), forComponent: 0)
        if pickerView == heightPickerView {
            let cell = tableView.cellForRowAt(0, row: 0) as! ArrowEditCell
            cell.tf.text = text
            personFile.height = text
        } else if pickerView == weightPickerView {
            let cell = tableView.cellForRowAt(0, row: 1) as! ArrowEditCell
            cell.tf.text = text
            personFile.weight = text
        } else {
            let cell = tableView.cellForRowAt(0, row: 3) as! ArrowEditCell
            cell.tf.text = text
            personFile.constellation = text
        }
    }
}
