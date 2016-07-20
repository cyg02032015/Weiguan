//
//  TalentCommentViewController.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/20.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

enum CommentType: Int {
    case Talent = 0
    case Invate = 1
//    case 
}

private let myCommentCellId = "myCommentCellId"

class CommentViewController: YGBaseViewController {

    var type: CommentType!
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }
    
    func setupSubViews() {
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
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
    }
}

extension CommentViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(myCommentCellId, forIndexPath: indexPath) as! MyCommentCell
        return cell
    }
}