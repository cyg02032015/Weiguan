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
                    cell.bindButton.rx_controlEvent(.TouchUpInside).subscribeNext({ [unowned self](sender) in
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
                    cell.bindButton.rx_controlEvent(.TouchUpInside).subscribeNext({ [unowned self](sender) in
                        //绑定微信
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
                    cell.bindButton.rx_controlEvent(.TouchUpInside).subscribeNext({ [unowned self](sender) in
                        //绑定QQ
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
                    cell.bindButton.rx_controlEvent(.TouchUpInside).subscribeNext({ [unowned self](sender) in
                        //绑定微博
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
