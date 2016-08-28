//
//  InvitedDetailViewController.swift
//  OutLookers
//
//  Created by C on 16/8/28.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let invitedCellId = "invitedCellId"
private let invitedDetailId = "invitedDetailId"

class InvitedDetailViewController: YGBaseViewController {

    var id: String = ""
    var tableView: UITableView!
    var noticeObj: FindNoticeDetailResp!
    var header: InvitedHeaderView!
    var rightNaviButton: UIButton!
    var delta: CGFloat!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        loadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        willSetNavigation(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        viewWillDisappearSetNavigation(animated)
    }
    
    func willSetNavigation(animated: Bool) {
        let color = UIColor(r: 255, g: 255, b: 255, a: 1.0)
        if delta > 100 {
            backImgView.image = UIImage(named: "back-1")
            rightNaviButton.setImage(UIImage(named: "more1"), forState: .Normal)
            UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: animated)
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.blackColor(), NSFontAttributeName:UIFont.customNumFontOfSize(20)]
            navigationController?.navigationBar.lt_setBackgroundColor(color.colorWithAlphaComponent(delta / 100))
        } else {
            backImgView.image = UIImage(named: "back1")
            rightNaviButton.setImage(UIImage(named: "more"), forState: .Normal)
            UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: animated)
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.clearColor(), NSFontAttributeName:UIFont.customNumFontOfSize(20)]
            navigationController?.navigationBar.lt_setBackgroundColor(color.colorWithAlphaComponent(delta / 100))
        }
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func viewWillDisappearSetNavigation(animated: Bool) {
        backImgView.image = UIImage(named: "back-1")
        rightNaviButton.setImage(UIImage(named: "more1"), forState: .Normal)
        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: true)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.blackColor(), NSFontAttributeName:UIFont.customNumFontOfSize(20)]
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationController?.navigationBar.lt_reset()
        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: true)
    }

    
    func loadData() {
        Server.findNoticeDetail(id) { (success, msg, value) in
            if success {
                guard let obj = value else {return}
                self.noticeObj = obj
                var imgUrls = [String]()
                obj.pictureList.forEach({ (list) in
                    imgUrls.append(list.url)
                })
                if self.header != nil {
                    self.header.cycleView
                    .imageURLStringsGroup = imgUrls
                }
                self.tableView.reloadData()
            } else {
                guard let m = msg else {return}
                SVToast.showWithError(m)
            }
        }
    }
    
    func setupSubViews() {
        self.title = "邀约详情"
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(InvitedTableViewCell.self, forCellReuseIdentifier: invitedCellId)
        tableView.registerClass(InvitedDetailTableViewCell.self, forCellReuseIdentifier: invitedDetailId)
        tableView.separatorStyle = .None
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.estimatedRowHeight = kScale(100)
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(tableView.superview!)
            make.top.equalTo(self.snp.topLayoutGuideTop).offset(-NaviHeight)
        }
        
        header = InvitedHeaderView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: kScale(180)))
        tableView.tableHeaderView = header
        
        rightNaviButton = setRightNaviItem()
        rightNaviButton.frame = CGRect(x: 0, y: 0, width: 45, height: 49)
        rightNaviButton.setImage(UIImage(named: "more"), forState: .Normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightNaviButton)
        rightNaviButton.rx_tap.subscribeNext {
            
        }.addDisposableTo(disposeBag)
    }
}

extension InvitedDetailViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(invitedCellId, forIndexPath: indexPath) as! InvitedTableViewCell
            if self.noticeObj != nil {
                cell.info = self.noticeObj
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(invitedDetailId, forIndexPath: indexPath) as! InvitedDetailTableViewCell
            if self.noticeObj != nil {
                cell.info = self.noticeObj
            }
            return cell
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let color = UIColor(r: 255, g: 255, b: 255, a: 1.0)
        let offsetY = scrollView.contentOffset.y
        delta = offsetY
        if delta > 100 {
            backImgView.image = UIImage(named: "back-1")
            rightNaviButton.setImage(UIImage(named: "more1"), forState: .Normal)
            UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: true)
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.blackColor(), NSFontAttributeName:UIFont.customNumFontOfSize(20)]
            navigationController?.navigationBar.lt_setBackgroundColor(color.colorWithAlphaComponent(delta / 100))
        } else {
            backImgView.image = UIImage(named: "back1")
            rightNaviButton.setImage(UIImage(named: "more"), forState: .Normal)
            UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.clearColor(), NSFontAttributeName:UIFont.customNumFontOfSize(20)]
            navigationController?.navigationBar.lt_setBackgroundColor(color.colorWithAlphaComponent(delta / 100))
        }

    }
}
