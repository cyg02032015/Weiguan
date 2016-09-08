//
//  TalentViewController.swift
//  OutLookers
//
//  Created by C on 16/7/5.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//
/*
 才艺介绍最多展示三行文字；
 作品可以左右滑动切换查阅；
 单击内容区域进入详情页，
 等同于“查看详情”
 */

import UIKit

private let talentCellIdentifier = "talentCellId"

class TalentViewController: YGBaseViewController {

    var user: String?
    lazy var data = [String]()
    var tableView: UITableView!
    weak var delegate: ScrollVerticalDelegate?
    lazy var lists = [Result]()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        LogInfo("viewwillappear")
    }
    
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
        guard let user = self.user else {return}
        Server.talentList4(pageNo, state: 1, user: user) { (success, msg, value) in
            SVToast.dismiss()
            if success {
                guard let list = value else {return}
                self.lists.appendContentsOf(list)
                self.tableView.mj_footer.endRefreshing()
                self.tableView.reloadData()
                self.pageNo = self.pageNo + 1
                if list.count < 10 {
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
        tableView.registerClass(TalentTableViewCell.self, forCellReuseIdentifier: talentCellIdentifier)
        tableView.separatorStyle = .None
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = kHeight(602)
        tableView.rowHeight = UITableViewAutomaticDimension
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
    }
}

// MARK: - UITableviewDelegate, UITableviewDatasource
extension TalentViewController {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = TalentDetailViewController()
        vc.id = self.lists[indexPath.section].id
        navigationController?.pushViewController(vc, animated: true)
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(talentCellIdentifier, forIndexPath: indexPath) as! TalentTableViewCell
        cell.info = lists[indexPath.section]
        cell.detailBlock { [weak self](sender) in
            let vc = TalentDetailViewController()
            vc.id = self?.lists[indexPath.section].id
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
        cell.shareBlock { (sender) in
            LogInfo("分享")
        }
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return lists.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        if scrollView.isKindOfClass(UITableView.self) {
            delegate?.customScrollViewStatus(.BeginDragging)
        }
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView.isKindOfClass(UITableView.self) {
            delegate?.customScrollViewStatus(.DidEndDragging)
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView.isKindOfClass(UITableView.self) {
            delegate?.customScrollViewStatus(.DidEndDecelerating)
        }
    }
}