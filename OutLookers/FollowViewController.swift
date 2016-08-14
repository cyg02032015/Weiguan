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
    lazy var lists = [DynamicResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        loadMoreData()
        tableView.mj_footer = MJRefreshBackStateFooter(refreshingBlock: { [weak self] in
            self?.loadMoreData()
        })
    }
    
    override func loadMoreData() {
        Server.followDynamic(pageNo) { (success, msg, value) in
            SVToast.dismiss()
            if success {
                guard let object = value else {return}
                self.lists.appendContentsOf(object.list)
                self.tableView.mj_footer.endRefreshing()
                self.tableView.reloadData()
                self.pageNo = self.pageNo + 1
                if object.list.count < 10 {
                    self.tableView.mj_footer.endRefreshingWithNoMoreData()
                }
            } else {
                SVToast.showWithError(msg!)
                self.tableView.mj_footer.endRefreshing()
            }
        }
    }
    
    func setupSubViews() {
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
        return lists.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(dynamicCellIdentifier, forIndexPath: indexPath) as! DynamicCell
        cell.info = lists[indexPath.section]
        cell.releaseLabel.text = "发布了动态"
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = FriendViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}