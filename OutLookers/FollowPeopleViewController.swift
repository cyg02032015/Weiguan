//
//  FollowPeopleViewController.swift
//  OutLookers
//
//  Created by Youngkook on 16/6/30.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//  // 他的粉丝

import UIKit

private let followCellIdentifier = "followPeopleId"

class FollowPeopleViewController: YGBaseViewController {
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "他的粉丝"
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(FollowPeopleCell.self, forCellReuseIdentifier: followCellIdentifier)
//        tableView.separatorStyle = .None
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
    }
}

extension FollowPeopleViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(followCellIdentifier, forIndexPath: indexPath) as! FollowPeopleCell
        cell.header.iconHeaderTap { 
            LogInfo("tap header")
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return kScale(80)
    }
}