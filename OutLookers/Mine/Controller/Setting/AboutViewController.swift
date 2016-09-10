//
//  AboutViewController.swift
//  OutLookers
//
//  Created by C on 16/7/31.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private extension Selector {
    static let tapProtocol = #selector(AboutViewController.tapProtocol)
}

class AboutViewController: YGBaseViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }
    
    func setupSubViews() {
        title = "关于纯氧"
        
        let imgView = UIImageView(image: UIImage(named: "cy"))
        view.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.topLayoutGuideBottom).offset(kScale(60))
            make.centerX.equalTo(imgView.superview!)
            make.size.equalTo(kSize(72, height: 72))
        }
        
        let name = UILabel.createLabel(16)
        name.textAlignment = .Center
        view.addSubview(name)
        name.snp.makeConstraints { (make) in
            make.centerX.equalTo(imgView)
            make.top.equalTo(imgView.snp.bottom).offset(kScale(20))
            make.height.equalTo(kScale(16))
        }
        
        let version = UILabel.createLabel(14, textColor: UIColor(hex: 0x666666))
        version.textAlignment = .Center
        view.addSubview(version)
        version.snp.makeConstraints { (make) in
            make.centerX.equalTo(imgView)
            make.top.equalTo(name.snp.bottom).offset(kScale(10))
            make.height.equalTo(kScale(14))
        }
        
        let company = UILabel.createLabel(14, textColor: UIColor(hex: 0x999999))
        company.textAlignment = .Center
        view.addSubview(company)
        company.snp.makeConstraints { (make) in
            make.centerX.equalTo(imgView)
            make.bottom.equalTo(company.superview!).offset(kScale(-60))
            make.height.equalTo(kScale(14))
        }
        
        let protocols = TouchLabel()
        protocols.font = UIFont.customFontOfSize(14)
        protocols.textColor = kCommonColor
        protocols.addTarget(self, action: .tapProtocol)
        protocols.textAlignment = .Center
        view.addSubview(protocols)
        protocols.snp.makeConstraints { (make) in
            make.centerX.equalTo(imgView)
            make.bottom.equalTo(company.snp.top).offset(kScale(-10))
            make.height.equalTo(kScale(14))
        }
        
        name.text = "纯氧"
        version.text = "版本\(Util.appVersion())"
        company.text = "北京围观信息技术有限公司"
        protocols.text = "用户协议"
    }
    
    func tapProtocol() {
        LogInfo("用户协议")
    }
}
