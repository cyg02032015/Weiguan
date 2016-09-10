//
//  PutCashViewController.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/19.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class PutCashViewController: YGBaseViewController {

    var slidePageScrollView: TYSlidePageScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }
    
    func setupSubViews() {
        title = "提现"
        slidePageScrollView = TYSlidePageScrollView(frame: CGRect(origin: CGPointZero, size: CGSize(width: ScreenWidth, height: ScreenHeight - NaviHeight))) // height - naviheight  偏移问题
        slidePageScrollView.dataSource = self
        slidePageScrollView.delegate = self
        view.addSubview(slidePageScrollView)
        
        let titlePageTabbar = TYTitlePageTabBar(titleArray: ["支付宝账户", "微信账户"])
        titlePageTabbar.frame = CGRect(origin: CGPointZero, size: CGSize(width: CGRectGetWidth(slidePageScrollView.frame), height: 46))
        titlePageTabbar.horIndicatorSpacing = 10
        titlePageTabbar.edgeInset = UIEdgeInsets(top: 0, left: 88, bottom: 0, right: 88)
        titlePageTabbar.backgroundColor = UIColor(hex: 0xf8f8f8)
        slidePageScrollView.pageTabBar = titlePageTabbar
        
        
        let aliVC = AliPutCashViewController()
        aliVC.view.frame = view.frame
        self.addChildViewController(aliVC)
        
        let weChatVC = WechatCashViewController()
        weChatVC.view.frame = view.frame
        self.addChildViewController(weChatVC)
        
        slidePageScrollView.reloadData()
    }

}

// MARK: - TYSlidePageScrollViewDataSource, TYSlidePageScrollViewDelegate
extension PutCashViewController: TYSlidePageScrollViewDataSource, TYSlidePageScrollViewDelegate {
    func numberOfPageViewOnSlidePageScrollView() -> Int {
        return self.childViewControllers.count
    }
    
    func slidePageScrollView(slidePageScrollView: TYSlidePageScrollView!, pageVerticalScrollViewForIndex index: Int) -> UIScrollView! {
        if index == 0 {
            let tableViewVC = childViewControllers[index] as! AliPutCashViewController
            return tableViewVC.tableView
        } else {
            let tableViewVC = childViewControllers[index] as! WechatCashViewController
            return tableViewVC.tableView
        }
    }
    
    func slidePageScrollView(slidePageScrollView: TYSlidePageScrollView!, horizenScrollViewDidEndDecelerating scrollView: UIScrollView!) {
        LogInfo("end")
    }
}