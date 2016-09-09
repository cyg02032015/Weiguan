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
private let workDetailCellId = "workDetailCellId"

class PersonFileViewController: YGBaseViewController {

    var sectionTitles = ["基本资料", "个人特征", "通告经验"]
    var sectionImages = ["data", "Features", "Announcement-1"]
    var save: UIButton!
    var tableView: UITableView!
    lazy var heights = [String]()
    lazy var weights = [String]()
    lazy var constellations = ["白羊座", "金牛座", "双子座", "巨蟹座", "狮子座", "处女座", "天秤座", "天蝎座", "射手座", "摩羯座", "水瓶座", "双鱼座"]
    var heightPickerView: YGPickerView!
    var weightPickerView: YGPickerView!
    var constellationPicerkView: YGPickerView!
    lazy var req = PersonFilesReq()
    
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
        loadData()
    }
    
    func loadData() {
        Server.showPersonFiles { (success, msg, value) in
            SVToast.dismiss()
            if success {
                guard let obj = value else {return}
                self.req.bust = obj.bust
                self.req.characteristics = obj.characteristics
                self.req.constellation = obj.constellation
                self.req.experience = obj.experience
                self.req.height = obj.height
                self.req.weight = obj.weight
                self.req.hipline = obj.hipline
                self.req.waist = obj.waist
                self.req.array = obj.array
                self.req.userId = "\(obj.id)"
                self.tableView.reloadData()
            } else {
                guard let m = msg else {return}
                SVToast.showWithError(m)
            }
        }
    }
    
    func setupSubViews() {
        title = "个人档案"
        
        save = setRightNaviItem()
        save.setTitle("保存", forState: .Normal)
        save.rx_tap.subscribeNext {
            SVToast.show()
            Server.personalFiles(self.req, handler: { (success, msg, value) in
                SVToast.dismiss()
                if success {
                    SVToast.showWithSuccess("保存成功")
                    delay(1) {
                    self.navigationController?.popViewControllerAnimated(true)
                    }
                } else {
                    guard let m = msg else {return}
                    SVToast.showWithError(m)
                }
            })
            LogInfo(self.req.characteristics)
        }.addDisposableTo(disposeBag)
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = kLineColor
        tableView.backgroundColor = kBackgoundColor
        tableView.registerClass(ArrowEditCell.self, forCellReuseIdentifier: arrowEditCellId)
        tableView.registerClass(BWHTableViewCell.self, forCellReuseIdentifier: bwhCellId)
        tableView.registerClass(PersonStyleCell.self, forCellReuseIdentifier: personStyleCellId)
        tableView.registerClass(WorkDetailCell.self, forCellReuseIdentifier: workDetailCellId)
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
    }
    
    func checkParameters() {
        if !isEmptyString(req.bust) && !isEmptyString(req.characteristics) && !isEmptyString(req.constellation) && !isEmptyString(req.experience) && !isEmptyString(req.height) && !isEmptyString(req.hipline) && !isEmptyString(req.waist) {
            save.setTitleColor(UIColor.blackColor(), forState: .Normal)
            save.userInteractionEnabled = true
        } else {
            save.setTitleColor(kGrayTextColor, forState: .Normal)
            save.userInteractionEnabled = false
        }
    }
}

extension PersonFileViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.req.userId == nil {
            return 0
        }
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
                    cell.tf.text = req.height
                } else if indexPath.row == 1 {
                    cell.setTextInCell("体重", placeholder: "请选择体重KG")
                    cell.tf.text = req.weight
                } else if indexPath.row == 3 {
                    cell.setTextInCell("星座", placeholder: "请选择星座")
                    cell.tf.text = req.constellation
                }
                return cell
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier(bwhCellId, forIndexPath: indexPath) as! BWHTableViewCell
                cell.delegate = self
                cell.bTF.text = req.bust
                cell.hTF.text = req.hipline
                cell.wTF.text = req.waist
                return cell
            }
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier(personStyleCellId, forIndexPath: indexPath) as! PersonStyleCell
            cell.info = req.array
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(workDetailCellId, forIndexPath: indexPath) as! WorkDetailCell
            cell.placeholderLabel.hidden = req.experience.characters.count > 0
            cell.tv.text = req.experience
            cell.delegate = self
            return cell
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
            return kHeight(100)
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

extension PersonFileViewController: PersonFileHeadViewDelegate, BWHCellDelegate, PersonCharacterDelegate, WorkDetailCellDelegate {
    func personFileTapEditButton(sender: UIButton) {
        let vc = PersonCharacterViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func characterSendValue(obj: [String : [PersonCharaterModel]]) {
        var style = ""
        var look = ""
        var shape = ""
        var charm = ""
        var arrays = [String]()
        var styles: [String] = ["1"]
        var looks: [String] = ["2"]
        var shapes: [String] = ["3"]
        var charms: [String] = ["4"]
        if let arr = obj["1"] {
            arr.forEach({ (item) in
                styles.append("\(item.id)")
            })
            style = styles.joinWithSeparator(",")
            arrays.append(style)
        }
        if let arr = obj["2"] {
            arr.forEach({ (item) in
                looks.append("\(item.id)")
            })
            look = looks.joinWithSeparator(",")
            arrays.append(look)
        }
        if let arr = obj["3"] {
            arr.forEach({ (item) in
                shapes.append("\(item.id)")
            })
            shape = shapes.joinWithSeparator(",")
            arrays.append(shape)
        }
        if let arr = obj["4"] {
            arr.forEach({ (item) in
                charms.append("\(item.id)")
            })
            charm = charms.joinWithSeparator(",")
            arrays.append(charm)
        }
        req.characteristics = arrays.joinWithSeparator(".")
        checkParameters()
    }
    
    func bwhCellTextFieldEndEdting(textField: UITextField) {
        if textField.tag == bTag {
            req.bust = textField.text
        } else if textField.tag == wTag {
            req.waist = textField.text
        } else {
            req.hipline = textField.text
        }
        checkParameters()
    }
    
    func workDetailCellReturnText(text: String) {
        req.experience = text
        checkParameters()
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
    
    func pickerViewSelectedSure(sender: UIButton, pickerView: UIPickerView) {
        let text = pickerView.delegate!.pickerView!(pickerView, titleForRow: pickerView.selectedRowInComponent(0), forComponent: 0)
        if pickerView == heightPickerView.picker {
            let cell = tableView.cellForRowAt(0, row: 0) as! ArrowEditCell
            cell.tf.text = text
            req.height = text
        } else if pickerView == weightPickerView.picker {
            let cell = tableView.cellForRowAt(0, row: 1) as! ArrowEditCell
            cell.tf.text = text
            req.weight = text
        } else {
            let cell = tableView.cellForRowAt(0, row: 3) as! ArrowEditCell
            cell.tf.text = text
            req.constellation = text
        }
        checkParameters()
    }
}
