//
//  ReleaseNoticeViewController.swift
//  OutLookers
//
//  Created by C on 16/6/18.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//  发布通告

import UIKit

private let noArrowIdentifier = "noArrowId"
private let arrowIdentifier = "arrowId"
private let recruiteIdentifier = "recruiteId"
private let workDetailIdentifier = "workDetailId"
private let selectImgIdentifier = "selectImgId"

private extension Selector {
    static let tapRelease = #selector(ReleaseNoticeViewController.tapRelease(_:))
}

class ReleaseNoticeViewController: YGBaseViewController {

    var tableView: UITableView!
    var releaseButton: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "编辑通告"
        setupSubViews()
    }

    func setupSubViews() {
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.registerClass(NoArrowEditCell.self, forCellReuseIdentifier: noArrowIdentifier)
        tableView.registerClass(ArrowEditCell.self, forCellReuseIdentifier: arrowIdentifier)
        tableView.registerClass(RecruitNeedsCell.self, forCellReuseIdentifier: recruiteIdentifier)
        tableView.registerClass(WorkDetailCell.self, forCellReuseIdentifier: workDetailIdentifier)
        tableView.registerClass(SelectPhotoCell.self, forCellReuseIdentifier: selectImgIdentifier)
        
        releaseButton = UIButton()
        releaseButton.setTitle("发布", forState: .Normal)
        releaseButton.addTarget(self, action: .tapRelease, forControlEvents: .TouchUpInside)
        releaseButton.backgroundColor = kGrayColor
        view.addSubview(releaseButton)
        
        releaseButton.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(releaseButton.superview!)
            make.height.equalTo(49)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(tableView.superview!)
            make.top.equalTo(self.snp.topLayoutGuideBottom)
            make.bottom.equalTo(releaseButton.snp.top)
        }
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
}

extension ReleaseNoticeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 1: return 1
        case 2: return 2
        case 3: return 1
        case 4: return 2
        case 5, 6: return 1
        default: return 1
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(noArrowIdentifier, forIndexPath: indexPath) as! NoArrowEditCell
            cell.setTextInCell("工作主题", placeholder: "请输入工作主题")
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier(recruiteIdentifier, forIndexPath: indexPath) as! RecruitNeedsCell
            cell.delegate = self
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCellWithIdentifier(arrowIdentifier, forIndexPath: indexPath) as! ArrowEditCell
            cell.setTextInCell(indexPath.row == 0 ? "工作开始时间" : "工作结束时间", placeholder: indexPath.row == 0 ? "请选择开始时间" : "请选择结束时间")
            return cell
        } else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCellWithIdentifier(arrowIdentifier, forIndexPath: indexPath) as! ArrowEditCell
            cell.setTextInCell("报名截止时间", placeholder: "请选择截止时间")
            return cell
        } else if indexPath.section == 4 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier(arrowIdentifier, forIndexPath: indexPath) as! ArrowEditCell
                cell.setTextInCell("工作地点", placeholder: "选择城市")
                return cell
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier(noArrowIdentifier, forIndexPath: indexPath) as! NoArrowEditCell
                cell.setTextInCell("", placeholder: "指定详细地址 (选填)")
                return cell
            }
        } else if indexPath.section == 5 {
            let cell = tableView.dequeueReusableCellWithIdentifier(workDetailIdentifier, forIndexPath: indexPath) as! WorkDetailCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(selectImgIdentifier, forIndexPath: indexPath) as! SelectPhotoCell
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 1: return 100 // 招募需求
        case 0, 2, 3, 4: return 50
        case 5: return 150 // 工作详情
        case 6: return 150 // 宣传图片
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 6 {
            return 0
        }
        return 10
    }
}

// MARK: -点击按钮
extension ReleaseNoticeViewController: RecruitNeedsCellDelegate {
    
    func tapRelease(sender: UIButton) {
        debugPrint("发布")
    }
    
    func recruitNeedsAddRecruite(sender: UIButton) {
        let recruitInfomation = RecruitInformationViewController()
        navigationController?.pushViewController(recruitInfomation, animated: true)
    }
}