//
//  AccountViewController.swift
//  OutLookers
//
//  Created by C on 16/7/31.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

private let arrowEditCellId = "arrowEditCellId"
private let accountCellId = "accountCellId"

class AccountViewController: YGBaseViewController {
    
    var imgs = ["Groupphone", "wechat_c", "qq_c", "sina_weibo_c"]
    var titles = ["手机号", "微信号", "QQ号", "新浪微博"]
    var tableView: UITableView!
    
    private var json: JSON?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        loadBingState()
    }
    
    private func loadBingState() {
        Server.checkBingState { [weak self](success, msg, value) in
            if success {
                self?.json = value
                self?.tableView.reloadData()
            }else {
                guard let _ = msg else { return }
                LogError(msg)
            }
        }
    }
    
    func setupSubViews() {
        title = "我的账号"
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = kHeight(50)
        tableView.registerClass(ArrowEditCell.self, forCellReuseIdentifier: arrowEditCellId)
        tableView.registerClass(AccountCell.self, forCellReuseIdentifier: accountCellId)
        tableView.backgroundColor = kBackgoundColor
        tableView.separatorStyle = .SingleLine
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
    }
}

extension AccountViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 4
        default: return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(arrowEditCellId, forIndexPath: indexPath) as! ArrowEditCell
            cell.setTextInCell("登录密码", placeholder: "修改密码")
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(accountCellId, forIndexPath: indexPath) as! AccountCell
            cell.setImgAndText(imgs[indexPath.row], text: titles[indexPath.row])
            guard let _ = json else {
                cell.bindButton.hidden = false
                cell.rightLabel.hidden = true
                return cell
            }
            let newJson = json!["result"].dictionaryObject
            guard let _ = newJson else { return cell }
            switch indexPath.row {
            case 0:
                if newJson!["isBindPhone"]!.intValue == 1 {
                    cell.bindButton.hidden = true
                    cell.rightLabel.hidden = false
                    cell.rightLabel.text = newJson!["phone"]! as? String
                }else {
                    cell.bindButton.hidden = false
                    cell.rightLabel.hidden = true
                    _ = cell.bindButton.rx_controlEvent(.TouchUpInside).subscribeNext({ [unowned self](sender) in
                        //绑定手机号
                    })
                }
            case 1:
                if newJson!["isBindWeixin"]!.intValue == 1 {
                    cell.bindButton.hidden = true
                    cell.rightLabel.hidden = false
                    cell.rightLabel.text = newJson!["wxNickname"]! as? String
                }else {
                    cell.bindButton.hidden = false
                    cell.rightLabel.hidden = true
                    _ = cell.bindButton.rx_controlEvent(.TouchUpInside).subscribeNext({ [unowned self](sender) in
                        //绑定微信
                        self.logViewTap(.Wechat, handler: { (data) in
                            if let account = data {
                                cell.bindButton.hidden = true
                                cell.rightLabel.hidden = false
                                cell.rightLabel.text = account.nickname
                            }
                        })
                    })
                }
            case 2:
                if newJson!["isBindQq"]!.intValue == 1 {
                    cell.bindButton.hidden = true
                    cell.rightLabel.hidden = false
                    cell.rightLabel.text = newJson!["qqNickname"]! as? String
                }else {
                    cell.bindButton.hidden = false
                    cell.rightLabel.hidden = true
                    _ = cell.bindButton.rx_controlEvent(.TouchUpInside).subscribeNext({ [unowned self](sender) in
                        //绑定QQ
                        self.logViewTap(.QQ, handler: { (data) in
                            if let account = data {
                                cell.bindButton.hidden = true
                                cell.rightLabel.hidden = false
                                cell.rightLabel.text = account.nickname
                            }
                        })
                    })
                }
            case 3:
                if newJson!["isBindSina"]!.intValue == 1 {
                    cell.bindButton.hidden = true
                    cell.rightLabel.hidden = false
                    cell.rightLabel.text = newJson!["sinaNickname"]! as? String
                }else {
                    cell.bindButton.hidden = false
                    cell.rightLabel.hidden = true
                    _ = cell.bindButton.rx_controlEvent(.TouchUpInside).subscribeNext({ [unowned self](sender) in
                        //绑定微博
                        self.logViewTap(.Weibo, handler: { (data) in
                            if let account = data {
                                cell.bindButton.hidden = true
                                cell.rightLabel.hidden = false
                                cell.rightLabel.text = account.nickname
                            }
                        })
                    })
                }
            default:
                break
            }
//            if indexPath.row == 0 {
//                cell.bindButton.hidden = true
//                cell.rightLabel.hidden = false
//                cell.rightLabel.text = ""
//                if let text = NSUserDefaults.standardUserDefaults().valueForKey("PhoneNum") {
//                    var phoneNum = text as! String
//                    let indexStart = phoneNum.startIndex.advancedBy(3)
//                    let indexEnd = phoneNum.startIndex.advancedBy(7)
//                    let range = Range.init(start: indexStart, end: indexEnd)
//                    phoneNum.replaceRange(range, with: "****")
//                    cell.rightLabel.text = phoneNum
//                }else {
//                    cell.bindButton.hidden = false
//                }
//            }
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kHeight(10)
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            //修改登录密码
        }
    }
}

extension AccountViewController {
    func bingAccount(type: Int, snsAccount: UMSocialAccountEntity, handler: (BingAccountData?) -> Void) {
        var userName = ""
        if type == 4 {
            userName = snsAccount.userName
        }
        Server.bingToAccount(type: type, uid: snsAccount.usid, openId: snsAccount.openId, nickname: snsAccount.userName, headImgUrl: snsAccount.iconURL, userName: userName) { (success, msg, value) in
            if success {
                handler(value)
            }else {
                SVToast.showWithError("绑定失败")
            }
        }
    }
    
    func logViewTap(type: LogViewTapType, handler: (BingAccountData?) -> Void) {
        switch type {
        case .Wechat:
            let snsPlatform = UMSocialSnsPlatformManager.getSocialPlatformWithName(UMShareToWechatSession)
            snsPlatform.loginClickHandler(self, UMSocialControllerService.defaultControllerService(), true, { [unowned self]response in
                if response.responseCode == UMSResponseCodeSuccess {
                    let dict = UMSocialAccountManager.socialAccountDictionary()
                    let snsAccount = dict[snsPlatform.platformName] as! UMSocialAccountEntity
                    self.bingAccount(2, snsAccount: snsAccount, handler: handler)
                } else {
                    LogError("微信登录错误 = \(response.message)")
                }
            })
        case .QQ:
            let snsPlatform = UMSocialSnsPlatformManager.getSocialPlatformWithName(UMShareToQQ)
            snsPlatform.loginClickHandler(self, UMSocialControllerService.defaultControllerService(), true, { [unowned self]response in
                if response.responseCode == UMSResponseCodeSuccess {
                    let dict = UMSocialAccountManager.socialAccountDictionary()
                    let snsAccount = dict[snsPlatform.platformName] as! UMSocialAccountEntity
                    self.bingAccount(3, snsAccount: snsAccount, handler: handler)
                } else {
                    LogError("QQ登录错误 = \(response.message)")
                }
            })
            
        case .Weibo:
            let snsPlatform = UMSocialSnsPlatformManager.getSocialPlatformWithName(UMShareToSina)
            snsPlatform.loginClickHandler(self, UMSocialControllerService.defaultControllerService(), true, { [unowned self]response in
                if response.responseCode == UMSResponseCodeSuccess {
                    let dict = UMSocialAccountManager.socialAccountDictionary()
                    let snsAccount = dict[snsPlatform.platformName] as! UMSocialAccountEntity
                    self.bingAccount(4, snsAccount: snsAccount, handler: handler)
                } else {
                    LogError("微博登录错误 = \(response.message)")
                }
            })
        default:""
        }
    }
}
