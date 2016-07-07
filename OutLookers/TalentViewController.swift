//
//  TalentViewController.swift
//  OutLookers
//
//  Created by C on 16/7/5.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let talentCellIdentifier = "talentCellId"

class TalentViewController: YGBaseViewController {

    lazy var data = [String]()
    var tableView: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        LogInfo("viewwillappear")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LogWarn("viewdidload")
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(TalentTableViewCell.self, forCellReuseIdentifier: talentCellIdentifier)
        tableView.separatorStyle = .None
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
    }
}

extension TalentViewController {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(talentCellIdentifier, forIndexPath: indexPath) as! TalentTableViewCell
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return kHeight(602)
    }
}