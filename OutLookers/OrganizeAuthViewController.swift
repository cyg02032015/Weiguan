//
//  OrganizeAuthViewController.swift
//  OutLookers
//
//  Created by C on 16/7/17.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let noarrowCellId = "noarrowCellId"
private let businessLicenceId = "businessLicenceId"

private extension Selector {
    static let tapCommit = #selector(OrganizeAuthViewController.tapCommit(_:))
}

class OrganizeAuthViewController: YGBaseViewController {

    var tableView: UITableView!
    var typePickerView: YGPickerView!
    lazy var types = ["演出公司", "经纪公司", "唱片公司", "演出器材", "模特公司", "婚庆礼仪公司", "影视公司", "影视制作", "娱乐场所", "演出场馆", "剧组", "培训机构", "文化公司", "排练室", "录音棚", "乐器行", "发行公司", "工作室", "其他"]
    var pickerView: YGPickerView!
    lazy var provinceTitles = NSArray()
    var imgButton: TouchImageView!
    var desc: UILabel!
    var commitButton: UIButton!
    lazy var organizeRequest = OrganizeRequest()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        provinceTitles = CitiesData.sharedInstance().provinceTitle()
        pickerView = YGPickerView(frame: CGRectZero, delegate: self)
        pickerView.delegate = self
        typePickerView = YGPickerView(frame: CGRectZero, delegate: self)
        typePickerView.delegate = self
    }

    func setupSubViews() {
        title = "机构认证"
        tableView = UITableView()
        tableView.backgroundColor = kBackgoundColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(NoArrowEditCell.self, forCellReuseIdentifier: noarrowCellId)
        tableView.registerClass(BusinessLicenceCell.self, forCellReuseIdentifier: businessLicenceId)
        tableView.separatorStyle = .None
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        
        commitButton = Util.createReleaseButton("提交")
        commitButton.userInteractionEnabled = true
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
        YKToast.show("正在提交")
        Server.organizationAuth(organizeRequest) { [unowned self](success, msg, value) in
            YKToast.dismiss()
            if success {
                LogInfo(value!)
                self.navigationController?.popToRootViewControllerAnimated(true)
            } else {
                LogError(msg!)
            }
        }
    }
    
    func checkRequest() {
        // TODO
        if !isEmptyString(UserSingleton.sharedInstance.userId) && !isEmptyString(organizeRequest.type) && !isEmptyString(organizeRequest.name) && !isEmptyString(organizeRequest.license) && !isEmptyString(organizeRequest.adds) && !isEmptyString(organizeRequest.linkman) && !isEmptyString(organizeRequest.phone) {
            if !isEmptyString(organizeRequest.photo) {
                self.commitButton.userInteractionEnabled = true
                self.commitButton.backgroundColor = kCommonColor
            }
        } else {
            self.commitButton.userInteractionEnabled = false
            self.commitButton.backgroundColor = kGrayColor
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension OrganizeAuthViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 6 {
            let cell = tableView.dequeueReusableCellWithIdentifier(businessLicenceId, forIndexPath: indexPath) as! BusinessLicenceCell
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(noarrowCellId, forIndexPath: indexPath) as! NoArrowEditCell
            cell.label.textColor = UIColor(hex: 0x666666)
            cell.label.font = UIFont.customFontOfSize(14)
            cell.indexPath = indexPath
            cell.delegate = self
            if indexPath.row == 0 {
                cell.textFieldEnable = false
                cell.setTextInCell("机构类型", placeholder: "请选择机构类型")
            } else if indexPath.row == 1 {
                cell.setTextInCell("机构名称", placeholder: "请输入营业执照上的机构名称")
            } else if indexPath.row == 2 {
                cell.setTextInCell("注册号", placeholder: "请输入营业执照注册号")
            } else if indexPath.row == 3 {
                cell.textFieldEnable = false
                cell.setTextInCell("所在地", placeholder: "请选择机构所在地")
            } else if indexPath.row == 4 {
                cell.setTextInCell("联系人名称", placeholder: "请输入机构联系人名称")
            } else {
                cell.setTextInCell("联系人电话", placeholder: "请输入机构联系人电话")
            }
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.view.endEditing(true)
        if indexPath.row == 0 {
            typePickerView.animation()
        }
        if indexPath.row == 3 {
            pickerView.animation()
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row != 6 {
            return kHeight(43)
        } else {
            return kHeight(250)
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kScale(10)
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}

extension OrganizeAuthViewController: BusinessLicenceCellDelegate, NoArrowEditCellDelegate {
    
    func noarrowCellReturnText(text: String?, tuple: (section: Int, row: Int)) {
        switch tuple {
        case (0,1): organizeRequest.name = text
        case (0,2): organizeRequest.license = text
        case (0,4): organizeRequest.linkman = text
        case (0,5): organizeRequest.phone = text
        default: ""
        }
        checkRequest()
    }
    
    func businessLicenceTapImgButton(sender: TouchImageView, desc: UILabel) {
        self.imgButton = sender
        self.desc = desc
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
}

// MARK: - UIImagePickerControllerDelegate
extension OrganizeAuthViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let originalImg = info["UIImagePickerControllerOriginalImage"] as! UIImage
        self.dismissViewControllerAnimated(true, completion: nil)
        originalImg.resetSizeOfImageData(originalImg, maxSize: 500) { [unowned self](data) in
            self.desc.hidden = true
            self.imgButton.image = UIImage(data: data)
            // TODO
            self.organizeRequest.photo = "1"
            self.checkRequest()
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true) { }//TODO
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension OrganizeAuthViewController: UIPickerViewDelegate, UIPickerViewDataSource, YGPickerViewDelegate {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        if pickerView == typePickerView.picker {
            return 1
        } else {
            return 2
        }
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == typePickerView.picker {
            return types.count
        } else {
            if component == 0 {
                return provinceTitles.count
            } else {
                let province = provinceTitles[pickerView.selectedRowInComponent(0)]
                let cities = CitiesData.sharedInstance().citiesWithProvinceName(province as! String)
                return cities.count > 0 ? cities.count : 0
            }
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == typePickerView.picker {
            return types[row]
        } else {
            if component == 0 {
                return (provinceTitles[row] as! String)
            } else {
                let province = provinceTitles[pickerView.selectedRowInComponent(0)]
                let cities = CitiesData.sharedInstance().citiesWithProvinceName(province as! String)
                return cities.count > row ? (cities[row] as! String) : ""
            }
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == self.pickerView.picker {
            if component == 0 {
                pickerView.reloadComponent(1)
            }
        }
    }
    
    func pickerViewSelectedSure(sender: UIButton, pickerView: UIPickerView) {
        if pickerView == typePickerView.picker {
            let type = pickerView.delegate!.pickerView!(pickerView, titleForRow: pickerView.selectedRowInComponent(0), forComponent: 0)
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! NoArrowEditCell
            cell.tf.text = type
            organizeRequest.type = type
        } else {
            let city = pickerView.delegate!.pickerView!(pickerView, titleForRow: pickerView.selectedRowInComponent(1), forComponent: 1)
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 3, inSection: 0)) as! NoArrowEditCell
            cell.tf.text = city
            organizeRequest.adds = city
        }
        checkRequest()
    }
}