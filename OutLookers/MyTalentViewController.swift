//
//  MyTalentViewController.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/18.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let myTalentCellId = "myTalentCellId"

class MyTalentViewController: YGBaseViewController {

    var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }
    
    func setupSubViews() {
        title = "我的才艺"
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.backgroundColor = kBackgoundColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = kHeight(273)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.registerClass(MyTalentCell.self, forCellReuseIdentifier: myTalentCellId)
        tableView.separatorStyle = .None
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
    }
}

extension MyTalentViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(myTalentCellId, forIndexPath: indexPath) as! MyTalentCell
        cell.collectionViewSetDelegate(self, indexPath: indexPath)
        cell.delegate = self
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kHeight(10)
    }
}

// MARK: - MyTalentCellDelegate
extension MyTalentViewController: MyTalentCellDelegate {
    func myTalentTapEdit(sender: UIButton) {
        LogInfo("tapEdit")
    }
    
    func myTalentTapDelete(sender: UIButton) {
        LogInfo("tapDelete")
    }
    
    func myTalentTapDetail(sender: UIButton) {
        LogInfo("tapDetail")
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension MyTalentViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(releasePictureCollectionCellIdentifier, forIndexPath: indexPath) as! PhotoCollectionCell
        cell.backgroundColor = UIColor.grayColor()
        if collectionView.tag == 1 && indexPath.item == 2 {
            cell.imgVideoCover.hidden = false
        } else {
            cell.imgVideoCover.hidden = true
        }
        return cell
    }
}
