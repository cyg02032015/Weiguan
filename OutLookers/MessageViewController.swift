//
//  MessageViewController.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/21.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let messageCellId = "messageCellId"
private let MessageSectionCellId = "MessageSectionCellId"

class MessageViewController: YGBaseViewController {

    var messageNumData: MessageNumData?
    var tableView: UITableView!
    lazy var imgs = ["Praise", "news", "follow-1", "notice"]
    lazy var titles = ["赞了", "评论", "关注", "通知"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }
    
    func setupSubViews() {
        title = "消息"
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.registerClass(MessageSectionCell.self, forCellReuseIdentifier: MessageSectionCellId)
        tableView.registerClass(MessageCell.self, forCellReuseIdentifier: messageCellId)
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }

    }
}

extension MessageViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        } else {
            return 2
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(messageCellId, forIndexPath: indexPath) as! MessageCell
                cell.setImgAndText(imgs[indexPath.row], text: titles[indexPath.row])
            if let _ = self.messageNumData {
                switch indexPath.row {
                    case 0:
                        cell.badgeButton.badgeValue = messageNumData!.like == 0 ? "" : "\(messageNumData!.like)"
                    case 1:
                        cell.badgeButton.badgeValue = messageNumData!.reply == 0 ? "" : "\(messageNumData!.reply)"
                    case 2:
                        cell.badgeButton.badgeValue = messageNumData!.follow == 0 ? "" : "\(messageNumData!.follow)"
                    default:
                        break
                }
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(MessageSectionCellId, forIndexPath: indexPath) as! MessageSectionCell
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let vc = MPraiseViewController()
                navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.row == 1 {
                let vc = MCommentViewController()
                navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.row == 2 {
                let vc = FollowPeopleViewController()
                navigationController?.pushViewController(vc, animated: true)
            } else {
                //TODO 通知
            }
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return kHeight(50)
        } else {
            return kHeight(72)
        }
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return kHeight(10)
        } else {
            return 0.01
        }
    }
}
