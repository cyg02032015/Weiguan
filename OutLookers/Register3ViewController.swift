//
//  Register3ViewController.swift
//  OutLookers
//
//  Created by C on 16/8/5.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import RxSwift

class Register3ViewController: YGBaseViewController {

    var imgView: TouchImageView!
    var nickname: UITextField!
    var sex: UITextField!
    var city: UITextField!
    var register: UIButton!
    var provinceInt = 0
    var cityPicker: YGPickerView!
    var imgData: NSData!
    lazy var req = PerfectInfomationReq()
    lazy var cityResp = YGCityData.loadCityData()
    var picToken: GetToken!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        getToken()
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
    
    func setupSubViews() {
        title = "完善资料（3/3）"
        view.backgroundColor = UIColor.whiteColor()
        imgView = TouchImageView()
        imgView.addTarget(self, action: #selector(Register3ViewController.tapImgView))
        imgView.image = UIImage(named: "个人主页默认头像default1")
        imgView.layer.cornerRadius = kScale(72/2)
        imgView.clipsToBounds = true
        view.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.centerX.equalTo(imgView.superview!)
            make.top.equalTo(self.snp.topLayoutGuideBottom).offset(kScale(30))
            make.size.equalTo(kSize(72, height: 72))
        }
        
        nickname = getTextFieldContainer(imgView, offset: 20, placeholder: "请输入昵称")
        nickname.addTarget(self, action: #selector(Register3ViewController.textFieldDidChange(_:)), forControlEvents: .EditingChanged)
        nickname.keyboardType = .Default
        
        sex = getTextFieldContainer(nickname, offset: 10, placeholder: "请选择性别")
        sex.tag = 1000
        sex.delegate = self
        
        city = getTextFieldContainer(sex, offset: 10, placeholder: "请选择城市")
        city.tag = 2000
        city.delegate = self
        
        register = Util.customCornerButton("注册")
        view.addSubview(register)
        register.snp.makeConstraints { (make) in
            make.top.equalTo(city.snp.bottom).offset(kScale(41))
            make.size.equalTo(nickname)
            make.centerX.equalTo(nickname)
        }
        
        register.rx_tap.subscribeNext { [weak self] in
            guard let weakSelf = self else {return}
            let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
            let group = dispatch_group_create()
            SVToast.show()
            dispatch_group_async(group, queue) {
                dispatch_group_enter(group)
                guard let token = weakSelf.picToken else {return}
                OSSImageUploader.asyncUploadImageData(token, data: weakSelf.imgData, complete: { (names, state) in
                    if state == .Success {
                        weakSelf.req.headImgUrl = names.first
                        dispatch_group_leave(group)
                    } else {
                        weakSelf.req.headImgUrl = ""
                        SVToast.dismiss()
                        SVToast.showWithError("上传头像失败")
                        dispatch_group_leave(group)
                    }
                })
            }
            dispatch_group_notify(group, queue, {
                Server.perfectInformation(weakSelf.req, handler: { (success, msg, value) in
                    SVToast.dismiss()
                    if success {
                        weakSelf.navigationController?.popToRootViewControllerAnimated(true)
                    } else {
                        guard let m = msg else {return}
                        SVToast.showWithError(m)
                    }
                })
            })
        }.addDisposableTo(disposeBag)
    }
    
    func checkParameters() {
        if !isEmptyString(req.city) && imgData != nil && !isEmptyString(req.nickname) && !isEmptyString(req.province) && !isEmptyString(req.sex) {
                register.userInteractionEnabled = true
                register.backgroundColor = kCommonColor
        } else {
            register.userInteractionEnabled = false
            register.backgroundColor = kLightGrayColor
        }
    }
    
    func tapImgView() {
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        let camera = UIAlertAction(title: "拍照", style: .Default, handler: { [weak self](action) in
            let vc = Util.actionSheetImagePicker(isCamera: true)
            guard let v = vc else { return }
            v.delegate = self
            self?.presentViewController(v, animated: true, completion: nil)
        })
        let library = UIAlertAction(title: "从相册中选取", style: .Default, handler: { [weak self](action) in
            let vc = Util.actionSheetImagePicker(isCamera: false)
            guard let v = vc else { return }
            v.delegate = self
            self?.presentViewController(v, animated: true, completion: nil)
        })
        let cancel = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
        sheet.addAction(camera)
        sheet.addAction(library)
        sheet.addAction(cancel)
        self.presentViewController(sheet, animated: true, completion: nil)

    }
    
    func textFieldDidChange(textField: UITextField) {
        req.nickname = textField.text ?? ""
    }
    
    func getTextFieldContainer(v: UIView, offset: CGFloat, placeholder: String) -> UITextField {
        let container = textFieldContainer()
        view.addSubview(container)
        container.snp.makeConstraints { (make) in
            make.centerX.equalTo(container.superview!)
            make.size.equalTo(kSize(220, height: 44))
            make.top.equalTo(v.snp.bottom).offset(offset)
        }
        
        let tf = getTextField(placeholder)
        tf.textAlignment = .Center
        container.addSubview(tf)
        tf.snp.makeConstraints { (make) in
            make.centerX.equalTo(tf.superview!)
            make.size.equalTo(kSize(190, height: 40))
            make.centerY.equalTo(tf.superview!)
        }
        return tf
    }
}

extension Register3ViewController: UITextFieldDelegate, YGPickerViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField.tag == 1000 { // 选择性别
            let sheet = UIAlertController(title: "选择性别", message: nil, preferredStyle: .ActionSheet)
            let male = UIAlertAction(title: "男", style: .Default, handler: { [weak self](action) in
                self?.sex.text = action.title
                self?.req.sex = SexType.Male.rawValue
                self?.checkParameters()
            })
            let female = UIAlertAction(title: "女", style: .Default, handler: { [weak self](action) in
                self?.sex.text = action.title
                self?.req.sex = SexType.Female.rawValue
                self?.checkParameters()
            })
            let cancel = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
            sheet.addAction(male)
            sheet.addAction(female)
            sheet.addAction(cancel)
            presentViewController(sheet, animated: true, completion: nil)
            
            return false
        } else if textField.tag == 2000 { // 选择城市
            cityPicker = YGPickerView(frame: CGRectZero, delegate: self)
            cityPicker.delegate = self
            cityPicker.animation()
            return false
        } else {
            return true
        }
    }
    
    func pickerViewSelectedSure(sender: UIButton, pickerView: UIPickerView) {
        let city = pickerView.delegate!.pickerView!(pickerView, titleForRow: pickerView.selectedRowInComponent(1), forComponent: 1)
        let province = cityResp.province[provinceInt]
        let c = province.citys[pickerView.selectedRowInComponent(1)]
        if province.name == "不限" {
            self.city.text = "不限"
        } else {
            if !isEmptyString(city) {
                req.city = "\(c.id)"
                self.city.text = "\(province.name) \(city!)"
            } else {
                req.city = "\(province.id)"
                self.city.text = "\(province.name)"
            }
        }
        req.province = "\(province.id)"
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

// MARK: - UIImagePickerControllerDelegate
extension Register3ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let originalImg = info["UIImagePickerControllerEditedImage"] as! UIImage
        self.dismissViewControllerAnimated(true, completion: nil)
        originalImg.resetSizeOfImageData(originalImg, maxSize: 300) { [unowned self](data) in
            self.imgView.image = UIImage(data: data)
            self.imgData = data
            self.checkParameters()
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true) { }//TODO
    }
}


