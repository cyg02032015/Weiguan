//
//  DynamicDetailViewController.swift
//  OutLookers
//
//  Created by C on 16/7/17.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON
import ZFPlayer
import UITableView_FDTemplateLayoutCell

private let dynamicDetailCellId = "dynamicDetailCellId"
private let commentCellId = "commentCellId"

class DynamicDetailViewController: YGBaseViewController {
    var fromPersonalVC: Bool = false
    var dynamicObj: DynamicResult!
    var tableView: UITableView!
    var detailObj: DynamicDetailResp!
    lazy var comments = [CommentList]()
    lazy var req = ReplyCommentReq()
    var toolbar: DXMessageToolBar!
    var shareView: YGShare!
    var moreShareView: YGShare!
    var moreButton: UIButton!
    var isComment = false
    var likeListObj: LikeListResp!
    var shareImage: UIImage!
    
    private var isSelf: Bool = false
    private var isFollow: IsFollowData?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        ZFPlayerView.sharedPlayerView().pause()
        ZFPlayerView.sharedPlayerView().resetPlayer()
    }
    
    override func viewDidDisappear(animated: Bool) {
        ZFPlayerView.sharedPlayerView().pause()
        ZFPlayerView.sharedPlayerView().resetPlayer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var type: YGShareType = .DYVisitor
        if UserSingleton.sharedInstance.userId == "\(dynamicObj.userId)" {
            // 是自己没有关注按钮
            isSelf = true
            type = .DYHost
        }
        let tuple = YGShareHandler.handleShareInstalled(type)
        shareView = YGShare(frame: CGRectZero, imgs: tuple.0, titles: tuple.2)
        loadData()
        setupSubViews()
        tableView.mj_footer = MJRefreshBackStateFooter(refreshingBlock: { [weak self] in
            self?.loadMoreData()
            })
    }
    
    func loadData() {
        SVToast.show()
        Server.dynamicDetail("\(dynamicObj.id)") { [weak self](success, msg, value) in
            SVToast.dismiss()
            if success {
                guard let object = value else {return}
                self?.detailObj = object
                self?.getIsFollow()
                Server.likeList(1, dynamicId: "\(object.id)", handler: { (success, msg, value) in
                    if success {
                        guard let obj = value else {return}
                        self?.likeListObj = obj
                        self?.loadMoreData()
                        self?.tableView.reloadData()
                    } else {
                        LogError("无法获取点赞列表")
                    }
                })
            } else {
                guard let m = msg else {return}
                SVToast.showWithError(m)
            }
        }
        
    }
    
    func getIsFollow() {
        Server.isFollowStatus(UserSingleton.sharedInstance.userId, followUserId: "\(dynamicObj.userId)") { (success, msg, value) in
            if success {
                self.isFollow = value
            }else {
                guard let m = msg else {return}
                SVToast.showWithError(m)
            }
        }
    }
    
    override func loadMoreData() {
        Server.commentList(pageNo, dynamicId: "\(dynamicObj.id)") { (success, msg, value) in
            if success {
                guard let object = value else {return}
                self.comments.appendContentsOf(object.lists)
                self.tableView.mj_footer.endRefreshing()
                self.tableView.reloadData()
                self.pageNo = self.pageNo + 1
                if object.lists.count < 10 {
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
        title = "动态详情"
        moreButton = setRightNaviItem()
        moreButton.setImage(UIImage(named: "more1"), forState: .Normal)
        
        let toolbarHeight = DXMessageToolBar.defaultHeight()
        toolbar = DXMessageToolBar(frame: CGRect(x: 0, y: view.gg_height - toolbarHeight, width: ScreenWidth, height: toolbarHeight))
        toolbar.maxTextInputViewHeight = 80
        toolbar.autoresizingMask = [.FlexibleTopMargin, .FlexibleRightMargin]
        toolbar.delegate = self
        view.addSubview(toolbar)
        //评论限制100字以内
        _ = toolbar.inputTextView.rx_text.filter({ (text) -> Bool in
            return text.characters.count <= 100
        }).subscribeNext({ [unowned self](text) in
            self.toolbar.inputTextView.text = text
            self.req.text = text
        })
        tableView = UITableView(frame: CGRect(x: 0, y: NaviHeight, width: ScreenWidth, height: ScreenHeight - NaviHeight - toolbarHeight), style: .Grouped)
        tableView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = kHeight(561)
        tableView.registerClass(DynamicDetailVideoCell.self, forCellReuseIdentifier: dynamicDetailCellId)
        tableView.registerClass(CommentCell.self, forCellReuseIdentifier: commentCellId)
        tableView.separatorStyle = .None
        tableView.fd_debugLogEnabled = false
        view.addSubview(tableView)
    }
    
    override func tapMoreButton(sender: UIButton) {
        let shareModel = YGShareModel()
        shareModel.shareID = "trends.html?aid=\(dynamicObj.id)"
        shareModel.shareImage = self.shareImage
        
        if UserSingleton.sharedInstance.userId == "\(dynamicObj.userId)" {
            shareModel.shareNickName = "我的纯氧作品, 一起来看~"
        }else {
            shareModel.shareNickName = "分享自\"\(dynamicObj.name)\"的纯氧作品, 一起来看~"
        }
        shareModel.shareInfo = detailObj.text
        shareView.shareModel = shareModel
        shareView.animation()
    }
    
    func scrollViewToBottom(animated: Bool) {
        if tableView.contentSize.height > tableView.gg_height {
            let offset = CGPoint(x: 0, y: tableView.contentSize.height - tableView.gg_height)
            tableView.setContentOffset(offset, animated: animated)
        }
    }
}

extension DynamicDetailViewController: DXMessageToolBarDelegate {
    func didChangeFrameToHeight(toHeight: CGFloat) {
        UIView.animateWithDuration(0.3) {
            var rect = self.tableView.frame
            rect.origin.y = NaviHeight
            rect.size.height = self.view.gg_height - toHeight - NaviHeight
            self.tableView.frame = rect
        }
        scrollViewToBottom(false)
    }
    
    func inputTextViewWillBeginEditing(messageInputTextView: XHMessageTextView!) {
        req.dynamicId = "\(detailObj.id)"
    }
    
    func didSendText(text: String!) {
        if isEmptyString(text) {
            SVToast.showWithError("评论为空")
            return
        }
        req.text = text
        SVToast.show()
        Server.replyComment(req, handler: { (success, msg, value) in
            SVToast.dismiss()
            if success {
                SVToast.showWithSuccess("发表成功")
//                let comment = CommentList(fromJson: JSON(nilLiteral: ()))
//                comment.createTime = NSDate().stringFromCreate()
//                comment.headImgUrl = UserSingleton.sharedInstance.nickname
//                comment.nickname = UserSingleton.sharedInstance.nickname
//                comment.text = self.req.text
//                comment.id = self.dynamicObj.id
//                comment.detailsType = 0
//                comment.replyId = self.req.replyId == nil ? 0 : Int(self.req.replyId!)
//                self.comments.append(comment)
//                self.tableView.beginUpdates()
//                self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: self.comments.count - 1, inSection: 1)], withRowAnimation: .Automatic)
//                self.tableView.endUpdates()
                self.comments.removeAll()
                self.pageNo = 1
                self.loadMoreData()
            } else {
                guard let m = msg else {return}
                SVToast.showWithError(m)
            }
        })
        toolbar.endEditing(true)
    }
}

extension DynamicDetailViewController: VideoPlayerProtocol {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if detailObj == nil || likeListObj == nil {
                return 0
            } else {
                return 1
            }
        } else {
            return comments.count
        }
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableViewAutomaticDimension
        }
        return kHeight(61)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(dynamicDetailCellId, forIndexPath: indexPath) as! DynamicDetailVideoCell
            cell.isSelf = self.isSelf
            cell.userInfo = dynamicObj
            cell.likeListInfo = self.likeListObj
            cell.delegate = self
            cell.tableView = tableView
            cell.info = detailObj
            cell.toTalentClick = { [unowned self](index) in
                let vc = TalentDetailViewController()
                vc.id = self.detailObj.talentList[index].id
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if let _ = isFollow {
                cell.isFollow = isFollow
            }
            cell.headImgView.iconHeaderTap({ [unowned self] in
                if self.fromPersonalVC { return }
                let vc = PHViewController()
                vc.user = "\(self.detailObj.userId)"
                self.navigationController?.pushViewController(vc, animated: true)
            })
            cell.clickHeaderIcon = { (userId) in
                let vc = PHViewController()
                vc.user = userId
                self.navigationController?.pushViewController(vc, animated: true)
            }
            //播放视频
            //_ = cell.playerButton.rx_controlEvent(.TouchUpInside).subscribeNext({ [unowned self, unowned cell](sender) in
            if self.detailObj.isVideo != "1" {
               let player = self.player(NSURL(string: self.detailObj.pictureList.first!.url.addVideoPath())!, tableView: tableView, indexPath: indexPath, imageView: cell.playerView, tag: 111)
                player.hidden = false
            }
            //}).addDisposableTo(disposeBag)
            return cell
        } else {
            let info = comments[indexPath.row]
            let cell = tableView.dequeueReusableCellWithIdentifier(commentCellId, forIndexPath: indexPath) as! CommentCell
            cell.info = info
            cell.headImgView.iconHeaderTap({ [unowned self] in
                guard "\(info.userId)" != UserSingleton.sharedInstance.userId else { return }
                let vc = PHViewController()
                vc.user = "\(info.userId)"
                self.navigationController?.pushViewController(vc, animated: true)
                })
            cell.replyNickNameLabel.tapLabelAction({ [unowned self] in
                guard "\(info.replyId)" != UserSingleton.sharedInstance.userId else { return }
                let vc = PHViewController()
                vc.user = "\(info.replyId)"
                self.navigationController?.pushViewController(vc, animated: true)
            })
            return cell
           }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableViewAutomaticDimension
        } else {
            return tableView.fd_heightForCellWithIdentifier(commentCellId, cacheByIndexPath: indexPath, configuration: { [unowned self](cell) in
                let cel = cell as! CommentCell
                cel.info = self.comments[indexPath.row]
            })
        }
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return kHeight(10)
        } else {
            return 0.01
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            let obj = comments[indexPath.row]
            req.replyId = "\(obj.replyId)"
            if UserSingleton.sharedInstance.isLogin() {
                if self.toolbar.inputTextView.isFirstResponder() {
                    return
                }
                self.toolbar.inputTextView.becomeFirstResponder()
            } else {
                let logView = YGLogView()
                logView.animation()
                logView.tapLogViewClosure({ (type) in
                    LogInHelper.logViewTap(self, type: type)
                })
            }
        }
    }
}

extension DynamicDetailViewController: DynamicDetailDelegate, FollowProtocol, DeleteDynamicProtocol {
    func dynamicDetailTapShare(sender: UIButton) {
        let shareModel = YGShareModel()
        shareModel.shareID = "trends.html?aid=\(dynamicObj.id)"
        shareModel.shareImage = self.shareImage
        
        if UserSingleton.sharedInstance.userId == "\(dynamicObj.userId)" {
            shareModel.shareNickName = "我的纯氧作品, 一起来看~"
        }else {
            shareModel.shareNickName = "分享自\"\(dynamicObj.name)\"的纯氧作品, 一起来看~"
        }
        shareModel.shareInfo = detailObj.text
        shareView.shareModel = shareModel
        shareView.animation()
        shareView.deleteClick = { [weak self] in
            SVToast.show()
            self!.deleteDynamic("\(self!.dynamicObj.id)", handler: { [weak self](success, msg) in
                if success {
                    self?.navigationController?.popViewControllerAnimated(true)
                    delay(0.5, task: { 
                        SVProgressHUD.setMinimumDismissTimeInterval(0.2)
                        SVProgressHUD.showSuccessWithStatus("删除成功")
                    })
                }else {
                    if let _ = msg {
                        SVToast.showWithError(msg!)
                    }else {
                        SVToast.showWithError("删除失败")
                    }
                }
                })
        }
    }
    
    func dynamicDetailTapFollow(sender: UIButton) {
        if UserSingleton.sharedInstance.isLogin() {
            let object = detailObj
            Server.followUser("\(object.userId)") { (success, msg, value) in
                if success {
                    self.modifyFollow(sender)
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
    
    func dynamicDetailTapPraise(sender: UIButton) {
        if UserSingleton.sharedInstance.isLogin() {
            let object = detailObj
            if sender.selected {
                Server.cancelLike("\(object.id)", handler: { (success, msg, value) in
                    if success {
                        LogInfo("取消点赞")
                        sender.selected = false
                    } else {
                        SVToast.showWithError(msg!)
                    }
                })
            } else {
                Server.like("\(object.id)", handler: { (success, msg, value) in
                    if success {
                        LogInfo("点赞成功")
                        sender.selected = true
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
    
    func dynamicDetailTapComment(sender: UIButton) {
        if UserSingleton.sharedInstance.isLogin() {
            if toolbar.inputTextView.isFirstResponder() {
                return
            }
            toolbar.inputTextView.becomeFirstResponder()
            toolbar.inputTextView.placeholderText = "评论一下"
        } else {
            let logView = YGLogView()
            logView.animation()
            logView.tapLogViewClosure({ (type) in
                LogInHelper.logViewTap(self, type: type)
            })
        }
    }
}
