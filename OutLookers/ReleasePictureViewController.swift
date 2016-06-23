//
//  ReleasePictureViewController.swift
//  OutLookers
//
//  Created by C on 16/6/22.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let pictureSelectIdentifier = "pictureSelectIdentifier"
private let editTextViewIdentifier = "editTextViewIdentifier"
private extension Selector {
    static let tapRelease = #selector(ReleasePictureViewController.tapRelease(_:))
}

class ReleasePictureViewController: YGBaseViewController {

    var tableView: UITableView!
    var releaseButton: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "编辑才艺"
        setupSubViews()
    }
    
    func setupSubViews() {
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .None
        tableView.registerClass(PictureSelectCell.self, forCellReuseIdentifier: pictureSelectIdentifier)
        tableView.registerClass(EditTextViewCell.self, forCellReuseIdentifier: editTextViewIdentifier)
        
        releaseButton = UIButton()
        releaseButton.setTitle("发布", forState: .Normal)
        releaseButton.titleLabel?.font = UIFont.systemFontOfSize(16)
        releaseButton.addTarget(self, action: .tapRelease, forControlEvents: .TouchUpInside)
        releaseButton.backgroundColor = kGrayColor
        view.addSubview(releaseButton)
        
        releaseButton.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(releaseButton.superview!)
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(tableView.superview!)
            make.top.equalTo(self.snp.topLayoutGuideBottom)
            make.bottom.equalTo(releaseButton.snp.top)
        }
    }

}

extension ReleasePictureViewController: UITableViewDelegate, UITableViewDataSource {
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
                let cell = tableView.dequeueReusableCellWithIdentifier(pictureSelectIdentifier, forIndexPath: indexPath) as! PictureSelectCell
                return cell
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier(editTextViewIdentifier, forIndexPath: indexPath) as! EditTextViewCell
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return indexPath.row == 0 ? 293 : 72
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
extension ReleasePictureViewController {
    
    func tapRelease(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
