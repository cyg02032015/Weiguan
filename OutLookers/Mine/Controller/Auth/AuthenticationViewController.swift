//
//  AuthenticationViewController.swift
//  OutLookers
//
//  Created by C on 16/7/17.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

enum GotoType: Int {
    case Talent = 0
    case Organize = 1
    case Fans = 2
}

class AuthenticationViewController: YGBaseViewController {
    
    var authObj: IsAuthResp!
    var gotoVC: GotoType!
    override func viewDidLoad() {
        super.viewDidLoad()
        //        setupSubViews()
        SVToast.show()
        Server.isAuth { (success, msg, value) in
            SVToast.dismiss()
            if success {
                guard let object = value else {return}
                self.authObj = object
                self.setupSubViews()
            } else {
                guard let m = msg else {return}
                self.setupSubViews()
                SVToast.showWithError(m)
            }
        }
    }
    
    func setupSubViews() {
        title = "认证"
        let talent = UIButton()
        talent.setTitle("红人认证", forState: .Normal)
        talent.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        talent.backgroundColor = UIColor(hex: 0xff4e4e)
        talent.titleLabel!.font = UIFont.customFontOfSize(16)
        talent.layer.cornerRadius = kScale(48/2)
        view.addSubview(talent)
        talent.snp.makeConstraints { (make) in
            make.centerX.equalTo(talent.superview!)
            make.size.equalTo(kSize(192, height: 48))
            make.top.equalTo(self.snp.topLayoutGuideBottom).offset(kScale(60))
        }
        
        let organization = UIButton()
        organization.setTitle("机构认证", forState: .Normal)
        organization.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        organization.backgroundColor = UIColor(hex: 0x0fddec)
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
        fans.titleLabel!.font = UIFont.customFontOfSize(16)
        fans.layer.cornerRadius = kScale(48/2)
        view.addSubview(fans)
        fans.snp.makeConstraints { (make) in
            make.centerX.equalTo(talent)
            make.size.equalTo(talent)
            make.top.equalTo(organization.snp.bottom).offset(kScale(40))
        }
        talent.rx_tap.subscribeNext { [unowned self] in
            if self.authObj == nil {return}
            self.gotoVC = .Talent
            if self.authObj.type == .HotMan || self.authObj.type == .Tourist {
                let vc = TalentAuthViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                self.showAlertController()
            }
            
            }.addDisposableTo(disposeBag)
        
        organization.rx_tap.subscribeNext { [unowned self] in
            if self.authObj == nil {return}
            self.gotoVC = .Organize
            if self.authObj.type == .Organization || self.authObj.type == .Tourist {
                let vc = OrganizeAuthViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                self.showAlertController()
            }
            }.addDisposableTo(disposeBag)
        
        fans.rx_tap.subscribeNext { [unowned self] in
            if self.authObj == nil {return}
            self.gotoVC = .Fans
            if self.authObj.type == .Fans || self.authObj.type == .Tourist {
                let vc = FansAuthViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                self.showAlertController()
            }
            }.addDisposableTo(disposeBag)
    }
    
    func showAlertController() {
        let alert = UIAlertController(title: "提示", message: "每个用户只能认证一种角色，要继续认证则视为放弃原认证", preferredStyle: .Alert)
        let cancel = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
        let continued = UIAlertAction(title: "继续认证", style: .Default) { [weak self](action) in
            Server.modifyAuth({ (success, msg, value) in
                if success {
                    guard let _ = value else {return}
                    if self?.gotoVC == .Talent {
                        let vc = TalentAuthViewController()
                        self?.navigationController?.pushViewController(vc, animated: true)
                    } else if self?.gotoVC == .Organize {
                        let vc = OrganizeAuthViewController()
                        self?.navigationController?.pushViewController(vc, animated: true)
                    } else {
                        let vc = FansAuthViewController()
                        self?.navigationController?.pushViewController(vc, animated: true)
                    }
                } else {
                guard let m = msg else {return}
                SVToast.showWithError(m)
            }
        })
    }
    alert.addAction(cancel)
    alert.addAction(continued)
    presentViewController(alert, animated: true, completion: nil)
}
}
