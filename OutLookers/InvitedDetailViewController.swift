//
//  InvitedDetailViewController.swift
//  OutLookers
//
//  Created by C on 16/8/28.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let invitedCellId = "invitedCellId"

class InvitedDetailViewController: YGBaseViewController {

    var id: String = ""
    var tableView: UITableView!
    var noticeObj: FindNoticeDetailResp!
    var header: InvitedHeaderView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        loadData()
    }
    
    func loadData() {
        Server.findNoticeDetail(id) { (success, msg, value) in
            if success {
                guard let obj = value else {return}
                self.noticeObj = obj
                var imgUrls = [String]()
                obj.pictureList.forEach({ (list) in
                    imgUrls.append(list.url)
                })
                if self.header != nil {
                    self.header.cycleView
                    .imageURLStringsGroup = imgUrls
                }
                self.tableView.reloadData()
            } else {
                guard let m = msg else {return}
                SVToast.showWithError(m)
            }
        }
    }
    
    func setupSubViews() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(InvitedTableViewCell.self, forCellReuseIdentifier: invitedCellId)
        tableView.separatorStyle = .None
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.estimatedRowHeight = kScale(100)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
        
        header = InvitedHeaderView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: kScale(180)))
        tableView.tableHeaderView = header
    }
}

extension InvitedDetailViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(invitedCellId, forIndexPath: indexPath) as! InvitedTableViewCell
        if self.noticeObj != nil {
            cell.info = self.noticeObj
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableViewAutomaticDimension
        } else {
            return 0
        }
    }
}
