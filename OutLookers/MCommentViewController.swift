//
//  MCommentViewController.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/21.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let mCommentCellId = "mCommentCellId"

class MCommentViewController: YGBaseViewController {

    var num: Int?
    var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        guard num != 0 else { return }
        releaseReply()
    }
    
    func setupSubViews() {
        title = "评论"
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.registerClass(MCommentCell.self, forCellReuseIdentifier: mCommentCellId)
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
}

extension MCommentViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(mCommentCellId, forIndexPath: indexPath) as! MCommentCell
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return kHeight(87)
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
}
