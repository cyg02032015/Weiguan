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

    private var isFollow: IsFollowData?
    var id: String = ""
    var tableView: UITableView!
    var noticeObj: FindNoticeDetailResp!
    var header: InvitedHeaderView!
    var rightNaviButton: UIButton!
    var delta: CGFloat = 0
    
    var shareImage: UIImage!
    
    private var headerIcon: IconHeaderView!
    private var didAppear: Bool = false
    private var shareView: YGShare!
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
        didAppear = true
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
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.blackColor(), NSFontAttributeName:UIFont.customNumFontOfSize(20)]
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationController?.navigationBar.lt_reset()
        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: animated)
    }
    
    func loadData() {
        Server.findNoticeDetail(id) { [weak self](success, msg, value) in
            if success {
                guard let obj = value, ws = self else {return}
                ws.noticeObj = obj
                Server.getAvatarAndName("\(obj.userId)", handler: { (success, msg, value) in
                    if success {
                        guard let obj = value else {return}
                        self?.headerIcon.iconURL = obj[0].headImgUrl.addImagePath(CGSize(width: 78, height: 78))
                        self?.headerIcon.setVimage(Util.userType(obj[0].detailsType))
//                        self.nameLabel.text = obj[0].nickname
                    } else {
                        guard let m = msg else {return}
                        LogError(m)
                    }
                })
                Server.isFollowStatus(UserSingleton.sharedInstance.userId, followUserId: "\(obj.userId)") { (success, msg, value) in
                    if success {
                        self?.isFollow = value
                    }else {
                        guard let m = msg else {return}
                        SVToast.showWithError(m)
                    }
                }
                var imgUrls = [String]()
                obj.pictureList.forEach({ (list) in
                    imgUrls.append(list.url)
                })
                if ws.header != nil {
                    ws.header.cycleView
                    .imageURLStringsGroup = imgUrls
                }
                
                dispatch_async_safely_to_main_queue({ 
                    ws.tableView.reloadData()
                    ws.shareAction()
                })
            } else {
                guard let m = msg else {return}
                SVToast.showWithError(m)
            }
        }
    }
    
    func shareAction() {
        var type: YGShareType = .CCVisitor
        if UserSingleton.sharedInstance.userId == "\(noticeObj.userId)" {
            type = .CCHost
        }
        let shareModel = YGShareModel()
        shareModel.shareID = "index.html#annunciate-details?listId=\(noticeObj.id)"
        shareModel.shareImage = self.shareImage
        shareModel.shareNickName = noticeObj.details
        let tuple = YGShareHandler.handleShareInstalled(type)
        shareView = YGShare(frame: CGRectZero, imgs: tuple.0, titles: tuple.2)
        shareView.shareModel = shareModel
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
            make.top.equalTo(snp.topLayoutGuideTop).offset(-NaviHeight)
        }
        
        header = InvitedHeaderView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: kScale(210)))
        tableView.tableHeaderView = header
        
        rightNaviButton = setRightNaviItem()
        rightNaviButton.frame = CGRect(x: 0, y: 0, width: 45, height: 49)
        rightNaviButton.setImage(UIImage(named: "more"), forState: .Normal)
        let rightFixedSpace = UIBarButtonItem.init(barButtonSystemItem: .FixedSpace, target: nil, action: nil)
        rightFixedSpace.width = -5
        let rightMoreItem = UIBarButtonItem(customView: rightNaviButton)
        self.navigationItem.rightBarButtonItems = [rightFixedSpace, rightMoreItem]
        
        headerIcon = IconHeaderView()
        headerIcon.customCornerRadius = kScale(39/2)
        tableView.addSubview(headerIcon)
        headerIcon.snp.makeConstraints { [unowned self](make) in
            make.top.equalTo(self.header.snp.bottom).offset(-10)
            make.size.equalTo(kSize(39, height: 39))
            make.left.equalTo(self.headerIcon.superview!).offset(kScale(15))
        }
        headerIcon.iconHeaderTap { [unowned self] in
            guard "\(self.noticeObj.userId)" != UserSingleton.sharedInstance.userId else { return }
            let vc = PHViewController()
            vc.user = "\(self.noticeObj.userId)"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        //分享
        rightNaviButton.rx_tap.subscribeNext { [unowned self] in
            self.shareView.animation()
            self.shareView.returnHomeClick = { [unowned self] in
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.customTabbar.tabbarClick(appDelegate.customTabbar.firstBtn)
                self.navigationController?.popToRootViewControllerAnimated(true)
            }
        }.addDisposableTo(disposeBag)
    }
    
    @objc private func prepareShare() {
        shareAction()
    }
}

extension InvitedDetailViewController: FollowProtocol {
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
            if let _ = self.isFollow {
                cell.concerned = self.isFollow?.concerned
            }
            _ = cell.follow.rx_tap.subscribeNext({ [unowned self, unowned cell] in
                Server.followUser("\(self.noticeObj.userId)") { (success, msg, value) in
                    if success {
                        self.modifyFollow(cell.follow)
                    } else {
                        guard let m = msg else {return}
                        SVToast.showWithError(m)
                    }
                }
            })
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
        if NSStringFromClass(self.dynamicType) == "OutLookers.InvitedDetailViewController" {
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
            guard !didAppear else { return } // 控制器消失后还会走一次这个方法
            UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.clearColor(), NSFontAttributeName:UIFont.customNumFontOfSize(20)]
            navigationController?.navigationBar.lt_setBackgroundColor(color.colorWithAlphaComponent(delta / 100))
        }
        }

    }
}
