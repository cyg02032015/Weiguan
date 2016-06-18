//
//  LogViewController.swift
//  OutLookers
//
//  Created by C on 16/6/18.
//  Copyright © 2016年 youngkook. All rights reserved.
//

import UIKit

class LogViewController: YGBaseViewController {
    
    var mobileTF: UITextField!
    var verifyTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "账号认证"
        
        setupSubViews()
    }

    func setupSubViews() {
        let container = UIView()
        view.addSubview(container)
        
        let topLabel = UILabel()
        topLabel.textAlignment = .Center
        topLabel.text = "为保证你的账户安全, 请先绑定手机"
        topLabel.font = UIFont.systemFontOfSize(16)
        container.addSubview(topLabel)
        
        // 手机号
        let mobileContainer = textFieldContainer()
        container.addSubview(mobileContainer)
        
        mobileTF = getTextField("请输入手机号")
        mobileContainer.addSubview(mobileTF)
        
        let verifyButton = UIButton()
        verifyButton.setTitle("获取验证码", forState: .Normal)
        verifyButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        verifyButton.backgroundColor = UIColor(hex: 0xF7595B)
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
        cornerButton.addTarget(self, action: #selector(LogViewController.protocolButtonClick(_:)), forControlEvents: .TouchUpInside)
        container.addSubview(cornerButton)
        
        let protocleLabel = UILabel()
        protocleLabel.font = UIFont.systemFontOfSize(12)
        protocleLabel.text = "我同意围观平台的用户协议"
        container.addSubview(protocleLabel)
        
        // 提交按钮
        let submitButton = UIButton()
        submitButton.layer.cornerRadius = 23
        submitButton.setTitle("提交", forState: .Normal)
        submitButton.backgroundColor = UIColor.grayColor()
        container.addSubview(submitButton)
        
        // 再去逛逛
        let aroundButton = UIButton()
        aroundButton.setTitle("再去逛逛", forState: .Normal)
        aroundButton.setTitleColor(UIColor.grayColor(), forState: .Normal)
        container.addSubview(aroundButton)
        
        container.snp.makeConstraints { make in
            make.top.equalTo(self.snp.topLayoutGuideBottom)
            make.left.right.equalTo(container.superview!)
            make.height.equalTo(400)
        }
        
        topLabel.snp.makeConstraints { make in
            make.top.equalTo(72)
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
            make.height.equalTo(16)
        }
        
        verifyContainer.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(mobileContainer)
            make.top.equalTo(mobileContainer.snp.bottom).offset(20)
        }
        
        verifyTF.snp.makeConstraints { make in
            make.left.height.equalTo(mobileTF)
            make.centerY.equalTo(verifyContainer)
            make.right.equalTo(verifyTF.superview!).offset(-20)
        }
        
        cornerButton.snp.makeConstraints { (make) in
            make.left.equalTo(66)
            make.top.equalTo(verifyContainer.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: 14, height: 14))
        }
        
        protocleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(cornerButton.snp.right).offset(5)
            make.centerY.equalTo(cornerButton)
            make.height.equalTo(12)
        }
        
        submitButton.snp.makeConstraints { (make) in
            make.left.right.equalTo(mobileContainer)
            make.top.equalTo(protocleLabel.snp.bottom).offset(20)
            make.height.equalTo(46)
        }
        
        aroundButton.snp.makeConstraints { (make) in
            make.right.equalTo(aroundButton.superview!).offset(-60)
            make.height.equalTo(17)
            make.width.equalTo(100)
            make.top.equalTo(submitButton.snp.bottom).offset(20)
        }
    }
    
    func protocolButtonClick(sender: UIButton) {
        sender.selected = !sender.selected
    }
    
    func textFieldContainer() -> UIView {
        let c = UIView()
        c.layer.borderWidth = 2
        c.layer.borderColor = UIColor.grayColor().CGColor
        c.layer.cornerRadius = 23
        c.clipsToBounds = true
        return c
    }
    
    func getTextField(placeHolder: String) -> UITextField {
        let tf = UITextField()
        tf.placeholder = placeHolder
        tf.font = UIFont.systemFontOfSize(16)
        return tf
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }}
