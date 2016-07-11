//
//  FllowViewController.swift
//  OutLookers
//
//  Created by C on 16/6/15.
//  Copyright © 2016年 youngkook. All rights reserved.
//

import UIKit

private let releaseNoticeIdentifier = "releaseNoticeId"
private let releaseTalentIdentifier = "releaseTalentId"
private let dynamicCellIdentifier = "dynamicCellId"

class FollowViewController: YGBaseViewController {

    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = kHeight(564)
        tableView.registerClass(ReleaseNoticeCell.self, forCellReuseIdentifier: releaseNoticeIdentifier)
        tableView.registerClass(ReleaseTalentCell.self, forCellReuseIdentifier: releaseTalentIdentifier)
        tableView.registerClass(DynamicCell.self, forCellReuseIdentifier: dynamicCellIdentifier)
        tableView.separatorStyle = .None
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
    }
}

extension FollowViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(dynamicCellIdentifier, forIndexPath: indexPath) as! DynamicCell
            cell.releaseLabel.text = "发布了动态"
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier(releaseNoticeIdentifier, forIndexPath: indexPath) as! ReleaseNoticeCell
            cell.releaseLabel.text = "发布了通告"
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(releaseTalentIdentifier, forIndexPath: indexPath) as! ReleaseTalentCell
            cell.releaseLabel.text = "发布了才艺"
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableViewAutomaticDimension
        } else if indexPath.section == 1 {
            return kHeight(352)
        } else {
            return kScale(330)
        }
    }
}