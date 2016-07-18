//
//  AuthenticationViewController.swift
//  OutLookers
//
//  Created by C on 16/7/17.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private extension Selector {
    static let tapTalent = #selector(AuthenticationViewController.tapTalent(_:))
    static let tapFans = #selector(AuthenticationViewController.tapFans(_:))
    static let tapOrganization = #selector(AuthenticationViewController.tapOrganization(_:))
}

class AuthenticationViewController: YGBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        let req = BaseRequest(userId: "1")
        Server.isAuth(req) { (success, msg, value) in
            if success {
                LogInfo("\(value!.authentication)   \(value!.type)")
            } else {
                LogError(msg!)
            }
        }
    }
    
    func setupSubViews() {
        title = "认证"
        let talent = UIButton()
        talent.setTitle("艺人认证", forState: .Normal)
        talent.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        talent.backgroundColor = UIColor(hex: 0xff4e4e)
        talent.addTarget(self, action: .tapTalent, forControlEvents: .TouchUpInside)
        talent.titleLabel!.font = UIFont.customFontOfSize(16)
        talent.layer.cornerRadius = kScale(48/2)
        view.addSubview(talent)
        talent.snp.makeConstraints { (make) in
            make.centerX.equalTo(talent.superview!)
            make.size.equalTo(kSize(192, height: 48))
            make.top.equalTo(talent.superview!).offset(kScale(60))
        }
        
        let organization = UIButton()
        organization.setTitle("机构认证", forState: .Normal)
        organization.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        organization.backgroundColor = UIColor(hex: 0x0fddec)
        organization.addTarget(self, action: .tapOrganization, forControlEvents: .TouchUpInside)
        organization.titleLabel!.font = UIFont.customFontOfSize(16)
        organization.layer.cornerRadius = kScale(48/2)
        view.addSubview(organization)
        organization.snp.makeConstraints { (make) in
            make.centerX.equalTo(talent)
            make.size.equalTo(talent)
            make.top.equalTo(talent.snp.bottom).offset(kScale(40))
        }
        
        let fans = UIButton()
        fans.setTitle("粉丝认证", forState: .Normal)
        fans.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        fans.backgroundColor = UIColor(hex: 0xabd815)
        fans.addTarget(self, action: .tapFans, forControlEvents: .TouchUpInside)
        fans.titleLabel!.font = UIFont.customFontOfSize(16)
        fans.layer.cornerRadius = kScale(48/2)
        view.addSubview(fans)
        fans.snp.makeConstraints { (make) in
            make.centerX.equalTo(talent)
            make.size.equalTo(talent)
            make.top.equalTo(organization.snp.bottom).offset(kScale(40))
        }
    }
    
    func tapTalent(sender: UIButton) {
        let vc = TalentAuthViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tapOrganization(sender: UIButton) {
        let vc = OrganizeAuthViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tapFans(sender: UIButton) {
        showAlertController()
    }
    
    func showAlertController() {
        let alert = UIAlertController(title: "提示", message: "每个用户只能认证一种角色，您当前已通过粉丝认证，若继续认证则视为放弃粉丝认证", preferredStyle: .Alert)
        let cancel = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
        let continued = UIAlertAction(title: "继续认证", style: .Default) { (action) in
            let req = BaseRequest(userId: "1")
            Server.modifyAuth(req, handler: { (success, msg, value) in
                if success {
                    // TODO
                    LogInfo(value!)
                } else {
                    LogError(msg!)
                }
            })
        }
        alert.addAction(cancel)
        alert.addAction(continued)
        presentViewController(alert, animated: true, completion: nil)
    }
}
