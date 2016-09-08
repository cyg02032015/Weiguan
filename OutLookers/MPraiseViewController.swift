//
//  MPraiseViewController.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/21.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let mPraiseCellId = "mPraiseCellId"

class MPraiseViewController: YGBaseViewController {

    var num: Int?
    var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        releaseLike()
    }
    
    func setupSubViews() {
        title = "赞了"
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(MPraiseCell.self, forCellReuseIdentifier: mPraiseCellId)
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
        guard num != 0 else { return }
        releaseLike()
    }
    
    func releaseLike() {
        HttpTool.post(API.releaseLikeRead, parameters: ["userId" : UserSingleton.sharedInstance.userId], complete: { (response) in
            if response["success"].boolValue {
                NSNotificationCenter.defaultCenter().postNotificationName(kMessageLikeReleaseReadNotification, object: nil)
            }
            }) { (error) in
                SVToast.showWithError(error.localizedDescription)
        }
    }
}

extension MPraiseViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(mPraiseCellId, forIndexPath: indexPath) as! MPraiseCell
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return kHeight(62)
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}