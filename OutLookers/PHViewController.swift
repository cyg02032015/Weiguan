//
//  PersonalHomepageViewController.swift
//  OutLookers
//
//  Created by C on 16/7/4.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//  PersonalHomepageViewController   个人主页

import UIKit

private extension Selector {
    static let tapMore = #selector(PHViewController.tapMore(_:))
}

class PHViewController: YGBaseViewController {

    var slidePageScrollView: TYSlidePageScrollView!
    var tableView: UITableView!
    var toolView: PHToolView!
    var rightNaviButton: UIButton!
    var delta: CGFloat = 0
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        willSetNavigation(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        viewWillDisappearSetNavigation(animated)
    }
    
    func willSetNavigation(animated: Bool) {
        slidePageScrollView.isDealloc = false
        let color = UIColor(r: 255, g: 255, b: 255, a: 1.0)
        if delta > 0 {
            backImgView.image = UIImage(named: "back-1")
            rightNaviButton.setImage(UIImage(named: "more1"), forState: .Normal)
            UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: animated)
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.blackColor(), NSFontAttributeName:UIFont.customNumFontOfSize(20)]
            navigationController?.navigationBar.lt_setBackgroundColor(color.colorWithAlphaComponent(delta / 100))
        } else {
            backImgView.image = UIImage(named: "back1")
            rightNaviButton.setImage(UIImage(named: "more"), forState: .Normal)
            UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: animated)
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor(), NSFontAttributeName:UIFont.customNumFontOfSize(20)]
            navigationController?.navigationBar.lt_setBackgroundColor(color.colorWithAlphaComponent(delta / 100))
        }
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func viewWillDisappearSetNavigation(animated: Bool) {
        slidePageScrollView.isDealloc = true
        backImgView.image = UIImage(named: "back-1")
        rightNaviButton.setImage(UIImage(named: "more1"), forState: .Normal)
        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: true)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.blackColor(), NSFontAttributeName:UIFont.customNumFontOfSize(20)]
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationController?.navigationBar.lt_reset()
        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }
    
    func setupSubViews() {
        self.title = "小包子"
        
        rightNaviButton = UIButton(type: .Custom)
        rightNaviButton.frame = CGRect(x: 0, y: 0, width: 45, height: 49)
        rightNaviButton.setImage(UIImage(named: "more"), forState: .Normal)
        rightNaviButton.addTarget(self, action: .tapMore, forControlEvents: .TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightNaviButton)
        
        slidePageScrollView = TYSlidePageScrollView(frame: CGRect(origin: CGPointZero, size: CGSize(width: ScreenWidth, height: ScreenHeight - NaviHeight))) // height - naviheight  偏移问题
        slidePageScrollView.pageTabBarIsStopOnTop = true
        slidePageScrollView.pageTabBarStopOnTopHeight = NaviHeight
        slidePageScrollView.parallaxHeaderEffect = false
        slidePageScrollView.dataSource = self
        slidePageScrollView.delegate = self
        view.addSubview(slidePageScrollView)
        
        let header = PHHeaderView()
        header.frame = CGRect(origin: CGPointZero, size: CGSize(width: ScreenWidth, height: kHeight(294)))
        
        slidePageScrollView.headerView = header
        
        let titlePageTabbar = TYTitlePageTabBar(titleArray: ["动态", "才艺"])
        titlePageTabbar.frame = CGRect(origin: CGPointZero, size: CGSize(width: CGRectGetWidth(slidePageScrollView.frame), height: 46))
        titlePageTabbar.edgeInset = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 80)
        titlePageTabbar.backgroundColor = UIColor(hex: 0xf8f8f8)
        slidePageScrollView.pageTabBar = titlePageTabbar
        
        let dynamicVC = DynamicViewController()
        dynamicVC.view.frame = view.frame
        self.addChildViewController(dynamicVC)
        
        let talentVC = TalentViewController()
        talentVC.view.frame = view.frame
        talentVC.delegate = self
        self.addChildViewController(talentVC)
        
        slidePageScrollView.reloadData()
        
        toolView = PHToolView()
        toolView.delegate = self
        toolView.layer.cornerRadius = kScale(40/2)
        toolView.clipsToBounds = true
        view.addSubview(toolView)
        toolView.snp.makeConstraints { (make) in
            make.left.equalTo(toolView.superview!).offset(kScale(37))
            make.right.equalTo(toolView.superview!).offset(kScale(-37))
            make.height.equalTo(kScale(40))
            make.bottom.equalTo(toolView.superview!).offset(kScale(-15))
        }
    }
    
    func tapMore(sender: UIButton) {
        let vc = DataViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func backButtonPressed(sender: UIButton) {
        slidePageScrollView.isDealloc = true
        navigationController?.popViewControllerAnimated(true)
    }
}

extension PHViewController: PHToolViewDelegate {
    func toolViewTapFollow(sender: UIButton) {
        LogInfo("关注")
    }
    
    func toolViewTapPrivateLatter(sender: UIButton) {
        LogInfo("私信")
    }
    
    func toolViewTapInvitation(sender: UIButton) {
        LogInfo("邀约")
        let vc = InvitationDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension PHViewController: ScrollVerticalDelegate {
    func customScrollViewDidEndDecelerating(isScroll: Bool) {
        if isScroll {
            LogWarn("is scroll")
        } else {
            LogError("no scroll")
        }
    }
}

extension PHViewController: TYSlidePageScrollViewDataSource, TYSlidePageScrollViewDelegate {
    func numberOfPageViewOnSlidePageScrollView() -> Int {
        return self.childViewControllers.count
    }
    
    func slidePageScrollView(slidePageScrollView: TYSlidePageScrollView!, pageVerticalScrollViewForIndex index: Int) -> UIScrollView! {
        if index == 0 {
            let tableViewVC = childViewControllers[index] as! DynamicViewController
            return tableViewVC.tableView
        } else {
            let tableViewVC = childViewControllers[index] as! TalentViewController
            return tableViewVC.tableView
        }
    }
    
    func slidePageScrollView(slidePageScrollView: TYSlidePageScrollView!, verticalScrollViewDidScroll pageScrollView: UIScrollView!) {
        let color = UIColor(r: 255, g: 255, b: 255, a: 1.0)
        let headerContentViewHeight = -slidePageScrollView.headerView.gg_height + slidePageScrollView.pageTabBar.gg_height
        let offsetY = pageScrollView.contentOffset.y
        delta = offsetY - headerContentViewHeight
        if delta > 0 {
            backImgView.image = UIImage(named: "back-1")
            rightNaviButton.setImage(UIImage(named: "more1"), forState: .Normal)
            UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: true)
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.blackColor(), NSFontAttributeName:UIFont.customNumFontOfSize(20)]
            navigationController?.navigationBar.lt_setBackgroundColor(color.colorWithAlphaComponent(delta / 100))
        } else {
            backImgView.image = UIImage(named: "back1")
            rightNaviButton.setImage(UIImage(named: "more"), forState: .Normal)
            UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor(), NSFontAttributeName:UIFont.customNumFontOfSize(20)]
            navigationController?.navigationBar.lt_setBackgroundColor(color.colorWithAlphaComponent(delta / 100))
        }
    }
}