//
//  DynamicDetailViewController.swift
//  OutLookers
//
//  Created by C on 16/7/17.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SwiftyJSON

private let dynamicDetailCellId = "dynamicDetailCellId"
private let commentCellId = "commentCellId"

class DynamicDetailViewController: YGBaseViewController {

    var dynamicObj: DynamicResult!
    var tableView: UITableView!
    var detailObj: DynamicDetailResp!
    lazy var comments = [CommentList]()
    lazy var req = ReplyCommentReq()
    var toolbar: DXMessageToolBar!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        loadData()
        loadMoreData()
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { [unowned self] in
            self.loadMoreData()
        })
        
    }
    
     func loadData() {
        SVToast.show()
        Server.dynamicDetail("\(dynamicObj.id)") { (success, msg, value) in
            SVToast.dismiss()
            if success {
                guard let object = value else {return}
                self.detailObj = object
                self.tableView.reloadData()
            } else {
                guard let m = msg else {return}
                SVToast.showWithError(m)
            }
        }
    }
    
    override func loadMoreData() {
        Server.commentList(pageNo, dynamicId: "\(dynamicObj.id)") { (success, msg, value) in
            self.tableView.mj_footer.endRefreshing()
            if success {
                guard let object = value else {return}
                if object.lists.count <= 0 {
                    self.tableView.mj_footer.endRefreshingWithNoMoreData()
                    self.tableView.mj_footer.hidden = true
                }
                self.comments.appendContentsOf(object.lists)
                self.tableView.reloadData()
                self.pageNo = self.pageNo + 1
            } else {
                guard let m = msg else {return}
                SVToast.showWithError(m)
            }
        }
    }
    
    func setupSubViews() {
        title = "动态详情"
        let toolbarHeight = DXMessageToolBar.defaultHeight()
        toolbar = DXMessageToolBar(frame: CGRect(x: 0, y: view.gg_height - toolbarHeight, width: ScreenWidth, height: toolbarHeight))
        toolbar.maxTextInputViewHeight = 80
        toolbar.autoresizingMask = [.FlexibleTopMargin, .FlexibleRightMargin]
        toolbar.delegate = self
        view.addSubview(toolbar)
        
        tableView = UITableView(frame: CGRect(x: 0, y: NaviHeight, width: ScreenWidth, height: ScreenHeight - NaviHeight - toolbarHeight), style: .Grouped)
        tableView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = kHeight(561)
        tableView.registerClass(DynamicDetailVideoCell.self, forCellReuseIdentifier: dynamicDetailCellId)
        tableView.registerClass(CommentCell.self, forCellReuseIdentifier: commentCellId)
        tableView.separatorStyle = .None
        view.addSubview(tableView)
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
                let comment = CommentList(fromJson: JSON(nilLiteral: ()))
                comment.createTime = NSDate().stringFromCreate()
                comment.headImgUrl = ""
                comment.nickname = "崔永国"
                comment.text = self.req.text
                comment.id = self.detailObj.id
                comment.detailsType = 0
                comment.replyId = self.req.replyId == nil ? 0 : Int(self.req.replyId!)
                self.comments.append(comment)
                self.tableView.beginUpdates()
                self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: self.comments.count - 1, inSection: 1)], withRowAnimation: .Automatic)
                self.tableView.endUpdates()
            } else {
                guard let m = msg else {return}
                SVToast.showWithError(m)
            }
        })
        toolbar.endEditing(true)
    }
}

extension DynamicDetailViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return detailObj == nil ? 0 : 1
        } else {
            return comments.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(dynamicDetailCellId, forIndexPath: indexPath) as! DynamicDetailVideoCell
            cell.info = detailObj
            cell.userInfo = dynamicObj
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(commentCellId, forIndexPath: indexPath) as! CommentCell
            cell.info = comments[indexPath.row]
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableViewAutomaticDimension
        } else {
            return kHeight(61)
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
        }
    }
}
