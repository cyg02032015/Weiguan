//
//  MineViewController.swift
//  OutLookers
//
//  Created by C on 16/6/15.
//  Copyright © 2016年 youngkook. All rights reserved.
//

import UIKit

private let mineHeaderidentifier = "mineHeaderId"
private let messageCellIdentifier = "messageCellId"
private let mineCollectCellIdentifier = "mineCollectId"


class MineViewController: YGBaseViewController {
    
//    var images = ["Order", "account", "score1", "talent", "invitation", "authentication", "feedback", ""]
//    var titles = ["订单量", "钱包", "综合评分", "才艺", "邀约", "认证", "意见反馈", ""]
    var images = ["talent", "invitation", "authentication", "feedback", ""]
    var titles = ["才艺", "邀约", "认证", "意见反馈", ""]
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我"
        
        let setting = setRightNaviItem()
        setting.setImage(UIImage(named: "gear"), forState: .Normal)
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.registerClass(MineHeaderCell.self, forCellReuseIdentifier: mineHeaderidentifier)
        tableView.registerClass(MessageCell.self, forCellReuseIdentifier: messageCellIdentifier)
        tableView.registerClass(MineCollectCell.self, forCellReuseIdentifier: mineCollectCellIdentifier)
        tableView.separatorStyle = .None
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
    }
    
    override func tapMoreButton(sender: UIButton) {
        let vc = SettingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - UITableViewDelegate,UITableViewDataSource
extension MineViewController {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            let vc = MessageViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(mineHeaderidentifier, forIndexPath: indexPath) as! MineHeaderCell
            cell.header.iconHeaderTap { [unowned self] in
                LogInfo("头像")
                let vc = LogViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            cell.tapEditDataClosure { [unowned self] in
                LogInfo("编辑资料")
                let vc = EditDataViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            cell.tapFriendsClosure { [unowned self] in
                let vc = DynamicViewController()
                vc.isPerson = true
                vc.title = "动态"
                self.navigationController?.pushViewController(vc, animated: true)
                SVToast.show()
            }
            cell.tapFollowClosure { [unowned self] in
                let vc = FollowPeopleViewController()
                vc.showType = .Follow
                vc.title = "我关注的人"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            cell.tapFanClosure { [unowned self] in
                let vc = FollowPeopleViewController()
                vc.showType = .Fan
                vc.title = "我的粉丝"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier(messageCellIdentifier, forIndexPath: indexPath) as! MessageCell
            cell.setImgAndText("news11", text: "我的消息")
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(mineCollectCellIdentifier, forIndexPath: indexPath) as! MineCollectCell
            cell.collectionViewSetDelegate(self, indexPath: indexPath)
            return cell
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return kHeight(144)
        case 1: return kHeight(44.9)
        case 2: return kHeight(208)
        default: fatalError("switch default")
        }
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 2 {
            return 0.01
        } else {
            return kHeight(10)
        }
    }
}

extension MineViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(mineCollectionCellIdentifier, forIndexPath: indexPath) as! MineCollectionCell
        cell.imgButton.setImage(UIImage(named: images[indexPath.item]), forState: .Normal)
        cell.label.text = titles[indexPath.item]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        if indexPath.item == 0 {  // 订单
//            
//        } else if indexPath.item == 1 { // 账户
//            let vc = MyAccountViewController()
//            navigationController?.pushViewController(vc, animated: true)
//        } else if indexPath.item == 2 { // 综合评价
//            let vc = Comment2ViewController()     // Comment2ViewController    MyCommentViewController
//            navigationController?.pushViewController(vc, animated: true)
//        } else
        if indexPath.item == 0 { // 才艺
            let vc = MyTalentViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.item == 1 { // 通告
            let vc = MyCircularViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.item == 2 { // 认证
            let vc = AuthenticationViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.item == 3 { // 意见反馈
            let vc = FeedbackViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}