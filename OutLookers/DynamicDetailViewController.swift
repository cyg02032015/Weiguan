//
//  DynamicDetailViewController.swift
//  OutLookers
//
//  Created by C on 16/7/17.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let dynamicDetailCellId = "dynamicDetailCellId"
private let commentCellId = "commentCellId"

class DynamicDetailViewController: YGBaseViewController {

    var tableView: UITableView!
    
    
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
        title = "动态详情"
        let toolbarHeight = DXMessageToolBar.defaultHeight()
        let toolbar = DXMessageToolBar(frame: CGRect(x: 0, y: view.gg_height - toolbarHeight, width: ScreenWidth, height: toolbarHeight))
        toolbar.maxTextInputViewHeight = 80
        toolbar.autoresizingMask = [.FlexibleTopMargin, .FlexibleRightMargin]
        toolbar.delegate = self
        view.addSubview(toolbar)
        
        tableView = UITableView(frame: CGRect(x: 0, y: NaviHeight, width: ScreenWidth, height: ScreenHeight - NaviHeight - toolbarHeight), style: .Grouped)
        tableView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(DynamicDetailVideoCell.self, forCellReuseIdentifier: dynamicDetailCellId)
        tableView.registerClass(CommentCell.self, forCellReuseIdentifier: commentCellId)
        tableView.separatorStyle = .None
        tableView.tableFooterView = UIView()
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
    
    func didSendText(text: String!) {
        LogInfo("send --- = \(text)")
    }
}

extension DynamicDetailViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 10
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(dynamicDetailCellId, forIndexPath: indexPath) as! DynamicDetailVideoCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(commentCellId, forIndexPath: indexPath) as! CommentCell
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return kHeight(561)
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
            
        }
    }
}
