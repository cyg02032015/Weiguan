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
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: talentCellIdentifier)
        tableView.separatorStyle = .None
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
        
        delay(5) {
            self.data = ["1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1"]
            self.tableView.reloadData()
        }
    }
}

extension TalentViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(talentCellIdentifier, forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
}