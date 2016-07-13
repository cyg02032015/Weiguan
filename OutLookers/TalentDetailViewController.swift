//
//  TalentDetailViewController.swift
//  OutLookers
//
//  Created by C on 16/7/14.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let talentDetailHeadCellId = "talentDetailHeadCellId"
private let talentDetailCellId = "talentDetailCellId"
private let shareCellId = "shareCellId"

class TalentDetailViewController: YGBaseViewController {

    var tableView: UITableView!
    lazy var shareTuple = ([UIImage](), [UIImage](), [String]())
    override func viewDidLoad() {
        super.viewDidLoad()
        self.shareTuple = YGShareHandler.handleShareInstalled()
        setupSubViews()
    }
    
    func setupSubViews() {
        title = "才艺详情"
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(TalentDetailHeadCell.self, forCellReuseIdentifier: talentDetailHeadCellId)
        tableView.registerClass(TalentDetailCell.self, forCellReuseIdentifier: talentDetailCellId)
        tableView.registerClass(ShareCell.self, forCellReuseIdentifier: shareCellId)
        tableView.estimatedRowHeight = kHeight(1000)
        tableView.separatorStyle = .None
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
    }
}

extension TalentDetailViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 2
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(talentDetailHeadCellId, forIndexPath: indexPath) as! TalentDetailHeadCell
            return cell
        } else {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier(talentDetailCellId, forIndexPath: indexPath) as! TalentDetailCell
                return cell
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier(shareCellId, forIndexPath: indexPath) as! ShareCell
                cell.tuple = shareTuple
                cell.delegate = self
                return cell
            }
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return kHeight(64)
        } else {
            if indexPath.row == 0 {
                return UITableViewAutomaticDimension
            } else {
                return kHeight(80)
            }
        }
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return kHeight(10)
        } else {
            return 0.01
        }
    }
}

// MARK: - ShareCellDelegate
extension TalentDetailViewController: ShareCellDelegate {
    func shareCellReturnsShareTitle(text: String) {
        
    }
}
