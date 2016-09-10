//
//  Register1ViewController.swift
//  OutLookers
//
//  Created by C on 16/8/5.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import RxSwift

class Register1ViewController: YGBaseViewController {

    var phoneTF: UITextField!
    var passTF: UITextField!
    var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        
        let mobileValid = phoneTF.rx_text.map {
            $0.characters.count == 11
            }.shareReplay(1)
        
        let verifyValid = passTF.rx_text.map {
            $0.characters.count >= 6
            }.shareReplay(1)
        
        let everthingValid = Observable.combineLatest(mobileValid, verifyValid) { mobile, verify in
            return mobile && verify
            }.shareReplay(1)
        
        everthingValid.bindTo(nextButton.rx_enabled).addDisposableTo(disposeBag)
        everthingValid.subscribe { [weak self](event) in
            guard let weakSelf = self else { return }
            if event.element == true {
                weakSelf.nextButton.userInteractionEnabled = true
                weakSelf.nextButton.backgroundColor = kCommonColor
            } else {
                weakSelf.nextButton.userInteractionEnabled = false
                weakSelf.nextButton.backgroundColor = kLightGrayColor
            }
            }.addDisposableTo(disposeBag)
    }
    
    func setupSubViews() {
        title = "设置账户密码（1/3）"
        let accountView = textFieldContainer()
        view.addSubview(accountView)
        accountView.snp.makeConstraints { (make) in
            make.centerX.equalTo(accountView.superview!)
            make.top.equalTo(self.snp.topLayoutGuideBottom).offset(kScale(40))
            make.size.equalTo(kSize(220, height: 44))
        }
        
        let phoneImg = UIImageView(image: UIImage(named: "phone"))
        accountView.addSubview(phoneImg)
        phoneImg.snp.makeConstraints { (make) in
            make.size.equalTo(kSize(10, height: 18))
            make.left.equalTo(phoneImg.superview!).offset(kScale(20))
            make.centerY.equalTo(phoneImg.superview!)
        }
        
        phoneTF = getTextField("请输入11位手机号")
        phoneTF.delegate = self
        accountView.addSubview(phoneTF)
        phoneTF.snp.makeConstraints { (make) in
            make.left.equalTo(phoneImg.snp.right).offset(kScale(10))
            make.right.equalTo(phoneTF.superview!).offset(kScale(-5))
            make.centerY.equalTo(phoneImg)
            make.height.equalTo(kScale(30))
        }
        
        let passView = textFieldContainer()
        view.addSubview(passView)
        passView.snp.makeConstraints { (make) in
            make.centerX.equalTo(accountView)
            make.size.equalTo(accountView)
            make.top.equalTo(accountView.snp.bottom).offset(kScale(10))
        }
        
        let passImg = UIImageView(image: UIImage(named: "Password"))
        passView.addSubview(passImg)
        passImg.snp.makeConstraints { (make) in
            make.size.equalTo(kSize(16, height: 16))
            make.left.equalTo(passImg.superview!).offset(kScale(16))
            make.centerY.equalTo(passImg.superview!)
        }
        
        passTF = getTextField("请输入密码，6-16位字符")
        passTF.keyboardType = .ASCIICapable
        passTF.secureTextEntry = true
        passTF.delegate = self
        passView.addSubview(passTF)
        passTF.snp.makeConstraints { (make) in
            make.left.equalTo(passImg.snp.right).offset(kScale(7))
            make.right.equalTo(passTF.superview!).offset(kScale(-5))
            make.centerY.equalTo(passImg)
            make.height.equalTo(phoneTF)
        }
        
        nextButton = Util.customCornerButton("下一步")
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(accountView)
            make.size.equalTo(accountView)
            make.top.equalTo(passView.snp.bottom).offset(kScale(40))
        }
        
        nextButton.rx_tap.subscribeNext { [unowned self] in
            if self.phoneTF.text! =~ kMobileNumberReg {
                let vc = Register2ViewController()
                vc.phone = self.phoneTF.text
                vc.pwd = self.passTF.text
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                SVToast.showWithError("手机号码格式错误")
            }
            
        }.addDisposableTo(disposeBag)
    }
}

// MARK: -TextFieldDelegate
extension Register1ViewController: UITextFieldDelegate {
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let str = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
        if textField == phoneTF {
            return str.characters.count <= 11
        }
        return true
    }
}
