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
    
    var images = ["Order", "account", "score", "talent", "announcement", "authentication", "", ""]
    var titles = ["订单量", "账户", "综合评分", "才艺", "通告", "认证", "", ""]
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我"
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = kBackgoundColor
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
}

// MARK: - UITableViewDelegate,UITableViewDataSource
extension MineViewController {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(mineHeaderidentifier, forIndexPath: indexPath) as! MineHeaderCell
            cell.header.iconHeaderTap {
                LogInfo("头像")
            }
            cell.tapEditDataClosure { [unowned self] in
                LogInfo("编辑资料")
                let vc = EditDataViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            cell.tapFriendsClosure {
                LogInfo("好友")
            }
            cell.tapFollowClosure {
                LogInfo("关注")
            }
            cell.tapFanClosure {
                LogInfo("粉丝")
            }
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier(messageCellIdentifier, forIndexPath: indexPath)
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
        return 10
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = kBackgoundColor
        return view
    }
}

extension MineViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(mineCollectionCellIdentifier, forIndexPath: indexPath) as! MineCollectionCell
        if indexPath.item == 0 {
            cell.imgButton.badgeValue = "40"
        }
        cell.imgButton.setImage(UIImage(named: images[indexPath.item]), forState: .Normal)
        cell.label.text = titles[indexPath.item]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.item == 0 {
            
        } else if indexPath.item == 1 {
            
        } else if indexPath.item == 2 {
            
        } else if indexPath.item == 3 {
            let vc = MyTalentViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.item == 4 {
            let vc = MyCircularViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.item == 5 {
            let vc = AuthenticationViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}