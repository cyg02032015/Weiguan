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

class OrganizeAuthViewController: YGBaseViewController {

    var tableView: UITableView!
    var typePickerView: YGPickerView!
    lazy var types = ["演出公司", "经纪公司", "唱片公司", "演出器材", "模特公司", "婚庆礼仪公司", "影视公司", "影视制作", "娱乐场所", "演出场馆", "剧组", "培训机构", "文化公司", "排练室", "录音棚", "乐器行", "发行公司", "工作室", "其他"]
    var pickerView: YGPickerView!
    var imgButton: TouchImageView!
    var desc: UILabel!
    var commitButton: UIButton!
    lazy var req = OrganizeRequest()
    var picToken: GetToken!
    var img: UIImage!
    lazy var cityResp: CityResp = YGCityData.loadCityData()
    var provinceInt = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        getToken()
        pickerView = YGPickerView(frame: CGRectZero, delegate: self)
        pickerView.delegate = self
        typePickerView = YGPickerView(frame: CGRectZero, delegate: self)
        typePickerView.delegate = self
    }
    
    func getToken() {
        Server.getUpdateFileToken(.Picture) { (success, msg, value) in
            if success {
                guard let obj = value else {return}
                self.picToken = obj
            } else {
                LogError(msg)
            }
        }
    }

    func setupSubViews() {
        title = "机构认证"
        
        commitButton = setRightNaviItem()
        commitButton.setTitle("提交", forState: .Normal)
        
        tableView = UITableView()
        tableView.backgroundColor = kBackgoundColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(NoArrowEditCell.self, forCellReuseIdentifier: noarrowCellId)
        tableView.registerClass(BusinessLicenceCell.self, forCellReuseIdentifier: businessLicenceId)
        tableView.separatorStyle = .None
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
    }
    
    override func tapMoreButton(sender: UIButton) {
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        let group = dispatch_group_create()
        SVToast.show()
        dispatch_group_async(group, queue) { [weak self] in
            dispatch_group_enter(group)
            OSSImageUploader.asyncUploadImage(self!.picToken, image: self!.img, complete: { (names, state) in
                dispatch_group_leave(group)
                if state == .Success {
                    self?.req.photo = names.first
                } else {
                    self?.req.photo = ""
                    SVToast.dismiss()
                    SVToast.showWithError("上传图片失败")
                }
            })
        }
        dispatch_group_notify(group, queue) { [weak self] in
            if isEmptyString(self!.req.photo) {
                return
            }
            Server.organizationAuth(self!.req) { (success, msg, value) in
                if success {
                    SVToast.showWithSuccess(value!)
                    delay(1, task: { 
                        self?.navigationController?.popToRootViewControllerAnimated(true)
                    })
                } else {
                    guard let m = msg else {return}
                    SVToast.showWithError(m)
                }
            }
        }
    }
    
    func checkRequest() {
        // TODO
        if !isEmptyString(UserSingleton.sharedInstance.userId) && !isEmptyString(req.type) && !isEmptyString(req.name) && !isEmptyString(req.license) && !isEmptyString(req.adds) && !isEmptyString(req.linkman) && !isEmptyString(req.phone) && img != nil {
            self.commitButton.userInteractionEnabled = true
            self.commitButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        } else {
            self.commitButton.userInteractionEnabled = false
            self.commitButton.setTitleColor(kGrayTextColor, forState: .Normal)
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
        case (0,1): req.name = text
        case (0,2): req.license = text
        case (0,4): req.linkman = text
        case (0,5): req.phone = text
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
            self.img = UIImage(data: data)
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
                return cityResp.province.count
            } else {
                let province = cityResp.province[pickerView.selectedRowInComponent(0)]
                return province.citys.count
            }
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == typePickerView.picker {
            return types[row]
        } else {
            if component == 0 {
                return cityResp.province[row].name
            } else {
                let province = self.cityResp.province[pickerView.selectedRowInComponent(0)]
                let city = province.citys[row]
                return city.name
            }
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == self.pickerView.picker {
            if component == 0 {
                provinceInt = row
                pickerView.reloadComponent(1)
            }
        }
    }
    
    func pickerViewSelectedSure(sender: UIButton, pickerView: UIPickerView) {
        if pickerView == typePickerView.picker {
            let type = pickerView.delegate!.pickerView!(pickerView, titleForRow: pickerView.selectedRowInComponent(0), forComponent: 0)
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! NoArrowEditCell
            cell.tf.text = type
            req.type = type
        } else {
            let city = pickerView.delegate!.pickerView!(pickerView, titleForRow: pickerView.selectedRowInComponent(1), forComponent: 1)
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 3, inSection: 0)) as! NoArrowEditCell
            cell.tf.text = city
            req.adds = "\(cityResp.province[provinceInt].citys[pickerView.selectedRowInComponent(1)].id)"
        }
        checkRequest()
    }
}