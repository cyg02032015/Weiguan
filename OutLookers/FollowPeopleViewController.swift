//
//  FollowPeopleViewController.swift
//  OutLookers
//
//  Created by Youngkook on 16/6/30.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//  // 他的粉丝

import UIKit

private let followCellIdentifier = "followPeopleId"

enum ShowType: Int {
    case Follow = 0
    case Fan = 1
}

class FollowPeopleViewController: YGBaseViewController {
    
    var showType: ShowType!
    var tableView: UITableView!
    lazy var myFollows = [FollowList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        SVToast.show()
        loadMoreData()
        tableView.mj_footer = MJRefreshBackStateFooter(refreshingBlock: { [weak self] in
            self?.loadMoreData()
        })
    }
    
    override func loadMoreData() {
        if showType == .Follow {
            Server.myFollow(pageNo) { [unowned self] (success, msg, value) in
                SVToast.dismiss()
                if success {
                    guard let object = value else {return}
                    self.myFollows.appendContentsOf(object.list)
                    self.tableView.mj_footer.endRefreshing()
                    self.tableView.reloadData()
                    self.pageNo = self.pageNo + 1
                    if object.list.count < 10 {
                        self.tableView.mj_footer.endRefreshingWithNoMoreData()
                    }
                } else {
                    self.tableView.mj_footer.endRefreshing()
                    guard let m = msg else {return}
                    SVToast.showWithError(m)
                }
            }
        } else {
            Server.myFans(pageNo, handler: { [unowned self](success, msg, value) in
                SVToast.dismiss()
                if success {
                    guard let object = value else {return}
                    self.myFollows.appendContentsOf(object.list)
                    self.tableView.mj_footer.endRefreshing()
                    self.tableView.reloadData()
                    self.pageNo = self.pageNo + 1
                    if object.list.count < 10 {
                        self.tableView.mj_footer.endRefreshingWithNoMoreData()
                    }
                } else {
                    self.tableView.mj_footer.endRefreshing()
                    guard let m = msg else {return}
                    SVToast.showWithError(m)
                }
            })
        }
        
    }
    
    func setupSubViews() {
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(FollowPeopleCell.self, forCellReuseIdentifier: followCellIdentifier)
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
    }
}

// MARK: - UITableViewDelegate,UITableViewDataSource
extension FollowPeopleViewController {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(followCellIdentifier, forIndexPath: indexPath) as! FollowPeopleCell
        cell.header.iconHeaderTap { 
            LogInfo("tap header")
        }
        cell.showType = showType
        cell.info = myFollows[indexPath.row]

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFollows.count

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return kHeight(80)
    }
}