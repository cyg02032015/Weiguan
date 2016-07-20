//
//  MyComment1ViewController.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/20.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class MyCommentViewController: YGBaseViewController {

    var slidePageScrollView: TYSlidePageScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }
    
    func setupSubViews() {
        title = "我的评价"
        slidePageScrollView = TYSlidePageScrollView(frame: CGRect(origin: CGPointZero, size: CGSize(width: ScreenWidth, height: ScreenHeight - NaviHeight))) // height - naviheight  偏移问题
        slidePageScrollView.dataSource = self
        slidePageScrollView.delegate = self
        view.addSubview(slidePageScrollView)
        
        let head = CommentHeadView()
        head.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: kHeight(88))
        slidePageScrollView.headerView = head
        
        let titlePageTabbar = TYTitlePageTabBar(titleArray: ["才艺评价", "邀约评价"])
        titlePageTabbar.frame = CGRect(origin: CGPointZero, size: CGSize(width: CGRectGetWidth(slidePageScrollView.frame), height: 44))
        titlePageTabbar.horIndicatorSpacing = 10
        titlePageTabbar.textColor = UIColor(hex: 0x666666)
        titlePageTabbar.selectedTextColor = UIColor(hex: 0x666666)
        titlePageTabbar.horIndicatorColor = UIColor(hex: 0xc0c0c0)
        titlePageTabbar.edgeInset = UIEdgeInsets(top: 0, left: 70, bottom: 0, right: 70)
        titlePageTabbar.backgroundColor = UIColor(hex: 0xEEEEEE)
        slidePageScrollView.pageTabBar = titlePageTabbar
        
        
        let enterVC = CommentViewController()
        enterVC.view.frame = view.frame
        self.addChildViewController(enterVC)
        
        let releaseVC = CommentViewController()
        releaseVC.view.frame = view.frame
        self.addChildViewController(releaseVC)
        
        slidePageScrollView.reloadData()
    }

}

// MARK: - TYSlidePageScrollViewDataSource, TYSlidePageScrollViewDelegate
extension MyCommentViewController: TYSlidePageScrollViewDataSource, TYSlidePageScrollViewDelegate {
    func numberOfPageViewOnSlidePageScrollView() -> Int {
        return self.childViewControllers.count
    }
    
    func slidePageScrollView(slidePageScrollView: TYSlidePageScrollView!, pageVerticalScrollViewForIndex index: Int) -> UIScrollView! {
        if index == 0 {
            let tableViewVC = childViewControllers[index] as! CommentViewController
            return tableViewVC.tableView
        } else {
            let tableViewVC = childViewControllers[index] as! CommentViewController
            return tableViewVC.tableView
        }
    }
    
    func slidePageScrollView(slidePageScrollView: TYSlidePageScrollView!, horizenScrollViewDidEndDecelerating scrollView: UIScrollView!) {
        LogInfo("end")
    }
}