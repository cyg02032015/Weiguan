//
//  MyReleaseViewController.swift
//  OutLookers
//
//  Created by C on 16/7/18.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let myReleaseCellId = "myReleaseCellId"

class MyReleaseViewController: YGBaseViewController {

    var tableView: UITableView!
    lazy var lists = [FindNotice]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        loadNewData()
        self.tableView.mj_header = MJRefreshStateHeader(refreshingBlock: { [weak self] in
            self?.loadNewData()
        })
        self.tableView.mj_footer = MJRefreshBackStateFooter(refreshingBlock: { [weak self] in
            self?.loadMoreData()
        })
    }
    
    func loadNewData() {
        Server.getFindNoticeList(1, state: 1, isPerson: true) { (success, msg, value) in
            if success {
                guard let obj = value else {return}
                self.lists.removeAll()
                self.lists.appendContentsOf(obj.findNoticeResult)
                self.tableView.reloadData()
                self.tableView.mj_header.endRefreshing()
                if obj.findNoticeResult.count <= 10 {
                    self.tableView.mj_footer.endRefreshingWithNoMoreData()
                }
                self.pageNo = self.pageNo + 1
            } else {
                guard let m = msg else {return}
                SVToast.showWithError(m)
                self.tableView.mj_header.endRefreshing()
            }
        }

    }
    
    override func loadMoreData() {
        Server.getFindNoticeList(pageNo, state: 1, isPerson: true) { (success, msg, value) in
            if success {
                guard let obj = value else {return}
                self.lists.appendContentsOf(obj.findNoticeResult)
                self.tableView.reloadData()
                self.tableView.mj_footer.endRefreshing()
                if obj.findNoticeResult.count <= 10 {
                    self.tableView.mj_footer.endRefreshingWithNoMoreData()
                }
                self.pageNo = self.pageNo + 1
            } else {
                guard let m = msg else {return}
                SVToast.showWithError(m)
                self.tableView.mj_footer.endRefreshing()
            }
        }
    }
    
    func setupSubViews() {
        title = "我的邀约"
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = kHeight(142)
        tableView.registerClass(MyReleaseCell.self, forCellReuseIdentifier: myReleaseCellId)
        tableView.separatorStyle = .None
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
    }
    
    // 按钮点击方法
    func cellSelectedButton(tableView: UITableView, cell: MyReleaseCell, indexPath: NSIndexPath) {
        let obj = lists[indexPath.section]
        cell.detailBlock = { [weak self] btn in
            guard let ws = self else {return}
            let vc = InvitedDetailViewController()
            vc.id = "\(obj.id)"
            ws.navigationController?.pushViewController(vc, animated: true)
        }
        
        cell.stopBlock = { [weak self] btn in
            Server.stopRecruit("\(obj.id)", handler: { (success, msg, value) in
                if success {
                    obj.isRun = true
                    guard let ws = self else {return}
                    ws.lists[indexPath.section] = obj
                    tableView.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: .Automatic)
                } else {
                    guard let m = msg else {return}
                    SVToast.showWithError(m)
                }
            })
        }
        
        cell.editBlock = { btn in
            LogDebug("TODO 编辑")
        }
    }
}

extension MyReleaseViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.lists.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(myReleaseCellId, forIndexPath: indexPath) as! MyReleaseCell
        cell.info = self.lists[indexPath.section]
        cellSelectedButton(tableView, cell: cell, indexPath: indexPath)
        return cell
    }
}
