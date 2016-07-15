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

private extension Selector {
    static let tapSaveButton = #selector(EditDataViewController.tapSaveButton(_:))
}

class EditDataViewController: YGBaseViewController {

    lazy var provinceTitles = NSArray()
    var cityPickerView: YGPickerView!
    var ageDatePickerView: YGSelectDateView!
    var tableView: UITableView!
    var headImgView: TouchImageView!
    var save: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        
        provinceTitles = CitiesData.sharedInstance().provinceTitle()
        cityPickerView = YGPickerView(frame: CGRectZero, delegate: self)
        cityPickerView.delegate = self
        ageDatePickerView = YGSelectDateView()
        ageDatePickerView.datePicker.datePickerMode = .Date
        
    }
    
    func setupSubViews() {
        title = "编辑资料"
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = kBackgoundColor
        tableView.registerClass(HeadImgCell.self, forCellReuseIdentifier: headImgCellId)
        tableView.registerClass(NoArrowEditCell.self, forCellReuseIdentifier: noArrowEditCellId)
        tableView.registerClass(ArrowEditCell.self, forCellReuseIdentifier: arrowEditCellId)
        tableView.registerClass(PhoneBindCell.self, forCellReuseIdentifier: phoneBindCellId)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
    }
    
    func tapSaveButton(sender: UIButton) {
        LogInfo("save button click")
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            if indexPath.row == 1 {
                cityPickerView.animation()
            } else if indexPath.row == 2 {
                let cell = tableView.cellForRowAtIndexPath(indexPath) as! ArrowEditCell
                ageDatePickerView.animation()
                ageDatePickerView.tapSureClosure({ [unowned cell](date) in
                    cell.tf.text = "\(date)"
                })
            } else {
                let cell = tableView.cellForRowAtIndexPath(indexPath) as! ArrowEditCell
                let sheet = UIAlertController(title: "请选择性别", message: nil, preferredStyle: .ActionSheet)
                let male = UIAlertAction(title: "男", style: .Default, handler: { [unowned cell](action) in
                    cell.tf.text = action.title
                })
                let female = UIAlertAction(title: "女", style: .Default, handler: { [unowned cell](action) in
                    cell.tf.text = action.title
                })
                let cancel = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
                sheet.addAction(male)
                sheet.addAction(female)
                sheet.addAction(cancel)
                presentViewController(sheet, animated: true, completion: nil)
            }
        } else if indexPath.section == 3 {
            let vc = PersonFileViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return kHeight(112)
        } else {
            return kHeight(46)
        }
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 3 {
            return kHeight(144)
        } else {
            return kHeight(10)
        }
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 3 {
            let view = UIView(frame: CGRect(origin: CGPointZero, size: CGSize(width: ScreenWidth, height: kScale(144))))
            view.backgroundColor = kBackgoundColor
            save = UIButton()
            save.setTitle("保存", forState: .Normal)
            save.titleLabel!.font = UIFont.customFontOfSize(16)
            save.backgroundColor = kButtonGrayColor
            save.layer.cornerRadius = kScale(40/2)
            save.addTarget(self, action: .tapSaveButton, forControlEvents: .TouchUpInside)
            view.addSubview(save)
            save.snp.makeConstraints { (make) in
                make.left.equalTo(save.superview!).offset(kScale(37))
                make.right.equalTo(save.superview!).offset(kScale(-37))
                make.top.equalTo(save.superview!).offset(kScale(54))
                make.height.equalTo(kScale(40))
            }
            return view
        } else {
            let view = UIView(frame: CGRect(origin: CGPointZero, size: CGSize(width: ScreenWidth, height: kHeight(10))))
            view.backgroundColor = kBackgoundColor
            return view
        }
    }
}

// MARK: - HeadImgCellDelegate, PhoneBindCellDelegate
extension EditDataViewController: HeadImgCellDelegate, PhoneBindCellDelegate {
    func headImgTap(imgView: TouchImageView) {
        self.headImgView = imgView
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        let camera = UIAlertAction(title: "拍照", style: .Default, handler: { (action) in
            let vc = Util.actionSheetImagePicker(isCamera: true)
            guard let v = vc else { return }
            v.delegate = self
            self.presentViewController(v, animated: true, completion: nil)
        })
        let library = UIAlertAction(title: "从相册中选取", style: .Default, handler: { (action) in
            let vc = Util.actionSheetImagePicker(isCamera: false)
            guard let v = vc else { return }
            v.delegate = self
            self.presentViewController(v, animated: true, completion: nil)
        })
        let cancel = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
        sheet.addAction(camera)
        sheet.addAction(library)
        sheet.addAction(cancel)
        self.presentViewController(sheet, animated: true, completion: nil)

    }
    
    func phoneBindTapBind(sender: UIButton) {
        LogInfo("phone bind")
    }
}

// MARK: - UIImagePickerControllerDelegate
extension EditDataViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        LogInfo(info)
        let originalImg = info["UIImagePickerControllerEditedImage"] as! UIImage
        self.dismissViewControllerAnimated(true, completion: nil)
        originalImg.resetSizeOfImageData(originalImg, maxSize: 300) { [unowned self](data) in
            self.headImgView.image = UIImage(data: data)
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true) { }//TODO
    }
}

// MARK: - YGPickerViewDelegate
extension EditDataViewController: YGPickerViewDelegate {
    func pickerViewSelectedSure(sender: UIButton, pickerView: YGPickerView) {
        let city = cityPickerView.picker.delegate!.pickerView!(pickerView.picker, titleForRow: cityPickerView.picker.selectedRowInComponent(1), forComponent: 1)
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 1)) as! ArrowEditCell
        cell.tf.text = city
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension EditDataViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
