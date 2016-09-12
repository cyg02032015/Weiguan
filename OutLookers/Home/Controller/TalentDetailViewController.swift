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
private let talentDetailNomalCell = "talentDetailNomalCell"

class TalentDetailViewController: YGBaseViewController {

    var id: Int!
    var isPerson = false
    var tableView: UITableView!
    private var talentObj: TalentDtailResp!
    private lazy var worksList = [WorksList]()
    var moreButton: UIButton!
    var share: YGShare!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        loadData()
    }
    
    func setupShare() {
        var type: YGShareType = .CCVisitor
        if isPerson {
            type = .CCHost
        }
        let tuple = YGShareHandler.handleShareInstalled(type)
        share = YGShare(frame: CGRectZero, imgs: tuple.0, titles: tuple.2)
//        share.shareBlock { (title) in
//            switch title {
//            case kDelete:
//                SVToast.show()
//                Server.deleteTalent("\(self.id)", handler: { (success, msg, value) in
//                    SVToast.dismiss()
//                    if success {
//                        SVToast.showWithSuccess("删除成功")
//                        delay(1, task: { 
//                            self.navigationController?.popViewControllerAnimated(true)
//                        })
//                    } else {
//                        guard let m = msg else {return}
//                        SVToast.showWithError(m)
//                    }
//                })
//            default:""
//            }
//        }
    }
    
    func loadData() {
        SVToast.show()
        Server.talentDetail("\(id)") { [weak self](success, msg, value) in
            SVToast.dismiss()
            if success {
                guard let obj = value else {return}
                self?.talentObj = obj
                self?.loadWorks()
                self?.tableView.reloadData()
            } else {
                guard let m = msg else {return}
                SVToast.showWithError(m)
            }
        }
    }
    
    func loadWorks() {
        Server.getWorks("\(id)") { (success, msg, value) in
            SVToast.dismiss()
            if success {
                guard let obj = value else {return}
                self.worksList.appendContentsOf(obj)
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
        moreButton.rx_tap.subscribeNext { [unowned self] in
            self.setupShare()
            self.share.returnHomeClick = {
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.customTabbar.tabbarClick(appDelegate.customTabbar.firstBtn)
                self.navigationController?.popViewControllerAnimated(true)
            }
            self.share.animation()
        }.addDisposableTo(disposeBag)
        
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(TalentDetailHeadCell.self, forCellReuseIdentifier: talentDetailHeadCellId)
        tableView.registerClass(TalentDetailCell.self, forCellReuseIdentifier: talentDetailCellId)
        tableView.registerClass(TalentDetailNomalCell.self, forCellReuseIdentifier: talentDetailNomalCell)
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
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else if section == 1 {
            return 1
        }else {
            if worksList.count > 0 {
                return worksList[0].list.count
            }else {
                return 0
            }
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(talentDetailHeadCellId, forIndexPath: indexPath) as! TalentDetailHeadCell
            if talentObj != nil {
                cell.info = talentObj
            }
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier(talentDetailCellId, forIndexPath: indexPath) as! TalentDetailCell
            if talentObj != nil {
                cell.info = talentObj
            }
            return cell
        }else {
            let cell = tableView.dequeueReusableCellWithIdentifier(talentDetailNomalCell, forIndexPath: indexPath) as! TalentDetailNomalCell
            cell.info = worksList[0].list[indexPath.row]
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return kHeight(64)
        } else if indexPath.section == 1 {
            return 400
        }else {
            return 280
        }
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 || section == 1 {
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
