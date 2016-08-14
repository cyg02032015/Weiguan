//
//  HotManViewController.swift
//  OutLookers
//
//  Created by C on 16/7/15.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let hotmanCellId = "hotmanCellId"

class HotManViewController: YGBaseViewController {

    var tableView: UITableView!
    lazy var hotmans = [FindeHotman]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        loadMoreData()
    }
    
    override func loadMoreData() {
        Server.findHotman { (success, msg, value) in
            if success {
                guard let list = value else {return}
                self.hotmans.appendContentsOf(list)
                self.tableView.reloadData()
            } else {
                guard let m = msg else {return}
                SVToast.showWithError(m)
            }
        }
    }
    
    func setupSubViews() {
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(HotmanCell.self, forCellReuseIdentifier: hotmanCellId)
        tableView.separatorStyle = .None
        tableView.rowHeight = ScreenWidth
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
    }
}

extension HotManViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return hotmans.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(hotmanCellId, forIndexPath: indexPath) as! HotmanCell
        cell.info = hotmans[indexPath.section]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = PHViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}