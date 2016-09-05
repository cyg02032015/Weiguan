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
    var share: YGShare!
    
    private var timeStr: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        loadNewData()
        
        tableView.mj_header = MJRefreshStateHeader(refreshingBlock: { [weak self] in
            self?.loadNewData()
        })
        tableView.mj_footer = MJRefreshBackStateFooter(refreshingBlock: { [weak self] in
            self?.loadMoreData()
        })
    }
    
    func loadNewData() {
        timeStr = NSDate().stringFromNowDate()
        Server.dynamicList(1,user: UserSingleton.sharedInstance.userId ,state: 1, isPerson: false, isHome: false, isSquare: true, timeStr: self.timeStr) { (success, msg, value) in
            SVToast.dismiss()
            if success {
                guard let object = value else {return}
                self.sqaureLists.removeAll()
                self.sqaureLists.appendContentsOf(object.list)
                self.tableView.mj_header.endRefreshing()
                self.tableView.reloadData()
                if object.list.count < 10 {
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
        Server.dynamicList(pageNo, user: UserSingleton.sharedInstance.userId ,state: 1, isPerson: false, isHome: false, isSquare: true, timeStr: self.timeStr) { (success, msg, value) in
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
        cell.indexPath = indexPath
        cell.info = sqaureLists[indexPath.section]
        cell.delegate = self
        cell.headImgView.iconHeaderTap { [weak self] in
            let vc = PHViewController()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let obj = sqaureLists[indexPath.section]
        let vc = DynamicDetailViewController()
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! DynamicCell
        vc.dynamicObj = obj
        vc.shareImage = cell.bigImgView.image
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SquareViewController: DynamicCellDelegate, FollowProtocol {
    func dynamicCellTapShare(sender: UIButton, indexPath: NSIndexPath) {
        let dy = self.sqaureLists[indexPath.section]
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! DynamicCell
        var type: YGShareType = .DYVisitor
        let shareModel = YGShareModel()
        shareModel.shareNickName = "分享自\(dy.name)的纯氧作品, 一起来看~"
        if UserSingleton.sharedInstance.userId == "\(dy.userId)" {
            type = .DYHost
            shareModel.shareNickName = "我的纯氧作品, 一起来看~"
        }else if !isEmptyString(UserSingleton.sharedInstance.userId) {
            type = .DYHost
        }
        shareModel.shareID = "index.html#trends-details?listId=\(dy.id)"
        shareModel.shareImage = cell.bigImgView.image
        let sharetuple = YGShareHandler.handleShareInstalled(type)
        share = YGShare(frame: CGRectZero, imgs: sharetuple.images, titles: sharetuple.titles)
        share.shareModel = shareModel
        share.animation()
    }
    
    func dynamicCellTapPraise(sender: UIButton, indexPath: NSIndexPath) {
        if UserSingleton.sharedInstance.isLogin() {
            let object = sqaureLists[indexPath.section]
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
                        self.sqaureLists[indexPath.section] = object
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
                        self.sqaureLists[indexPath.section] = object
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
            let obj = sqaureLists[indexPath.section]
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
    
    // 关注按钮点击
    func dynamicCellTapFollow(sender: UIButton, indexPath: NSIndexPath) {
        if UserSingleton.sharedInstance.isLogin() {
            let object = sqaureLists[indexPath.section]
            Server.followUser("\(object.userId)") { (success, msg, value) in
                if success {
                    self.modifyFollow(sender)
                    object.follow = 1
                    self.sqaureLists[indexPath.section] = object
                } else {
                    guard let m = msg else {return}
                    SVToast.showWithError(m)
                }
            }
        } else {
            let logView = YGLogView()
            logView.animation()
            logView.tapLogViewClosure({ (type) in
                LogInHelper.logViewTap(self, type: type)
            })
        }
    }
}
