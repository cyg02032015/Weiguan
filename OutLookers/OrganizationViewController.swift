
//
//  OrganizationViewController.swift
//  OutLookers
//
//  Created by C on 16/7/9.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class OrganizationViewController: YGBaseViewController {

    var slidePageScrollView: TYSlidePageScrollView!
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
        
        //        toolView = PHToolView()
        //        toolView.layer.cornerRadius = kScale(40/2)
        //        toolView.clipsToBounds = true
        //        view.addSubview(toolView)
        //        toolView.snp.makeConstraints { (make) in
        //            make.left.equalTo(toolView.superview!).offset(kScale(37))
        //            make.right.equalTo(toolView.superview!).offset(kScale(-37))
        //            make.height.equalTo(kScale(40))
        //            make.bottom.equalTo(toolView.superview!).offset(kScale(-15))
        //        }

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
    
    func slidePageScrollView(slidePageScrollView: TYSlidePageScrollView!, horizenScrollViewDidEndDecelerating scrollView: UIScrollView!) {
        LogInfo("end")
    }
}
