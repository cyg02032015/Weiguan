//
//  FollowPeopleViewController.swift
//  OutLookers
//
//  Created by Youngkook on 16/6/30.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//  // 他的粉丝

import UIKit

private let followCellIdentifier = "followPeopleId"

enum ShowType: Int {
    case Follow = 0
    case Fan = 1
    case HFollow = 2
}

class FollowPeopleViewController: YGBaseViewController {
    var num: Int?
    var urlStr: String!
    var userId: String!
    var showType: ShowType!
    var tableView: UITableView!
    lazy var myFollows = [FollowList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        SVToast.show()
        loadMoreData()
        tableView.mj_footer = MJRefreshBackStateFooter(refreshingBlock: { [weak self] in
            self?.loadMoreData()
        })
        guard let _ = num else { return }
        guard num != 0 else { return } //本身为0就不必去发送请求
        releaseFollow()
    }
    
    func releaseFollow() {
        HttpTool.post(API.releaseFollowRead, parameters: ["userId" : UserSingleton.sharedInstance.userId], complete: { (response) in
            if response["success"].boolValue {
                NSNotificationCenter.defaultCenter().postNotificationName(kMessageFollowReleaseReadNotification, object: nil)
            }
        }) { (error) in
            SVToast.showWithError(error.localizedDescription)
        }
    }
    
    override func loadMoreData() {
        if showType == .Follow || showType == .HFollow {
            Server.myFollow(pageNo, urlStr: urlStr, userId: userId) { [weak self] (success, msg, value) in
                SVToast.dismiss()
                if success {
                    guard let object = value else {return}
                    self?.myFollows.appendContentsOf(object.list)
                    self?.tableView.mj_footer.endRefreshing()
                    self?.tableView.reloadData()
                    if let _ = self {
                        self!.pageNo = self!.pageNo + 1
                    }
                    if object.list.count < 10 {
                        self?.tableView.mj_footer.endRefreshingWithNoMoreData()
                    }
                } else {
                    self?.tableView.mj_footer.endRefreshing()
                    guard let m = msg else {return}
                    SVToast.showWithError(m)
                }
            }
        } else {
            Server.myFans(pageNo, urlStr: urlStr, userId: userId, handler: { [weak self](success, msg, value) in
                SVToast.dismiss()
                if success {
                    guard let object = value else {return}
                    self?.myFollows.appendContentsOf(object.list)
                    self?.tableView.mj_footer.endRefreshing()
                    self?.tableView.reloadData()
                    if let _ = self {
                        self!.pageNo = self!.pageNo + 1
                    }
                    if object.list.count < 10 {
                        self?.tableView.mj_footer.endRefreshingWithNoMoreData()
                    }
                } else {
                    self?.tableView.mj_footer.endRefreshing()
                    guard let m = msg else {return}
                    SVToast.showWithError(m)
                }
            })
        }
        
    }
    
    func setupSubViews() {
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(FollowPeopleCell.self, forCellReuseIdentifier: followCellIdentifier)
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
    }
}

// MARK: - UITableViewDelegate,UITableViewDataSource
extension FollowPeopleViewController {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(followCellIdentifier, forIndexPath: indexPath) as! FollowPeopleCell
        let info = myFollows[indexPath.row]
        var id: Int
        if self.showType == .Fan {
            id = info.userId
        }else {
            id = info.followUserId
        }
        cell.header.iconHeaderTap { [weak self] in
            let vc = PHViewController()
            vc.user = "\(id)"
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        cell.showType = showType
        cell.info = info
        cell.followButton.rx_tap.subscribeNext { [weak self] in
            if info.fan == 1 {
                self?.showAlertController("确定不再关注？", message: "", defults: ["确定"], handler: { (index, alertAction) in
                    if index == 0 {
                        self?.cancelFollow("\(id)") { (success) in
                            if success {
                                cell.followButton.selected = !cell.followButton.selected
                                info.fan = 0
                            }
                        }
                    }
                })
            }else {
                Server.followUser("\(id)", handler: { (success, msg, value) in
                    if success {
                        cell.followButton.selected = !cell.followButton.selected
                        info.fan = 1
                    }
                })
            }
            }.addDisposableTo(disposeBag)
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFollows.count

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return kHeight(80)
    }
}