//
//  LogViewController.swift
//  OutLookers
//
//  Created by C on 16/6/18.
//  Copyright © 2016年 youngkook. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

let disposeBag = DisposeBag()

private extension Selector {
    static let tapSubmit = #selector(LogViewController.submitButtonClick(_:))
    static let tapCorner = #selector(LogViewController.protocolButtonClick(_:))
    static let tapVerify = #selector(LogViewController.tapVerifyButton(_:))
    static let countDownTimer = #selector(LogViewController.countDownTimer)
    static let tapProtocolButton = #selector(LogViewController.tapProtocolButton(_:))
    static let tapArroundMore = #selector(LogViewController.tapArroundMore(_:))
}

class LogViewController: YGBaseViewController {
    
    var mobileTF: UITextField!
    var verifyTF: UITextField!
    var submitButton: UIButton!
    var verifyButton: UIButton!
    var timer: NSTimer!
    var countDown: Int = 60
    override func viewDidLoad() {
        super.viewDidLoad()
        title = LocalizedString("accountCheck")
        
        setupSubViews()
        
        let mobileValid = mobileTF.rx_text.map {
            $0.characters.count == 11
        }.shareReplay(1)
        
        let verifyValid = verifyTF.rx_text.map {
            $0.characters.count == 6
        }.shareReplay(1)
        
        let everthingValid = Observable.combineLatest(mobileValid, verifyValid) { mobile, verify in
            return mobile && verify
        }.shareReplay(1)
        
        everthingValid.bindTo(submitButton.rx_enabled).addDisposableTo(disposeBag)
        everthingValid.subscribe { [weak self](event) in
            guard let weakSelf = self else { return }
            if let _ = event.element where event.element == true {
                weakSelf.submitButton.backgroundColor = kRedColor
            } else {
                weakSelf.submitButton.backgroundColor = kGrayColor
            }
        }.addDisposableTo(disposeBag)
        
        
        
    }

    func setupSubViews() {
        let container = UIView()
        view.addSubview(container)
        
        let topLabel = UILabel()
        topLabel.textAlignment = .Center
        topLabel.text = "为保证你的账户安全, 请先绑定手机"
        topLabel.font = UIFont.customFontOfSize(16)
        container.addSubview(topLabel)
        
        // 手机号
        let mobileContainer = textFieldContainer()
        container.addSubview(mobileContainer)
        
        mobileTF = getTextField("请输入手机号")
        mobileContainer.addSubview(mobileTF)
        
        verifyButton = UIButton()
        verifyButton.setTitle("获取验证码", forState: .Normal)
        verifyButton.titleLabel?.font = UIFont.customFontOfSize(13)
        verifyButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        verifyButton.backgroundColor = kRedColor
        verifyButton.addTarget(self, action: .tapVerify, forControlEvents: .TouchUpInside)
        mobileContainer.addSubview(verifyButton)
        
        // 验证码
        let verifyContainer = textFieldContainer()
        container.addSubview(verifyContainer)
        
        verifyTF = getTextField("请输入验证码")
        verifyContainer.addSubview(verifyTF)
        
        // 用户协议和按钮
        let cornerButton = UIButton()
        cornerButton.setImage(UIImage(named: "disagree"), forState: .Normal)
        cornerButton.setImage(UIImage(named: "agree"), forState: .Selected)
        cornerButton.addTarget(self, action: .tapCorner, forControlEvents: .TouchUpInside)
        container.addSubview(cornerButton)
        
        let protocleButton = UIButton()
        protocleButton.titleLabel?.font = UIFont.customFontOfSize(12)
        protocleButton.setTitle("我同意围观平台的用户协议", forState: .Normal)
        protocleButton.setTitleColor(kGrayColor, forState: .Normal)
        protocleButton.addTarget(self, action: .tapProtocolButton, forControlEvents: .TouchUpInside)
        container.addSubview(protocleButton)
        
        // 提交按钮
        submitButton = UIButton()
        submitButton.layer.cornerRadius = 23
        submitButton.setTitle("提交", forState: .Normal)
        submitButton.backgroundColor = kGrayColor
        submitButton.addTarget(self, action: .tapSubmit, forControlEvents: .TouchUpInside)
        container.addSubview(submitButton)
        
        // 再去逛逛
        let aroundButton = UIButton()
        aroundButton.setTitle("再去逛逛", forState: .Normal)
        aroundButton.titleLabel?.font = UIFont.customFontOfSize(14)
        aroundButton.setTitleColor(UIColor(hex: 0x777777), forState: .Normal)
        aroundButton.addTarget(self, action: .tapArroundMore, forControlEvents: .TouchUpInside)
        container.addSubview(aroundButton)
        
        container.snp.makeConstraints { make in
            make.top.equalTo(self.snp.topLayoutGuideBottom)
            make.left.right.equalTo(container.superview!)
            make.height.equalTo(400)
        }
        
        topLabel.snp.makeConstraints { make in
            make.top.equalTo(80)
            make.left.right.equalTo(topLabel.superview!)
            make.height.equalTo(16)
        }
        
        mobileContainer.snp.makeConstraints { make in
            make.left.equalTo(38)
            make.right.equalTo(-38)
            make.height.equalTo(46)
            make.top.equalTo(topLabel.snp.bottom).offset(20)
        }
        
        verifyButton.snp.makeConstraints { make in
            make.right.equalTo(verifyButton.superview!)
            make.top.bottom.equalTo(verifyButton.superview!)
            make.width.equalTo(100)
        }
        
        mobileTF.snp.makeConstraints { make in
            make.left.equalTo(22)
            make.centerY.equalTo(mobileTF.superview!)
            make.right.equalTo(verifyButton.snp.left)
            make.height.equalTo(30)
        }
        
        verifyContainer.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(mobileContainer)
            make.top.equalTo(mobileContainer.snp.bottom).offset(15)
        }
        
        verifyTF.snp.makeConstraints { make in
            make.left.height.equalTo(mobileTF)
            make.centerY.equalTo(verifyContainer)
            make.right.equalTo(verifyTF.superview!).offset(-20)
        }
        
        cornerButton.snp.makeConstraints { (make) in
            make.left.equalTo(68)
            make.top.equalTo(verifyContainer.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: 12, height: 12))
        }
        
        protocleButton.snp.makeConstraints { (make) in
            make.left.equalTo(cornerButton.snp.right).offset(3)
            make.centerY.equalTo(cornerButton)
            make.height.equalTo(12)
        }
        
        submitButton.snp.makeConstraints { (make) in
            make.left.right.equalTo(mobileContainer)
            make.top.equalTo(protocleButton.snp.bottom).offset(32)
            make.height.equalTo(46)
        }
        
        aroundButton.snp.makeConstraints { (make) in
            make.right.equalTo(aroundButton.superview!).offset(-59)
            make.height.equalTo(14)
            make.width.equalTo(56)
            make.top.equalTo(submitButton.snp.bottom).offset(10)
        }
    }
    
    func textFieldContainer() -> UIView {
        let c = UIView()
        c.layer.borderWidth = 1
        c.layer.borderColor = kGrayColor.CGColor
        c.layer.cornerRadius = 23
        c.clipsToBounds = true
        return c
    }
    
    func getTextField(placeHolder: String) -> UITextField {
        let tf = UITextField()
        tf.placeholder = placeHolder
        tf.delegate = self
        tf.keyboardType = .NumberPad
        tf.font = UIFont.customFontOfSize(16)
        return tf
    }
}

// MARK: -按钮点击方法
extension LogViewController {
    
    func protocolButtonClick(sender: UIButton) {
        sender.selected = !sender.selected
        submitButton.selected = sender.selected
        
    }
    
    func submitButtonClick(sender: UIButton) {
        /*
            手机号格式错误
            验证码已发送
            验证码无效,请重新获取
            验证码输入错误
            绑定成功
         */
        view.endEditing(true)
        if !submitButton.selected {
            YKToast.makeText("请选择用户协议")
        }
        if mobileTF.text! =~ kMobileNumberReg {
            
        } else {
            YKToast.makeText("手机号格式错误")
        }
    }
    
    func tapVerifyButton(sender: UIButton) {
        verifyButton.userInteractionEnabled = false
        countDownTimer()
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: .countDownTimer, userInfo: nil, repeats: true)
        
    }
    
    func countDownTimer() {
        if countDown == 0 {
            timer.invalidate()
            verifyButton.userInteractionEnabled = true
            verifyButton.setTitle("获取验证码", forState: .Normal)
            verifyButton.backgroundColor = kRedColor
        } else {
            verifyButton.setTitle("\(countDown)s", forState: .Normal)
            verifyButton.backgroundColor = kGrayColor
        }
        countDown -= 1
    }
    
    func tapProtocolButton(sender: UIButton) {
        let protocolVC = ProtocolViewController()
        navigationController?.pushViewController(protocolVC, animated: true)
    }
    
    func tapArroundMore(sender: UIButton) {
        
    }
}

// MARK: -TextFieldDelegate
extension LogViewController: UITextFieldDelegate {
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let str = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
        if textField == mobileTF {
            return str.characters.count <= 11
        } else {
            return str.characters.count <= 6
        }
    }
}

