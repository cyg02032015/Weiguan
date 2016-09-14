//
//  MCommentViewController.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/21.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let mCommentCellId = "mCommentCellId"
private let mCommentReplyCellId = "mCommentReplyCellId"

class MCommentViewController: YGBaseViewController {

    private lazy var comments = [CommentList]()
    var num: Int?
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        loadMoreData()
        guard let _ = num else { return }
        guard num != 0 else { return } //本身为0就不必去发送请求
        releaseReply()
    }
    
    func setupSubViews() {
        title = "评论"
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.registerClass(MCommentCell.self, forCellReuseIdentifier: mCommentCellId)
        tableView.registerClass(MCommentReplyCell.self, forCellReuseIdentifier: mCommentReplyCellId)
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
        
    }
    
    func releaseReply() {
        HttpTool.post(API.releaseReplyRead, parameters: ["userId" : UserSingleton.sharedInstance.userId], complete: { (response) in
            if response["success"].boolValue {
                NSNotificationCenter.defaultCenter().postNotificationName(kMessageReplyReleaseReadNotification, object: nil)
            }
        }) { (error) in
            SVToast.showWithError(error.localizedDescription)
        }
    }
    
    override func loadMoreData() {
        Server.commentList(pageNo, dynamicId: "\(0)") { (success, msg, value) in
            if success {
                guard let object = value else {return}
                self.comments.appendContentsOf(object.lists)
                //self.tableView.mj_footer.endRefreshing()
                self.tableView.reloadData()
                self.pageNo = self.pageNo + 1
                if object.lists.count < 10 {
                    //self.tableView.mj_footer.endRefreshingWithNoMoreData()
                }
            } else {
                guard let m = msg else {return}
                SVToast.showWithError(m)
                //self.tableView.mj_footer.endRefreshing()
            }
        }
    }
}

extension MCommentViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.comments.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let commtent = self.comments[indexPath.row]
//        if commtent.replyId == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(mCommentCellId, forIndexPath: indexPath) as! MCommentCell
            cell.info = commtent
            cell.headImgView.iconHeaderTap({ [weak self] in
                let vc = PHViewController()
                vc.user = "\(commtent.userId)"
                self?.navigationController?.pushViewController(vc, animated: true)
            })
            cell.imgView.tapImageAction({ [weak self] in
                let vc = DynamicDetailViewController()
                let dynamic = DynamicResult()
                dynamic.id = commtent.dynamicId
                dynamic.name = commtent.nickname
                dynamic.photo = commtent.headImgUrl
                dynamic.detailsType = commtent.detailsType
                vc.dynamicObj = dynamic
                vc.shareImage = cell.imgView.image
                self?.navigationController?.pushViewController(vc, animated: true)
            })
            return cell
//        }else {
//            let cell = tableView.dequeueReusableCellWithIdentifier(mCommentReplyCellId, forIndexPath: indexPath) as! MCommentReplyCell
//            cell.headImgView.iconHeaderTap({ [weak self] in
//                let vc = PHViewController()
//                vc.user = "\(commtent.userId)"
//                self?.navigationController?.pushViewController(vc, animated: true)
//                })
//            cell.imgView.tapImageAction({ [weak self] in
//                let vc = DynamicDetailViewController()
//                let dynamic = DynamicResult()
//                dynamic.id = commtent.dynamicId
//                dynamic.name = commtent.nickname
//                dynamic.photo = commtent.headImgUrl
//                dynamic.detailsType = commtent.detailsType
//                vc.dynamicObj = dynamic
//                vc.shareImage = cell.imgView.image
//                self?.navigationController?.pushViewController(vc, animated: true)
//                })
//            cell.replyNameLabel.tapLabelAction({ [weak self] in
//                let vc = PHViewController()
//                vc.user = "\(commtent.replyId)"
//                self?.navigationController?.pushViewController(vc, animated: true)
//                })
//            cell.info = commtent
//            return cell
//        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return kHeight(87)
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
}
