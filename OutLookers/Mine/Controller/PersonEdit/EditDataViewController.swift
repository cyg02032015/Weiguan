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
class EditDataViewController: YGBaseViewController {

    lazy var provinceTitles = NSArray()
    var cityPickerView: YGPickerView!
    var ageDatePickerView: YGSelectDateView!
    var tableView: UITableView!
    var headImgView: TouchImageView!
    var save: UIButton!
    lazy var cityResp = YGCityData.loadCityData()
    var provinceInt = 0
    lazy var req = EditDataReq()
    var headImgData: NSData?
    var picToken: GetToken!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        checkParameters()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getToken()
        setupSubViews()
        cityPickerView = YGPickerView(frame: CGRectZero, delegate: self)
        cityPickerView.delegate = self
        ageDatePickerView = YGSelectDateView()
        ageDatePickerView.maximumDate = NSDate()
        ageDatePickerView.datePicker.datePickerMode = .Date
        loadData()
    }
    
    func getToken() {
        Server.getUpdateFileToken(.Picture) { (success, msg, value) in
            if success {
                guard let obj = value else {return}
                self.picToken = obj
            } else {
                guard let m = msg else {return}
                SVToast.showWithError(m)
            }
        }
    }
    
    func loadData() {
        SVToast.show()
        Server.showInformation { (success, msg, value) in
            SVToast.dismiss()
            if success {
                guard let obj = value else {return}
                self.req.birthday = obj.birthday
                self.req.city = obj.city
                self.req.headImgUrl = obj.headImgUrl
                self.req.introduction = obj.introduction
                self.req.nickname = obj.nickname
                self.req.province = obj.province
                self.req.sex = obj.sex
                self.req.id = "\(obj.id)"
                self.tableView.reloadData()
            } else {
                guard let m = msg else {return}
                SVToast.showWithError(m)
            }
        }
    }
    
    func setupSubViews() {
        title = "编辑资料"
        
        save = setRightNaviItem()
        save.setTitle("保存", forState: .Normal)
        // MARK: 保存按钮
        save.rx_controlEvent(.TouchUpInside).subscribeNext { [weak self] in
            if self!.headImgData == nil {
                Server.informationUpdate(self!.req, handler: { (success, msg, value) in
                    SVToast.dismiss()
                    if success {
                        SVToast.showWithSuccess(value!)
                        delay(1) {
                            self!.navigationController?.popViewControllerAnimated(true)
                        }
                    } else {
                        guard let m = msg else {return}
                        SVToast.showWithError(m)
                    }
                })
                return
            }
            let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
            let group = dispatch_group_create()
            SVToast.show()
            dispatch_group_async(group, queue) {
                dispatch_group_enter(group)
                guard let _ = self else { return }
                guard let token = self?.picToken else { return }
                OSSImageUploader.asyncUploadImageData(token, data: self!.headImgData!, progress: nil, complete: { (names, state) in
                    if state == .Success {
                        self!.req.headImgUrl = names.first
                        dispatch_group_leave(group)
                    } else {
                        self!.req.headImgUrl = ""
                        SVToast.dismiss()
                        SVToast.showWithError("上传头像失败")
                        dispatch_group_leave(group)
                    }
                })
            }
            dispatch_group_notify(group, queue, { 
                Server.informationUpdate(self!.req, handler: { (success, msg, value) in
                    SVToast.dismiss()
                    if success {
                        SVToast.showWithSuccess(value!)
                        delay(1) {
                            self!.navigationController?.popViewControllerAnimated(true)
                        }
                    } else {
                        guard let m = msg else {return}
                        SVToast.showWithError(m)
                    }
                })
            })
        }.addDisposableTo(disposeBag)
        
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = kBackgoundColor
        tableView.registerClass(HeadImgCell.self, forCellReuseIdentifier: headImgCellId)
        tableView.registerClass(NoArrowEditCell.self, forCellReuseIdentifier: noArrowEditCellId)
        tableView.registerClass(ArrowEditCell.self, forCellReuseIdentifier: arrowEditCellId)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
    }
    
    func checkParameters() {
        if !isEmptyString(req.sex) && !isEmptyString(req.nickname) && !isEmptyString(req.birthday) && !isEmptyString(req.province) && !isEmptyString(req.city) {
            save.setTitleColor(UIColor.blackColor(), forState: .Normal)
            save.enabled = true
        } else {
            save.setTitleColor(kGrayTextColor, forState: .Normal)
            save.alpha = 0.5
            save.enabled = false
        }
    }
}

extension EditDataViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.req.id == nil {
            return 0
        }
        if section == 0 {
            return 1
        } else if section == 1 {
            return 5
        } else {
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(headImgCellId, forIndexPath: indexPath) as! HeadImgCell
            cell.delegate = self
            cell.info = self.req.headImgUrl
            return cell
        } else if indexPath.section == 1{
            if indexPath.row == 0 || indexPath.row == 4 {
                let cell = tableView.dequeueReusableCellWithIdentifier(noArrowEditCellId, forIndexPath: indexPath) as! NoArrowEditCell
                cell.indexPath = indexPath
                cell.delegate = self
                cell.label.textColor = UIColor(hex: 0x777777)
                if indexPath.row == 0 {
                    cell.setTextInCell("昵   称", placeholder: "请输入昵称")
                    cell.tf.text = self.req.nickname
                } else {
                    cell.setTextInCell("签名档", placeholder: "未填写")
                    cell.tf.text = self.req.introduction
                }
                return cell
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier(arrowEditCellId, forIndexPath: indexPath) as! ArrowEditCell
                cell.label.textColor = UIColor(hex: 0x777777)
                if indexPath.row == 1 {
                    cell.setTextInCell("常居地", placeholder: "请选择城市")
                    if req.province == "不限" {
                        cell.tf.text = req.province
                    } else {
                        cell.tf.text = "\(req.province) \(req.city)"
                    }
                } else if indexPath.row == 2 {
                    cell.setTextInCell("年   龄", placeholder: "请选择年龄")
                    cell.tf.text = req.birthday.dateFromString("yyyy-MM-dd")?.ageWithDateOfBirth()
                } else {
                    cell.setTextInCell("性   别", placeholder: "请选择性别")
                    if req.sex == SexType.Male.rawValue {
                        cell.tf.text = "男"
                    } else if req.sex == SexType.Female.rawValue {
                        cell.tf.text = "女"
                    } else {
                        cell.tf.text = "未知"
                    }
                }
                return cell
            }
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
                ageDatePickerView.tapSureClosure({ [unowned cell, unowned self](date) in
                    cell.tf.text = date.ageWithDateOfBirth()
                    self.req.birthday = date.stringFromDateWith("yyyy-MM-dd")
                    self.checkParameters()
                })
            } else {
                let cell = tableView.cellForRowAtIndexPath(indexPath) as! NoArrowEditCell
                let sheet = UIAlertController(title: "请选择性别", message: nil, preferredStyle: .ActionSheet)
                let male = UIAlertAction(title: "男", style: .Default, handler: { [unowned cell](action) in
                    cell.tf.text = action.title
                    self.req.sex = SexType.Male.rawValue
                    self.checkParameters()
                })
                let female = UIAlertAction(title: "女", style: .Default, handler: { [unowned cell](action) in
                    cell.tf.text = action.title
                    self.req.sex = SexType.Female.rawValue
                    self.checkParameters()
                })
                let cancel = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
                sheet.addAction(male)
                sheet.addAction(female)
                sheet.addAction(cancel)
                presentViewController(sheet, animated: true, completion: nil)
            }
        } else if indexPath.section == 2 {
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
}

// MARK: - HeadImgCellDelegate, PhoneBindCellDelegate
extension EditDataViewController: HeadImgCellDelegate, NoArrowEditCellDelegate {
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
    
    func noarrowCellReturnText(text: String?, tuple: (section: Int, row: Int)) {
        switch tuple {
        case (1,0): req.nickname = text
        case (1,4): req.introduction = text
        default: ""
        }
        checkParameters()
    }
}

// MARK: - UIImagePickerControllerDelegate
extension EditDataViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let originalImg = info["UIImagePickerControllerEditedImage"] as! UIImage
        self.dismissViewControllerAnimated(true, completion: nil)
        originalImg.resetSizeOfImageData(originalImg, maxSize: 300) { [unowned self](data) in
            self.headImgView.image = UIImage(data: data)
            self.headImgData = data
            self.checkParameters()
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true) { }//TODO
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension EditDataViewController: UIPickerViewDelegate, UIPickerViewDataSource, YGPickerViewDelegate {
    
    func pickerViewSelectedSure(sender: UIButton, pickerView: UIPickerView) {
        let city = pickerView.delegate!.pickerView!(pickerView, titleForRow: pickerView.selectedRowInComponent(1), forComponent: 1)
        let province = cityResp.province[provinceInt]
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 1)) as! ArrowEditCell
        if province.name == "不限" {
            cell.tf.text = province.name
        } else {
            guard let c = city else {fatalError("city 为空")}
            cell.tf.text = "\(province.name) \(c)"
        }
        LogDebug("\(province.id)   \(cityResp.province[provinceInt].citys[pickerView.selectedRowInComponent(1)].id)")
        req.province = "\(province.id)"
        req.city = "\(cityResp.province[provinceInt].citys[pickerView.selectedRowInComponent(1)].id)"
        checkParameters()
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return self.cityResp.province.count
        } else {
            let province = self.cityResp.province[pickerView.selectedRowInComponent(0)]
            return province.citys.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return self.cityResp.province[row].name
        } else {
            let province = self.cityResp.province[pickerView.selectedRowInComponent(0)]
            let city = province.citys[row]
            return city.name
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            LogVerbose(row)
            provinceInt = row
            pickerView.reloadComponent(1)
        }
    }
}