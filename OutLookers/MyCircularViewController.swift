//
//  MyCircularViewController.swift
//  OutLookers
//
//  Created by C on 16/7/18.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class MyCircularViewController: YGBaseViewController {

    var slidePageScrollView: TYSlidePageScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }
    
    func setupSubViews() {
        title = "我的通告"
        slidePageScrollView = TYSlidePageScrollView(frame: CGRect(origin: CGPoint(x: 0, y: NaviHeight), size: CGSize(width: ScreenWidth, height: ScreenHeight - NaviHeight))) // height - naviheight  偏移问题
//        slidePageScrollView.headerViewScrollEnable = true
//        slidePageScrollView.pageTabBarStopOnTopHeight = NaviHeight
        slidePageScrollView.dataSource = self
        slidePageScrollView.delegate = self
        view.addSubview(slidePageScrollView)
        
        let titlePageTabbar = TYTitlePageTabBar(titleArray: ["我报名的", "我发布的"])
        titlePageTabbar.frame = CGRect(origin: CGPointZero, size: CGSize(width: CGRectGetWidth(slidePageScrollView.frame), height: 46))
        titlePageTabbar.horIndicatorSpacing = 10
        titlePageTabbar.edgeInset = UIEdgeInsets(top: 0, left: 88, bottom: 0, right: 88)
        titlePageTabbar.backgroundColor = UIColor(hex: 0xf8f8f8)
        slidePageScrollView.pageTabBar = titlePageTabbar
        
        
        let enterVC = MyEnterViewController()
        enterVC.view.frame = view.frame
        self.addChildViewController(enterVC)
        
        let releaseVC = MyReleaseViewController()
        releaseVC.view.frame = view.frame
        self.addChildViewController(releaseVC)
        
        slidePageScrollView.reloadData()
    }
}

// MARK: - TYSlidePageScrollViewDataSource, TYSlidePageScrollViewDelegate
extension MyCircularViewController: TYSlidePageScrollViewDataSource, TYSlidePageScrollViewDelegate {
    func numberOfPageViewOnSlidePageScrollView() -> Int {
        return self.childViewControllers.count
    }
    
    func slidePageScrollView(slidePageScrollView: TYSlidePageScrollView!, pageVerticalScrollViewForIndex index: Int) -> UIScrollView! {
        if index == 0 {
            let tableViewVC = childViewControllers[index] as! MyEnterViewController
            return tableViewVC.tableView
        } else {
            let tableViewVC = childViewControllers[index] as! MyReleaseViewController
            return tableViewVC.tableView
        }
    }
    
    func slidePageScrollView(slidePageScrollView: TYSlidePageScrollView!, horizenScrollViewDidEndDecelerating scrollView: UIScrollView!) {
        LogInfo("end")
    }
}
