//
//  DynamicDetailViewController.swift
//  OutLookers
//
//  Created by C on 16/7/17.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let dynamicDetailCellId = "dynamicDetailCellId"
private let commentCellId = "commentCellId"

class DynamicDetailViewController: YGBaseViewController {

    var tableView: UITableView!
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "动态详情"
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(DynamicDetailVideoCell.self, forCellReuseIdentifier: dynamicDetailCellId)
        tableView.registerClass(CommentCell.self, forCellReuseIdentifier: commentCellId)
        tableView.separatorStyle = .None
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
    }
}

extension DynamicDetailViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 10
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(dynamicDetailCellId, forIndexPath: indexPath) as! DynamicDetailVideoCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(commentCellId, forIndexPath: indexPath) as! CommentCell
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return kHeight(561)
        } else {
            return kHeight(61)
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            
        }
    }
}
