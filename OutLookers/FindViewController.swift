//
//  FindViewController.swift
//  OutLookers
//
//  Created by C on 16/7/2.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class FindViewController: YGBaseViewController {

    var slidePageScrollView: TYSlidePageScrollView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }
    
    func setupSubViews() {
        slidePageScrollView = TYSlidePageScrollView(frame: CGRect(origin: CGPointZero, size: CGSize(width: ScreenWidth, height: ScreenHeight - 49))) // height - naviheight  偏移问题
        slidePageScrollView.dataSource = self
        slidePageScrollView.delegate = self
        view.addSubview(slidePageScrollView)
        
        let titlePageTabbar = TYTitlePageTabBar(titleArray: ["广场", "红人", "通告"])
        titlePageTabbar.frame = CGRect(origin: CGPointZero, size: CGSize(width: CGRectGetWidth(slidePageScrollView.frame), height: 64))
        titlePageTabbar.edgeInset = UIEdgeInsets(top: 25, left: 70, bottom: 0, right: 70)
        titlePageTabbar.horIndicatorSpacing = 10
        titlePageTabbar.backgroundColor = UIColor.whiteColor()
        slidePageScrollView.pageTabBar = titlePageTabbar
        
        let lineV = UIView()
        lineV.backgroundColor = kLineColor
        titlePageTabbar.addSubview(lineV)
        lineV.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(lineV.superview!)
            make.height.equalTo(1)
        }
        
        
        let squareVC = SquareViewController()
        squareVC.view.frame = view.frame
        self.addChildViewController(squareVC)
        
        let hotVC = HotManViewController()
        hotVC.view.frame = view.frame
        self.addChildViewController(hotVC)
        
        let circularVC = CircularViewController()
        circularVC.view.frame = view.frame
        //        talentVC.delegate = self
        self.addChildViewController(circularVC)
        
        slidePageScrollView.reloadData()
    }
}

extension FindViewController: TYSlidePageScrollViewDataSource, TYSlidePageScrollViewDelegate {
    func numberOfPageViewOnSlidePageScrollView() -> Int {
        return self.childViewControllers.count
    }
    
    func slidePageScrollView(slidePageScrollView: TYSlidePageScrollView!, pageVerticalScrollViewForIndex index: Int) -> UIScrollView! {
        if index == 0 {
            let tableViewVC = childViewControllers[index] as! SquareViewController
            return tableViewVC.tableView
        } else if index == 1 {
            let tableViewVC = childViewControllers[index] as! HotManViewController
            return tableViewVC.tableView
        } else {
            let tableViewVC = childViewControllers[index] as! CircularViewController
            return tableViewVC.tableView
        }
    }
    
    func slidePageScrollView(slidePageScrollView: TYSlidePageScrollView!, horizenScrollViewDidEndDecelerating scrollView: UIScrollView!) {
        LogInfo("end")
    }
    
    func slidePageScrollView(slidePageScrollView: TYSlidePageScrollView!, horizenScrollToPageIndex index: Int) {
        LogInfo(index)
    }
}

