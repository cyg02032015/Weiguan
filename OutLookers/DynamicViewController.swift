//
//  DynamicViewController.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/7.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//  个人主页-动态
/*
 若数值为0则显示为赞TA/评论/分享，
 若不为0则显示具体数值；
 在已赞状态下再次单击为取消点赞；
 点击评论跳转详情页；
 点击分享弹出分享列表；
 */

import UIKit

private let dynamicCellIdentifier = "dynamicCellId"

class DynamicViewController: YGBaseViewController {

    var user: String?
    var tableView: UITableView!
    weak var delegate: ScrollVerticalDelegate?
    lazy var dynamicLists = [DynamicResult]()
    var isPerson: Bool = false
    
    private var timeStr: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        timeStr = NSDate().stringFromNowDate()
        loadMoreData()
        tableView.mj_footer = MJRefreshBackStateFooter(refreshingBlock: { [unowned self] in
            self.loadMoreData()
        })
    }
    
    override func loadMoreData() {
        guard let user = self.user else {return}
        Server.dynamicList(pageNo,user: user,state: 1, isPerson: isPerson, isHome: false, isSquare: false, timeStr: self.timeStr) { (success, msg, value) in
            SVToast.dismiss()
            if success {
                guard let object = value else {return}
                self.dynamicLists.appendContentsOf(object.list)
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
        tableView.registerClass(DynamicCell.self, forCellReuseIdentifier: dynamicCellIdentifier)
        tableView.separatorStyle = .None
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = kHeight(559)
        tableView.rowHeight = UITableViewAutomaticDimension
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
    }
}

// MARK: - UITableviewDelegate, UITableviewDatasource
extension DynamicViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dynamicLists.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(dynamicCellIdentifier, forIndexPath: indexPath) as! DynamicCell
        cell.info = dynamicLists[indexPath.section]
        cell.indexPath = indexPath
        cell.delegate = self
        cell.followButton.hidden = true
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let obj = dynamicLists[indexPath.section]
        let vc = DynamicDetailViewController()
        vc.dynamicObj = obj
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
         delegate?.customScrollViewStatus(.BeginDragging)
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView.isKindOfClass(UITableView.self) {
            delegate?.customScrollViewStatus(.DidEndDragging)
        }
    }

    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        delegate?.customScrollViewStatus(.DidEndDecelerating)
    }
}

extension DynamicViewController: DynamicCellDelegate {
    func dynamicCellTapShare(sender: UIButton, indexPath: NSIndexPath) {
        LogInfo("\(sender)   分享")
    }
    
    func dynamicCellTapPraise(sender: UIButton, indexPath: NSIndexPath) {
        if UserSingleton.sharedInstance.isLogin() {
            let object = dynamicLists[indexPath.section]
            if sender.selected {
                Server.cancelLike("\(object.id)", handler: { (success, msg, value) in
                    if success {
                        LogInfo("取消点赞")
                        object.likeCount = object.likeCount - 1
                        object.isLike = false
                        sender.selected = false
                        if object.likeCount <= 0 {
                            sender.setTitle("赞TA", forState: .Normal)
                        } else {
                            sender.setTitle("\(object.likeCount)", forState: .Normal)
                        }
                        self.dynamicLists[indexPath.section] = object
                    } else {
                        SVToast.showWithError(msg!)
                    }
                })
            } else {
                Server.like("\(object.id)", handler: { (success, msg, value) in
                    if success {
                        LogInfo("点赞成功")
                        object.likeCount = object.likeCount + 1
                        object.isLike = true
                        sender.selected = true
                        sender.setTitle("\(object.likeCount)", forState: .Normal)
                        self.dynamicLists[indexPath.section] = object
                    } else {
                        SVToast.showWithError(msg!)
                    }
                })
            }
        } else {
            let logView = YGLogView()
            logView.animation()
            logView.tapLogViewClosure({ (type) in
                LogInHelper.logViewTap(self, type: type)
            })
        }
    }
    
    func dynamicCellTapComment(sender: UIButton, indexPath: NSIndexPath) {
        if UserSingleton.sharedInstance.isLogin() {
            let obj = dynamicLists[indexPath.section]
            let vc = DynamicDetailViewController()
            vc.dynamicObj = obj
            vc.isComment = true
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let logView = YGLogView()
            logView.animation()
            logView.tapLogViewClosure({ (type) in
                LogInHelper.logViewTap(self, type: type)
            })
        }
    }
}