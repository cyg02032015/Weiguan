//
//  FriendViewController.swift
//  OutLookers
//
//  Created by C on 16/7/31.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let friendCollectionCellId = "friendCollectionCellId"

class FriendViewController: YGBaseViewController {

    var titles = ["推荐好友", "通讯录", "微博", "微信", "QQ"]
    var collectionView: UICollectionView!
    var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }
    
    func setupSubViews() {
        title = "找好友"
        
        let layout = UICollectionViewFlowLayout()
        let scaleSize = (ScreenWidth - 2) / 5
        layout.itemSize = CGSize(width: scaleSize, height: kScale(76))
        layout.minimumLineSpacing = 0.01
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: -NaviHeight, left: 0, bottom: 0, right: 0)
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.backgroundColor = kBackgoundColor
        collectionView.registerClass(FriendCollectionCell.self, forCellWithReuseIdentifier: friendCollectionCellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.scrollEnabled = false
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.topLayoutGuideBottom)
            make.left.right.equalTo(collectionView.superview!)
            make.height.equalTo(kScale(76))
        }
        
        let lineV = UIView()
        lineV.backgroundColor = kLineColor
        view.addSubview(lineV)
        lineV.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom)
            make.left.right.equalTo(lineV.superview!)
            make.height.equalTo(1)
        }
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.registerClass(FollowPeopleCell.self, forCellReuseIdentifier: followCellIdentifier)
//        tableView.separatorStyle = .None
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(tableView.superview!)
            make.top.equalTo(lineV.snp.bottom)
        }
    }
}

extension FriendViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}

extension FriendViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(friendCollectionCellId, forIndexPath: indexPath) as! FriendCollectionCell
        cell.label.text = titles[indexPath.item]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        LogInfo(indexPath.item)
    }
}
