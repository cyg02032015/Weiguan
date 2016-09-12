//
//  HotManViewController.swift
//  OutLookers
//
//  Created by C on 16/7/15.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let hotmanCellId = "hotmanCellId"

class HotManViewController: YGBaseViewController {
    
    private var timeStr: String!
    
    var tableView: UITableView!
    lazy var hotmans = [TalentResult]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timeStr = NSDate().stringFromNowDate()
        setupSubViews()
        tableView.mj_header = MJRefreshStateHeader(refreshingBlock: { [weak self] in
            self?.loadNewData()
            })
        tableView.mj_footer = MJRefreshBackStateFooter(refreshingBlock: { [weak self] in
            self?.loadMoreData()
            })
        loadNewData()
    }
    
    func loadNewData() {
        pageNo = 1
        self.timeStr = NSDate().stringFromNowDate()
        Server.talentList(pageNo, state: 2, timeStr: timeStr) { (success, msg, value) in
            if success {
                guard let listResp  = value else { return }
                self.hotmans.removeAll()
                self.hotmans.appendContentsOf(listResp.list)
                self.tableView.reloadData()
                self.pageNo += 1
                self.tableView.mj_header.endRefreshing()
                if listResp.list.count < 10 {
                    self.tableView.mj_footer.endRefreshingWithNoMoreData()
                }
            }else {
                guard let m = msg else {return}
                SVToast.showWithError(m)
                self.tableView.mj_header.endRefreshing()
            }
        }
    }
    
    override func loadMoreData() {
        Server.talentList(pageNo, state: 2, timeStr: timeStr) { (success, msg, value) in
            if success {
                guard let listResp  = value else { return }
                self.hotmans.appendContentsOf(listResp.list)
                self.pageNo += 1
                self.tableView.reloadData()
                self.tableView.mj_footer.endRefreshing()
                if listResp.list.count < 10 {
                    self.tableView.mj_footer.endRefreshingWithNoMoreData()
                }
            }else {
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
        tableView.registerClass(HotmanCell.self, forCellReuseIdentifier: hotmanCellId)
        tableView.separatorStyle = .None
        tableView.rowHeight = ScreenWidth
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
    }
}

extension HotManViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return hotmans.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(hotmanCellId, forIndexPath: indexPath) as! HotmanCell
        cell.info = hotmans[indexPath.section]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = PHViewController()
        vc.user = "\(hotmans[indexPath.row].userId)"
        vc.scrollTo = 1
        navigationController?.pushViewController(vc, animated: true)
    }
}