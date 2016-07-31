//
//  FeedbackViewController.swift
//  OutLookers
//
//  Created by C on 16/7/31.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let feedbackCellId = "feedbackCellId"

class FeedbackViewController: YGBaseViewController {

    var send: UIButton!
    var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }
    
    func setupSubViews() {
        title = "意见反馈"
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = kBackgoundColor
        tableView.rowHeight = kHeight(220)
        tableView.registerClass(FeedbackCell.self, forCellReuseIdentifier: feedbackCellId)
        tableView.separatorStyle = .None
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
        
        send = setRightNaviItem()
        send.setTitle("发送", forState: .Normal)
    }
    
    override func tapMoreButton(sender: UIButton) {
        LogInfo("发送")
    }
}

extension FeedbackViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(feedbackCellId, forIndexPath: indexPath) as! FeedbackCell
        cell.delegate = self
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}

extension FeedbackViewController: FeedBackCellDelegate {
    func feedBackCellReturnTextFieldText(text: String) {
        LogInfo("textField`  = \(text)")
    }
    
    func feedBackCellReturnTextViewText(text: String) {
        LogInfo("textView = \(text)")
    }
}
