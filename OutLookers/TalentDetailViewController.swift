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

class TalentDetailViewController: YGBaseViewController {

    var id: Int!
    var isPerson = false
    var tableView: UITableView!
    var talentObj: TalentDtailResp!
    var moreButton: UIButton!
    var share: YGShare!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupShare()
        setupSubViews()
        loadData()
    }
    
    func setupShare() {
        var collect = YGShareHandler.handleShareInstalled(.DYVisitor)
        if isPerson {
            collect.images.append(UIImage(named: kEditImg)!) // 编辑
            collect.images.append(UIImage(named: kDeleteImg)!) // 删除
            collect.images.append(UIImage(named: kHomeImg)!) // 返回首页
            collect.titles.append(kEdit)
            collect.titles.append(kDelete)
            collect.titles.append(kHome)
            share = YGShare(frame: CGRectZero, imgs: collect.images, titles: collect.titles)
        } else {
            collect.images.append(UIImage(named: kReportImg)!)
            collect.images.append(UIImage(named: kHomeImg)!)
            collect.titles.append(kReport)
            collect.titles.append(kHome)
            share = YGShare(frame: CGRectZero, imgs: collect.images, titles: collect.titles)
        }
        share.shareBlock { (title) in
            switch title {
            case kDelete:
                SVToast.show()
                Server.deleteTalent("\(self.id)", handler: { (success, msg, value) in
                    SVToast.dismiss()
                    if success {
                        SVToast.showWithSuccess("删除成功")
                        delay(1, task: { 
                            self.navigationController?.popViewControllerAnimated(true)
                        })
                    } else {
                        guard let m = msg else {return}
                        SVToast.showWithError(m)
                    }
                })
            default:""
            }
        }
    }
    
    func loadData() {
        SVToast.show()
        Server.talentDetail("\(id)") { (success, msg, value) in
            SVToast.dismiss()
            if success {
                guard let obj = value else {return}
                self.talentObj = obj
                self.tableView.reloadData()
            } else {
                guard let m = msg else {return}
                SVToast.showWithError(m)
            }
        }
    }
    
    func setupSubViews() {
        title = "才艺详情"
        moreButton = setRightNaviItem()
        moreButton.setImage(UIImage(named: "more1"), forState: .Normal)
        moreButton.rx_tap.subscribeNext { [weak self] in
            self?.share.animation()
        }.addDisposableTo(disposeBag)
        
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(TalentDetailHeadCell.self, forCellReuseIdentifier: talentDetailHeadCellId)
        tableView.registerClass(TalentDetailCell.self, forCellReuseIdentifier: talentDetailCellId)
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
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(talentDetailHeadCellId, forIndexPath: indexPath) as! TalentDetailHeadCell
            if talentObj != nil {
                cell.info = talentObj
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(talentDetailCellId, forIndexPath: indexPath) as! TalentDetailCell
            if talentObj != nil {
                cell.info = talentObj
            }
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return kHeight(64)
        } else {
            return UITableViewAutomaticDimension
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
        LogInfo(text)
    }
}
