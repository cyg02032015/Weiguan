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

class LogViewController: YGBaseViewController {
    
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
        title = "手机号登录"
        let register = setRightNaviItem()
        register.setTitle("注册", forState: .Normal)
        register.setTitleColor(UIColor(hex: 0xFF6464), forState: .Normal)

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
        
        phoneTF = getTextField("请输入手机号")
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
        
        passTF = getTextField("请输入密码")
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
        
        nextButton = Util.customCornerButton("登录")
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(accountView)
            make.size.equalTo(accountView)
            make.top.equalTo(passView.snp.bottom).offset(kScale(40))
        }
        
        let forget = UIButton()
        let attributeText = NSMutableAttributedString(string: "忘记密码？")
        let range = NSRange(location: 0, length: attributeText.length)
        attributeText.addAttribute(NSUnderlineStyleAttributeName, value: NSNumber(integer:NSUnderlineStyle.StyleSingle.rawValue), range:range)
        attributeText.addAttribute(NSForegroundColorAttributeName, value: UIColor(hex: 0x999999), range: range)
        forget.setAttributedTitle(attributeText, forState: .Normal)
        forget.titleLabel!.font = UIFont.customFontOfSize(12)
        view.addSubview(forget)
        forget.snp.makeConstraints { (make) in
            make.centerX.equalTo(forget.superview!)
            make.top.equalTo(nextButton.snp.bottom).offset(kScale(20))
            make.size.equalTo(kSize(60, height: 20))
        }
        
        forget.rx_tap.subscribeNext {
            LogInfo("忘记密码")
        }.addDisposableTo(disposeBag)
        
        register.rx_tap.subscribeNext { [weak self] in
            let vc = Register1ViewController()
            self?.navigationController?.pushViewController(vc, animated: true)
        }.addDisposableTo(disposeBag)
        
        nextButton.rx_tap.subscribeNext { [unowned self] in
            if self.phoneTF.text! =~ kMobileNumberReg {
                SVToast.show("正在登录")
                Server.phoneLogin(self.phoneTF.text!, pwd: (self.passTF.text! + "a").myMD5, handler: { (success, msg, value) in
                    SVToast.dismiss()
                    if success {
                        if isEmptyString(UserSingleton.sharedInstance.nickname) {
                            let vc = Register3ViewController()
                            self.navigationController?.pushViewController(vc, animated: true)
                        } else {
                            delay(0.5, task: {
                                self.navigationController?.popToRootViewControllerAnimated(true)
                            })
                        }
                    } else {
                        guard let m = msg else {return}
                        SVToast.showWithError(m)
                    }
                })
            } else {
                SVToast.showWithError("手机号码格式错误")
            }
        }.addDisposableTo(disposeBag)
    }
}

// MARK: -TextFieldDelegate
extension LogViewController: UITextFieldDelegate {
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let str = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
        if textField == phoneTF {
            return str.characters.count <= 11
        } else {
            return true
        }
    }
}

func textFieldContainer() -> UIView {
    let c = UIView()
    c.layer.borderWidth = 1
    c.layer.borderColor = UIColor(hex: 0xE5E5E5).CGColor
    c.layer.cornerRadius = kScale(23)
    c.clipsToBounds = true
    c.backgroundColor = UIColor.whiteColor()
    return c
}

func getTextField(placeHolder: String) -> UITextField {
    let tf = UITextField()
    tf.placeholder = placeHolder
    tf.keyboardType = .NumberPad
    tf.font = UIFont.customFontOfSize(16)
    return tf
}


