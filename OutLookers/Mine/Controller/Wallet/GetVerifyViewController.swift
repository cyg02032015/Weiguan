//
//  GetVerifyViewController.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/19.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
private extension Selector {
    static let tapVerifyButton = #selector(GetVerifyViewController.tapVerifyButton(_:))
    static let countDownTimer = #selector(GetVerifyViewController.countDownTimer)
    static let tapNext = #selector(GetVerifyViewController.tapNext(_:))
}

class GetVerifyViewController: YGBaseViewController {

    var verifyTF: UITextField!
    var verifyButton: UIButton!
    var nextButton: UIButton!
    var timer: NSTimer!
    var countDown: Int = 60
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if timer != nil {
            timer.invalidate()
            timer = nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }
    
    func setupSubViews() {
        title = "设置支付密码"
        let label = UILabel.createLabel(16, textColor: UIColor(hex: 0x666666))
        label.text = "为保证您的账户安全，请先验证手机号"
        label.textAlignment = .Center
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.right.equalTo(label.superview!)
            make.height.equalTo(kScale(16))
            make.top.equalTo(label.superview!).offset(kScale(15))
        }
        
        let phoneLabel = UILabel.createLabel(16, textColor: UIColor(hex: 0x666666))
        phoneLabel.text = "请输入手机135****1321收到的短信验证码"
        phoneLabel.textAlignment = .Center
        view.addSubview(phoneLabel)
        phoneLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(label)
            make.height.equalTo(kScale(16))
            make.top.equalTo(label.snp.bottom).offset(kScale(9))
        }
        
        // 手机号
        let mobileContainer = textFieldContainer()
        view.addSubview(mobileContainer)
        mobileContainer.snp.makeConstraints { (make) in
            make.left.equalTo(mobileContainer.superview!).offset(kScale(41))
            make.right.equalTo(mobileContainer.superview!).offset(kScale(-41))
            make.height.equalTo(kScale(44))
            make.top.equalTo(phoneLabel.snp.bottom).offset(kScale(22))
        }
        
        verifyButton = UIButton()
        verifyButton.setTitle("获取验证码", forState: .Normal)
        verifyButton.titleLabel?.font = UIFont.customFontOfSize(13)
        verifyButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        verifyButton.backgroundColor = kCommonColor
        verifyButton.addTarget(self, action: .tapVerifyButton, forControlEvents: .TouchUpInside)
        mobileContainer.addSubview(verifyButton)
        verifyButton.snp.makeConstraints { (make) in
            make.right.top.bottom.equalTo(verifyButton.superview!)
            make.width.equalTo(kScale(88))
        }
        
        verifyTF = getTextField("请输入验证码")
        mobileContainer.addSubview(verifyTF)
        verifyTF.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(verifyTF.superview!)
            make.left.equalTo(verifyTF.superview!).offset(kScale(10))
            make.right.equalTo(verifyButton.snp.left)
        }
        
        nextButton = UIButton()
        nextButton.setTitle("下一步", forState: .Normal)
        nextButton.addTarget(self, action: .tapNext, forControlEvents: .TouchUpInside)
        nextButton.backgroundColor = kGrayColor
        nextButton.userInteractionEnabled = false
        nextButton.layer.cornerRadius = kScale(6)
        nextButton.titleLabel!.font = UIFont.customFontOfSize(16)
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints(closure: { (make) in
            make.top.equalTo(mobileContainer.snp.bottom).offset(kScale(32))
            make.left.equalTo(nextButton.superview!).offset(kScale(38))
            make.right.equalTo(nextButton.superview!).offset(kScale(-38))
            make.height.equalTo(kScale(44))
        })
    }
    
    func textFieldContainer() -> UIView {
        let c = UIView()
        c.layer.borderWidth = 1
        c.layer.borderColor = kGrayColor.CGColor
        c.layer.cornerRadius = kScale(6)
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
            verifyButton.backgroundColor = kCommonColor
        } else {
            verifyButton.setTitle("\(countDown)s", forState: .Normal)
            verifyButton.backgroundColor = kGrayColor
        }
        countDown -= 1
    }
    
    func tapNext(sender: UIButton) {
        LogInfo("下一步")
        let vc = SetPasswordViewController()
        vc.type = .First
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: -TextFieldDelegate
extension GetVerifyViewController: UITextFieldDelegate {
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let str = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
        if str.characters.count >= 6 {
            nextButton.userInteractionEnabled = true
            nextButton.backgroundColor = kCommonColor
        } else {
            nextButton.userInteractionEnabled = false
            nextButton.backgroundColor = kGrayColor
        }
        return str.characters.count <= 6
    }
}
