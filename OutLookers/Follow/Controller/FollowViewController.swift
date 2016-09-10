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
    private var timeStr: String!
    
    private var share: YGShare!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if UserSingleton.sharedInstance.isLogin() {
            if self.lists.count == 0 {
                tableView.mj_header.beginRefreshing()
            }
        } else {
            LogError("未登录无法获取关注用户")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        tableView.mj_header = MJRefreshHeader(refreshingBlock: { [weak self] in
            self?.loadNewData()
        })
            
        tableView.mj_footer = MJRefreshBackStateFooter(refreshingBlock: { [weak self] in
            self?.loadMoreData()
        })
    }
    
    func loadNewData() {
        pageNo = 1
        timeStr = NSDate().stringFromNowDate()
        Server.followDynamic(pageNo, timeStr: timeStr) { (success, msg, value) in
            SVToast.dismiss()
            if success {
                guard let object = value else {return}
                self.lists.removeAll()
                self.lists.appendContentsOf(object.list)
                self.tableView.mj_header.endRefreshing()
                self.tableView.reloadData()
                if object.list.count < 10 {
                    self.tableView.mj_footer.endRefreshingWithNoMoreData()
                }
                self.pageNo += 1
            } else {
                SVToast.showWithError(msg!)
                self.tableView.mj_header.endRefreshing()
            }
        }
    }
    
    override func loadMoreData() {
        Server.followDynamic(pageNo,  timeStr: timeStr) { (success, msg, value) in
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
        let info = lists[indexPath.section]
        cell.info = info
        cell.indexPath = indexPath
        cell.delegate = self
        cell.headImgView.iconHeaderTap { [weak self] in
            let vc = PHViewController()
            vc.user = "\(info.userId)"
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let obj = lists[indexPath.section]
        let vc = DynamicDetailViewController()
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! DynamicCell
        vc.dynamicObj = obj
        vc.shareImage = cell.bigImgView.image
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension FollowViewController: DynamicCellDelegate, FollowProtocol {
    func dynamicCellTapShare(sender: UIButton, indexPath: NSIndexPath) {
        let dy = self.lists[indexPath.section]
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! DynamicCell
        var type: YGShareType = .DYVisitor
        let shareModel = YGShareModel()
        shareModel.shareNickName = "分享自\"\(dy.name)\"的纯氧作品, 一起来看~"
        if UserSingleton.sharedInstance.userId == "\(dy.userId)" {
            type = .DYHost
            shareModel.shareNickName = "我的纯氧作品, 一起来看~"
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
            let object = lists[indexPath.section]
            if sender.selected {
                Server.cancelLike("\(object.id)", handler: { (success, msg, value) in
                    if success {
                        LogInfo("取消点赞")
                        object.likeCount = object.likeCount - 1
                        object.isLike = 0
                        sender.selected = false
                        if object.likeCount <= 0 {
                            sender.setTitle("赞TA", forState: .Normal)
                        } else {
                            sender.setTitle("\(object.likeCount)", forState: .Normal)
                        }
                        self.lists[indexPath.section] = object
                    } else {
                        SVToast.showWithError(msg!)
                    }
                })
            } else {
                Server.like("\(object.id)", handler: { (success, msg, value) in
                    if success {
                        LogInfo("点赞成功")
                        object.likeCount = object.likeCount + 1
                        object.isLike = 1
                        sender.selected = true
                        sender.setTitle("\(object.likeCount)", forState: .Normal)
                        self.lists[indexPath.section] = object
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
            let obj = lists[indexPath.section]
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
            let object = lists[indexPath.section]
            Server.followUser("\(object.userId)") { (success, msg, value) in
                if success {
                    self.modifyFollow(sender)
                    object.follow = 1
                    self.lists[indexPath.section] = object
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
