
//
//  OrganizationViewController.swift
//  OutLookers
//
//  Created by C on 16/7/9.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private extension Selector {
    static let tapMore = #selector(OrganizationViewController.tapMore(_:))
}

class OrganizationViewController: YGBaseViewController {

    var slidePageScrollView: TYSlidePageScrollView!
    var toolView: OGToolView!
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
        //        navigationController?.navigationBar.lt_setBackgroundColor(UIColor(r: 255, g: 255, b: 255, a: 1.0).colorWithAlphaComponent(1.0))
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationController?.navigationBar.lt_reset()
        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backImgView.image = UIImage(named: "Group 3")
        setupSubViews()
    }
    
    func setupSubViews() {
        
        rightNaviButton = UIButton(type: .Custom)
        rightNaviButton.frame = CGRect(x: 0, y: 0, width: 45, height: 49)
        rightNaviButton.setImage(UIImage(named: "more"), forState: .Normal)
        rightNaviButton.addTarget(self, action: .tapMore, forControlEvents: .TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightNaviButton)
        
        self.title = "小包子"
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
        
        let titlePageTabbar = TYTitlePageTabBar(titleArray: ["资料", "动态", "通告"])
        titlePageTabbar.frame = CGRect(origin: CGPointZero, size: CGSize(width: CGRectGetWidth(slidePageScrollView.frame), height: 46))
        titlePageTabbar.edgeInset = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 80)
        titlePageTabbar.backgroundColor = UIColor(hex: 0xf8f8f8)
        slidePageScrollView.pageTabBar = titlePageTabbar
        
        
        let dataVC = OGDataViewController()
        dataVC.view.frame = view.frame
        self.addChildViewController(dataVC)
        
        let dynamicVC = DynamicViewController()
        dynamicVC.view.frame = view.frame
        self.addChildViewController(dynamicVC)
        
        let talentVC = OGCircularViewController()
        talentVC.view.frame = view.frame
        //        talentVC.delegate = self
        self.addChildViewController(talentVC)
        
        slidePageScrollView.reloadData()
        
        toolView = OGToolView()
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
        LogInfo("more")
    }
    
    override func backButtonPressed(sender: UIButton) {
        slidePageScrollView.isDealloc = true
        navigationController?.popViewControllerAnimated(true)
    }
}

extension OrganizationViewController: OGToolViewDelegate {
    func toolViewTapFollow(sender: UIButton) {
        LogInfo("关注")
    }
    
    func toolViewTapPrivateLatter(sender: UIButton) {
        LogInfo("私信")
    }
}

extension OrganizationViewController: TYSlidePageScrollViewDataSource, TYSlidePageScrollViewDelegate {
    func numberOfPageViewOnSlidePageScrollView() -> Int {
        return self.childViewControllers.count
    }
    
    func slidePageScrollView(slidePageScrollView: TYSlidePageScrollView!, pageVerticalScrollViewForIndex index: Int) -> UIScrollView! {
        if index == 0 {
            let tableViewVC = childViewControllers[index] as! OGDataViewController
            return tableViewVC.tableView
        } else if index == 1 {
            let tableViewVC = childViewControllers[index] as! DynamicViewController
            return tableViewVC.tableView
        } else {
            let tableViewVC = childViewControllers[index] as! OGCircularViewController
            return tableViewVC.tableView
        }
    }
    
    func slidePageScrollView(slidePageScrollView: TYSlidePageScrollView!, verticalScrollViewDidScroll pageScrollView: UIScrollView!) {
        let color = UIColor(r: 255, g: 255, b: 255, a: 1.0)
        let headerContentViewHeight = -slidePageScrollView.headerView.gg_height + slidePageScrollView.pageTabBar.gg_height
        let offsetY = pageScrollView.contentOffset.y
        LogInfo(offsetY - headerContentViewHeight)
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
