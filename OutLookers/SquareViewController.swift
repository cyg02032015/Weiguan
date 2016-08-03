//
//  SquareViewController.swift
//  OutLookers
//
//  Created by C on 16/7/15.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//  广场

import UIKit

private let dynamicCellId = "dynamicCellId"

class SquareViewController: YGBaseViewController {

    var tableView: UITableView!
    lazy var sqaureLists = [DynamicResult]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        loadMoreData()
        tableView.mj_footer = MJRefreshBackStateFooter(refreshingBlock: { [unowned self] in
            self.loadMoreData()
        })
    }
    
    override func loadMoreData() {
        Server.dynamicList(pageNo, state: 1, isPerson: false, isHome: false, isSquare: true) { (success, msg, value) in
            SVToast.dismiss()
            if success {
                guard let object = value else {return}
                self.sqaureLists.appendContentsOf(object.list)
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
        tableView.estimatedRowHeight = kHeight(559)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.registerClass(DynamicCell.self, forCellReuseIdentifier: dynamicCellId)
        tableView.separatorStyle = .None
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
    }
}

extension SquareViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sqaureLists.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(dynamicCellId, forIndexPath: indexPath) as! DynamicCell
        cell.isSquare = true
        cell.info = sqaureLists[indexPath.section]
        return cell
    }
}
