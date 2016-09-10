//
//  SetPasswordViewController.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/19.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

enum SettingType: Int {
    case First = 0
    case Modify = 1
}

private extension Selector {
    static let tapSure = #selector(SetPasswordViewController.tapSure(_:))
}

class SetPasswordViewController: YGBaseViewController {
    var label: UILabel!
    var sure: UIButton!
    var passwordTF: ZSPasswordView!
    var type: SettingType!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }
    
    func setupSubViews() {
        if type == .First {
            title = "设置支付密码"
        } else {
            title = "修改支付密码"
        }
        label = UILabel.createLabel(16, textColor: UIColor(hex: 0x666666))
        label.textAlignment = .Center
        if type == .First {
            label.text = "请输入支付密码"
        } else {
            label.text = "请输入原支付密码"
        }
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.right.equalTo(label.superview!)
            make.top.equalTo(label.superview!).offset(kScale(20))
            make.height.equalTo(kScale(16))
        }
        view.layoutIfNeeded()
        passwordTF = ZSPasswordView(frame: CGRect(x: 40, y: label.gg_bottom + 20, width: ScreenWidth - 80, height: kScale(44)))
        passwordTF.delegate = self
        passwordTF.textFiled.becomeFirstResponder()
        view.addSubview(passwordTF)
        
        sure = UIButton()
        if type == .First {
            sure.setTitle("确定", forState: .Normal)
        } else {
            sure.setTitle("下一步", forState: .Normal)
        }
        sure.addTarget(self, action: .tapSure, forControlEvents: .TouchUpInside)
        sure.backgroundColor = kGrayColor
        sure.userInteractionEnabled = false
        sure.layer.cornerRadius = kScale(6)
        sure.titleLabel!.font = UIFont.customFontOfSize(16)
        view.addSubview(sure)
        sure.snp.makeConstraints(closure: { (make) in
            make.top.equalTo(passwordTF.snp.bottom).offset(kScale(32))
            make.left.equalTo(sure.superview!).offset(kScale(38))
            make.right.equalTo(sure.superview!).offset(kScale(-38))
            make.height.equalTo(kScale(44))
        })
    }
    
    func tapSure(sender: UIButton) {
        if type == .First {
            view.endEditing(true)
            UserSingleton.sharedInstance.isSetPassword = true
            guard let vcs = navigationController?.viewControllers else { return }
            _ = vcs.map { [unowned self] vc in
                if vc.isKindOfClass(MyAccountViewController.self) {
                    self.navigationController?.popToViewController(vc, animated: true)
                }
            }
        } else {
            if sender.titleLabel!.text! == "下一步" {
                sure.setTitle("确定", forState: .Normal)
                label.text = "请输入新支付密码"
                UserSingleton.sharedInstance.originPwd = passwordTF.textFiledString
                passwordTF.textFiled.text = ""
                _ = passwordTF.subviews.map({ (v) in
                    if v.isKindOfClass(UILabel.self) {
                        v.hidden = true
                    }
                })
                view.endEditing(true)
                passwordTF.textFiled.becomeFirstResponder()
                return
            } else {
                view.endEditing(true)
                UserSingleton.sharedInstance.newPwd = passwordTF.textFiledString
                if UserSingleton.sharedInstance.newPwd == UserSingleton.sharedInstance.originPwd {
                    LogInfo("密码相同")
                } else {
                    LogError("密码不同")
                    return
                }
                UserSingleton.sharedInstance.isSetPassword = true
                guard let vcs = navigationController?.viewControllers else { return }
                _ = vcs.map { [unowned self] vc in
                    if vc.isKindOfClass(MyAccountViewController.self) {
                        self.navigationController?.popToViewController(vc, animated: true)
                    }
                }
            }
        }
        
    }
}

extension SetPasswordViewController: ZSPasswordViewDelegate {
    func zaPasswordSendText(text: String) {
        LogVerbose(text)
        if text.characters.count >= 6 {
            sure.userInteractionEnabled = true
            sure.backgroundColor = kCommonColor
        } else {
            sure.userInteractionEnabled = false
            sure.backgroundColor = kGrayColor
        }
    }
}
