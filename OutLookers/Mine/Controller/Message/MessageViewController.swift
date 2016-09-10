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
        addNoficationCenter()
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
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else if section == 1 {
            return 1
        }else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(messageCellId, forIndexPath: indexPath) as! MessageCell
        cell.setImgAndText(imgs[indexPath.row], text: titles[indexPath.row])
        if indexPath.section == 0 {
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
        } else {
            cell.setImgAndText("message", text: "消息")
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! MessageCell
            if indexPath.row == 0 {
                let vc = MPraiseViewController()
                vc.num = Int(cell.badgeButton.badgeValue)
                navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.row == 1 {
                let vc = MCommentViewController()
                vc.num = Int(cell.badgeButton.badgeValue)
                navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.row == 2 {
                let vc = FollowPeopleViewController()
                vc.userId = UserSingleton.sharedInstance.userId
                vc.urlStr = API.myFans
                vc.showType = .Fan
                vc.title = "我的粉丝"
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                //TODO 通知
            }
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        if indexPath.section == 0 {
        return kHeight(50)
//        } else {
//            return kHeight(72)
//        }
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return kHeight(10)
        } else {
            return 0.01
        }
    }
}

extension MessageViewController {
    func addNoficationCenter() {
        _ = NSNotificationCenter.defaultCenter().rx_notification(kMessageLikeReleaseReadNotification).subscribeNext { (notification) in
            self.messageNumData?.like = 0
            self.tableView.reloadData()
        }
        _ = NSNotificationCenter.defaultCenter().rx_notification(kMessageReplyReleaseReadNotification).subscribeNext { (notification) in
            self.messageNumData?.reply = 0
            self.tableView.reloadData()
        }
        _ = NSNotificationCenter.defaultCenter().rx_notification(kMessageFollowReleaseReadNotification).subscribeNext { (notification) in
            self.messageNumData?.follow = 0
            self.tableView.reloadData()
        }
    }
}
