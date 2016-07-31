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

    
    var tableView: UITableView!
    weak var delegate: ScrollVerticalDelegate!
    lazy var dynamicLists = [DynamicResult]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        loadData()
    }
    
    func loadData() {
        Server.dynamicList(1, state: 1, isPerson: false, isHome: false) { (success, msg, value) in
            if success {
                guard let object = value else {return}
                self.dynamicLists = object.list
                self.tableView.reloadData()
            } else {
                SVToast.showWithError(msg!)
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
        cell.indexPath = indexPath
        cell.delegate = self
        cell.followButton.hidden = true
        cell.info = dynamicLists[indexPath.section]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = DynamicDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate && delegate != nil{
            delegate.customScrollViewDidEndDecelerating(false)
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if delegate != nil {
            delegate.customScrollViewDidEndDecelerating(false)
        }
    }
}

extension DynamicViewController: DynamicCellDelegate {
    func dynamicCellTapShare(sender: UIButton, indexPath: NSIndexPath) {
        
    }
    
    func dynamicCellTapPraise(sender: UIButton, indexPath: NSIndexPath) {
        let object = dynamicLists[indexPath.section]
        if sender.selected {
            Server.cancelLike("\(object.id)", handler: { (success, msg, value) in
                if success {
                    LogInfo("取消点赞")
                    object.likeCount = object.likeCount - 1
                    sender.selected = false
                    if object.likeCount <= 0 {
                        sender.setTitle("赞TA", forState: .Normal)
                    } else {
                        sender.setTitle("\(object.likeCount)", forState: .Normal)
                    }
                } else {
                    SVToast.showWithError(msg!)
                }
            })
        } else {
            Server.like("\(object.id)", handler: { (success, msg, value) in
                if success {
                    LogInfo("点赞成功")
                    object.likeCount = object.likeCount + 1
                    sender.selected = true
                    sender.setTitle("\(object.likeCount)", forState: .Normal)
                } else {
                    SVToast.showWithError(msg!)
                }
            })
        }
    }
    
    func dynamicCellTapComment(sender: UIButton, indexPath: NSIndexPath) {
        
    }
}