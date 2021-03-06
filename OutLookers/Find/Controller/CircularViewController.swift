//
//  CircularViewController.swift
//  OutLookers
//
//  Created by C on 16/7/15.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let circularCellId = "circularCellId"

class CircularViewController: YGBaseViewController {

    private var timeStr: String!
    
    var tableView: UITableView!
    lazy var circulars = [FindNotice]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        loadNewData()
        tableView.mj_footer = MJRefreshBackStateFooter(refreshingBlock: { [weak self] in
            self?.loadMoreData()
        })
        tableView.mj_header = MJRefreshStateHeader(refreshingBlock: { [weak self] in
            self?.loadNewData()
        })
    }
    
    func loadNewData() {
        pageNo = 1
        timeStr = NSDate().stringFromNowDate()
        Server.getFindNoticeList(pageNo, state: 2, isPerson: false, timeStr: self.timeStr) { (success, msg, value) in
            self.tableView.mj_footer.endRefreshing()
            if success {
                guard let object = value else {return}
                self.circulars.removeAll()
                self.circulars.appendContentsOf(object.findNoticeResult)
                self.tableView.reloadData()
                self.pageNo = self.pageNo + 1
                self.tableView.mj_header.endRefreshing()
                if object.findNoticeResult.count < 10 {
                    self.tableView.mj_footer.endRefreshingWithNoMoreData()
                }
            } else {
                guard let m = msg else {return}
                SVToast.showWithError(m)
                self.tableView.mj_header.endRefreshing()
            }
        }
    }
    
    override func loadMoreData() {
        Server.getFindNoticeList(pageNo, state: 2, isPerson: false, timeStr: self.timeStr) { (success, msg, value) in
            self.tableView.mj_footer.endRefreshing()
            if success {
                guard let object = value else {return}
                self.circulars.appendContentsOf(object.findNoticeResult)
                self.tableView.reloadData()
                self.pageNo = self.pageNo + 1
                self.tableView.mj_footer.endRefreshing()
                if object.findNoticeResult.count < 10 {
                    self.tableView.mj_footer.endRefreshingWithNoMoreData()
                }
            } else {
                guard let m = msg else {return}
                SVToast.showWithError(m)
                self.tableView.mj_footer.endRefreshing()
            }
        }
    }
    
    func setupSubViews() {
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.delegate = self
        tableView.dataSource = self
                tableView.registerClass(CircularCell.self, forCellReuseIdentifier: circularCellId)
        tableView.separatorStyle = .None
        tableView.rowHeight = kHeight(300)
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
    }
}

extension CircularViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return circulars.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(circularCellId, forIndexPath: indexPath) as! CircularCell
        cell.info = circulars[indexPath.section]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = InvitedDetailViewController()
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! CircularCell
        vc.shareImage = cell.imgView.image
        vc.id = "\(circulars[indexPath.section].id)"
        navigationController?.pushViewController(vc, animated: true)
    }
}