//
//  PersonalHomepageViewController.swift
//  OutLookers
//
//  Created by C on 16/7/4.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//  PersonalHomepageViewController   个人主页

import UIKit

class PHViewController: YGBaseViewController {

    var slidePageScrollView: TYSlidePageScrollView!
    var tableView: UITableView!
    var toolView: PHToolView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }
    
    func setupSubViews() {
        self.title = "小包子"
        slidePageScrollView = TYSlidePageScrollView(frame: CGRect(origin: CGPointZero, size: CGSize(width: ScreenWidth, height: ScreenHeight - NaviHeight))) // height - naviheight  偏移问题
        slidePageScrollView.pageTabBarIsStopOnTop = true
        slidePageScrollView.pageTabBarStopOnTopHeight = 0
        slidePageScrollView.parallaxHeaderEffect = false
        slidePageScrollView.dataSource = self
        slidePageScrollView.delegate = self
        view.addSubview(slidePageScrollView)
        
        let header = PHHeaderView()
        header.frame = CGRect(origin: CGPointZero, size: CGSize(width: ScreenWidth, height: kHeight(230)))
        
        slidePageScrollView.headerView = header
        
        let titlePageTabbar = TYTitlePageTabBar(titleArray: ["资料", "动态", "才艺"])
        titlePageTabbar.frame = CGRect(origin: CGPointZero, size: CGSize(width: CGRectGetWidth(slidePageScrollView.frame), height: 46))
        titlePageTabbar.edgeInset = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 80)
        titlePageTabbar.backgroundColor = UIColor(hex: 0xf8f8f8)
        slidePageScrollView.pageTabBar = titlePageTabbar
        
        
        let dataVC = DataViewController()
        dataVC.view.frame = view.frame
        self.addChildViewController(dataVC)
        
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
            let tableViewVC = childViewControllers[index] as! DataViewController
            return tableViewVC.tableView
        } else if index == 1 {
            let tableViewVC = childViewControllers[index] as! DynamicViewController
            return tableViewVC.tableView
        } else {
            let tableViewVC = childViewControllers[index] as! TalentViewController
            return tableViewVC.tableView
        }
    }
    
    func slidePageScrollView(slidePageScrollView: TYSlidePageScrollView!, horizenScrollViewDidEndDecelerating scrollView: UIScrollView!) {
        LogInfo("end")
    }
}