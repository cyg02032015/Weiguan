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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }
    
    func setupSubViews() {
        self.title = "小包子"
        
        slidePageScrollView = TYSlidePageScrollView(frame: self.view.bounds)
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
        titlePageTabbar.edgeInset = UIEdgeInsets(top: 0, left: 100, bottom: 0, right: 100)
        titlePageTabbar.backgroundColor = UIColor(hex: 0xf8f8f8)
        slidePageScrollView.pageTabBar = titlePageTabbar
        
        let vc1 = TalentViewController()
        vc1.view.frame = self.view.frame
        self.addChildViewController(vc1)
        
        let vc2 = TalentViewController()
        vc2.view.frame = self.view.frame
        self.addChildViewController(vc2)
        let vc3 = TalentViewController()
        vc3.view.frame = self.view.frame
        self.addChildViewController(vc3)
        
        slidePageScrollView.reloadData()
    }
}

extension PHViewController: TYSlidePageScrollViewDataSource, TYSlidePageScrollViewDelegate {
    func numberOfPageViewOnSlidePageScrollView() -> Int {
        return self.childViewControllers.count
    }
    
    func slidePageScrollView(slidePageScrollView: TYSlidePageScrollView!, pageVerticalScrollViewForIndex index: Int) -> UIScrollView! {
        let tableViewVC = self.childViewControllers[index] as! TalentViewController
        return tableViewVC.tableView
    }
}