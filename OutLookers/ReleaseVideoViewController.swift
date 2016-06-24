//
//  ReleaseVideoViewController.swift
//  OutLookers
//
//  Created by C on 16/6/22.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let videoCoverIdentifier = "videoCoverId"
private let editTextViewIdentifier = "editTextViewId"
private let shareCellIdentifier = "shareCellId"

class ReleaseVideoViewController: YGBaseViewController {

    var tableView: UITableView!
    var releaseButton: UIButton!

    lazy var shareTuple = ([UIImage](), [UIImage](), [String]())
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "编辑才艺"
        self.shareTuple = YGShareHandler.handleShareInstalled()
        setupSubViews()
        
    }
    
    func setupSubViews() {
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .None
        tableView.registerClass(VideoCoverCell.self, forCellReuseIdentifier: videoCoverIdentifier)
        tableView.registerClass(EditTextViewCell.self, forCellReuseIdentifier: editTextViewIdentifier)
        
        tableView.registerClass(ShareCell.self, forCellReuseIdentifier: shareCellIdentifier)
        
        createNaviRightButton("发布")
        
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(tableView.superview!)
            make.top.equalTo(self.snp.topLayoutGuideBottom)
        }
    }
    
}

extension ReleaseVideoViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 2
        case 1: return 1
        case 2: return 1
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier(videoCoverIdentifier, forIndexPath: indexPath) as! VideoCoverCell
                cell.delegate = self
                return cell
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier(editTextViewIdentifier, forIndexPath: indexPath) as! EditTextViewCell
                return cell
            }
        } else if indexPath.section == 1 {
             return UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(shareCellIdentifier, forIndexPath: indexPath) as! ShareCell
            cell.tuple = shareTuple
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return indexPath.row == 0 ? 121 : 72
        case 1: return 257
        case 2: return 81
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 2 {
            return 0
        } else {
            return 10
        }
    }
}

// MARK: - 按钮点击&响应
extension ReleaseVideoViewController: VideoCoverCellDelegate, ShareCellDelegate {
    
    override func tapRelease(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func videoCoverImageViewTap(sender: UITapGestureRecognizer) {
        debugPrint("tap image")
    }
    
    func shareCellReturnsShareTitle(text: String) {
        LogInfo("分享 \(text)")
    }
}

