//
//  PHOrderListViewController.swift
//  OutLookers
//
//  Created by C on 16/7/13.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class PHOrderListViewController: YGBaseViewController {

    var slidePageScrollView: TYSlidePageScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "订单列表"
        
        slidePageScrollView = TYSlidePageScrollView(frame: CGRect(origin: CGPointZero, size: CGSize(width: ScreenWidth, height: ScreenHeight - NaviHeight))) // height - naviheight  偏移问题
        slidePageScrollView.dataSource = self
        slidePageScrollView.delegate = self
        view.addSubview(slidePageScrollView)
        
        let titlePageTabbar = TYTitlePageTabBar(titleArray: ["ta参与的", "ta发布的"])
        titlePageTabbar.frame = CGRect(origin: CGPointZero, size: CGSize(width: CGRectGetWidth(slidePageScrollView.frame), height: 46))
        titlePageTabbar.horIndicatorSpacing = 60
        titlePageTabbar.backgroundColor = UIColor(hex: 0xf8f8f8)
        slidePageScrollView.pageTabBar = titlePageTabbar
        
        let joinVC = TaJoinViewController()
        joinVC.view.frame = view.frame
        self.addChildViewController(joinVC)

        let releaseVC = TaReleaseViewController()
        releaseVC.view.frame = view.frame
        self.addChildViewController(releaseVC)
        
        slidePageScrollView.reloadData()
    }
}

// MARK: - TYSlidePageScrollViewDelegate, TYSlidePageScrollViewDataSource
extension PHOrderListViewController: TYSlidePageScrollViewDelegate, TYSlidePageScrollViewDataSource {
    func numberOfPageViewOnSlidePageScrollView() -> Int {
        return self.childViewControllers.count
    }
    
    func slidePageScrollView(slidePageScrollView: TYSlidePageScrollView!, pageVerticalScrollViewForIndex index: Int) -> UIScrollView! {
        if index == 0 {
            let tableViewVC = childViewControllers[index] as! TaJoinViewController
            return tableViewVC.tableView
        } else {
            let tableViewVC = childViewControllers[index] as! TaReleaseViewController
            return tableViewVC.tableView
        }
    }
}
