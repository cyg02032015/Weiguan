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
    override func viewDidLoad() {
        super.viewDidLoad()
        LogWarn("viewdidload")
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
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(dynamicCellIdentifier, forIndexPath: indexPath) as! DynamicCell
        if indexPath.section == 0 {
            cell.details.text = "afaslfkjs;lfkasjdflaskfjlsa;fkasfl;askhgaslgkhasglsakhgsaklghaskgljahsgklsjghsakghsakgjahsgkasjghaklsgjhaskdgsahjgksajghaksghjsadkgjhasgkajshgdksadjghsakgjhaskghasgkhasgkashgk"
        } else if indexPath.section == 1 {
            cell.details.text = "afaslfkjs;lfkasjdflaskfjlsa;fkasfl;"
        } else {
            cell.details.text = "afaslfkjs;lfkasjdflaskfjlsa;fkasfl;asdfasdfsadfsafasldfksajflsafjas;flasjfalfj"
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
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