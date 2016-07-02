//
//  PersonalDataViewController.swift
//  OutLookers
//
//  Created by C on 16/7/1.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let personalHeaderidentifier = "personalHeaderId"

class PersonalDataViewController: YGBaseViewController {

    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我"
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(PersonalHeaderCell.self, forCellReuseIdentifier: personalHeaderidentifier)
        tableView.separatorStyle = .None
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
    }
}

extension PersonalDataViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(personalHeaderidentifier, forIndexPath: indexPath) as! PersonalHeaderCell
        cell.header.iconHeaderTap {
            LogInfo("头像")
        }
        cell.tapEditDataClosure {
            LogInfo("编辑资料")
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
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return kHeight(144)
    }
}
