//
//  DataViewController.swift
//  OutLookers
//
//  Created by C on 16/7/7.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//  个人主页-资料

import UIKit

private let dataCellIdentifier = "dataCellId"
private let dataSecondCellIdentifier = "dataSecondId"

class DataViewController: YGBaseViewController {

    var userId: String?
    private var req: PersonFilesReq?
    private var tableView: UITableView!
    private var rightButton: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "个人资料"
        rightButton = setRightNaviItem()
        rightButton.setTitle("编辑", forState: .Normal)
        if userId != UserSingleton.sharedInstance.userId {
            rightButton.hidden = true
        }
        _ = rightButton.rx_tap.subscribeNext { [unowned self](sender) in
            let vc = PersonFileViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }.addDisposableTo(disposeBag)
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(DataTableViewCell.self, forCellReuseIdentifier: dataCellIdentifier)
        tableView.registerClass(DataSecondCell.self, forCellReuseIdentifier: dataSecondCellIdentifier)
        tableView.separatorStyle = .None
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = kHeight(325)
        tableView.rowHeight = UITableViewAutomaticDimension
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
        loadData()
    }
    
    func loadData() {
        Server.showPersonFiles(userId) { [weak self](success, msg, value) in
            SVToast.dismiss()
            if success {
                guard let obj = value else {return}
                self?.req = PersonFilesReq()
                self?.req!.bust = obj.bust
                self?.req!.characteristics = obj.characteristics
                self?.req!.constellation = obj.constellation
                self?.req!.experience = obj.experience
                self?.req!.height = obj.height
                self?.req!.weight = obj.weight
                self?.req!.hipline = obj.hipline
                self?.req!.waist = obj.waist
                self?.req!.array = obj.array
                self?.req!.userId = "\(obj.id)"
                self?.req!.sex = obj.sex
                self?.req!.birthday = obj.birthday
                self?.req!.province = obj.province
                self?.req!.city = obj.city
                self?.tableView.reloadData()
            } else {
                guard let m = msg else {return}
                SVToast.showWithError(m)
            }
        }
    }
}

// MARK: - UITableviewDelegate, UITableviewDatasource
extension DataViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(dataCellIdentifier, forIndexPath: indexPath) as! DataTableViewCell
            if let _ = req {
                cell.req = req
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(dataSecondCellIdentifier, forIndexPath: indexPath) as! DataSecondCell
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return kScale(325)
        } else {
            return kScale(157)
        }
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}

// MARK: - DataSecondCellDelegate
extension DataViewController: DataSecondCellDelegate {
    func dataSecondCellTapScore(sender: UIButton) {
        /*
         显示用户接发单后收到的评分；
         点击进入ta的评价页面；
         若没有评分则数值显示“-”；
         */
    }
    
    func dataSecondCellTapOrderCount(sender: UIButton) {
        /*
         显示数值为用户接单和发单的总数；
         点击进入ta的通告列表；
         若没有接发单则不显示订单量和综合评分；
         */
        let vc = PHOrderListViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
