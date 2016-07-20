//
//  Comment2ViewController.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/20.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let myCommentCellId = "myCommentCellId"

class Comment2ViewController: YGBaseViewController {

    var sectionLabel: UILabel!
    var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }
    
    func setupSubViews() {
        title = "我的评价"
        tableView = UITableView(frame: CGRectZero, style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = kHeight(120)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.registerClass(MyCommentCell.self, forCellReuseIdentifier: myCommentCellId)
        tableView.separatorStyle = .None
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
        let head = CommentHead2View()
        head.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: kHeight(88))
        tableView.tableHeaderView = head
    }
}

extension Comment2ViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(myCommentCellId, forIndexPath: indexPath) as! MyCommentCell
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kHeight(40)
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = kBackgoundColor
        sectionLabel = UILabel.createLabel(14, textColor: UIColor(hex: 0x999999))
        view.addSubview(sectionLabel)
        sectionLabel.snp.makeConstraints { (make) in
            make.left.equalTo(sectionLabel.superview!).offset(kScale(16))
            make.centerY.equalTo(sectionLabel.superview!)
        }
        sectionLabel.text = "全部评价(600)"
        return view
    }
}