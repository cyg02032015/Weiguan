//
//  BindAccountViewController.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/19.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class BindAccountViewController: YGBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }

    func setupSubViews() {
        title = "账号绑定"
        let label = UILabel.createLabel(16)
        label.text = "微信账号"
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(kScale(15))
            make.top.equalTo(label.superview!).offset(kScale(14))
            make.height.equalTo(kScale(16))
        }
        
        let textField = UITextField()
        textField.font = UIFont.customFontOfSize(16)
        textField.placeholder = "请输入用户名"
        textField.textAlignment = .Right
        view.addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.right.equalTo(textField.superview!).offset(kScale(-15))
            make.height.equalTo(kScale(30))
            make.centerY.equalTo(label)
            make.left.equalTo(label.snp.right).offset(kScale(15))
        }
        
        let lineV = UIView()
        lineV.backgroundColor = kLineColor
        view.addSubview(lineV)
        lineV.snp.makeConstraints { (make) in
            make.left.equalTo(label)
            make.right.equalTo(textField)
            make.top.equalTo(label.snp.bottom).offset(kScale(14))
            make.height.equalTo(1)
        }
    }
}
