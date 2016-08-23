//
//  YGTabbarController.swift
//  SuperWay
//
//  Created by C on 15/9/16.
//  Copyright © 2015年 YoungKook. All rights reserved.
//

import UIKit

class YGTabbarController: UITabBarController {

    var customTabbar: YGTabbar!
    //MARK: - Life Cycle
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        //TODO: - 删除系统自带Tabbar按钮
        for child in self.tabBar.subviews {
            if child.isKindOfClass(UIControl.classForCoder()) {
                child.removeFromSuperview()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTabbar()
        addChildViewControllers()
        self.tabBar.translucent = false
        self.tabBar.backgroundImage = UIColor().imageWith(UIColor.clearColor())
        self.tabBar.shadowImage = UIColor().imageWith(UIColor.clearColor())
    }

    func addTabbar() {
        let tabbar = YGTabbar()
        tabbar.delegate = self
        self.tabBar.addSubview(tabbar)
        tabbar.snp.makeConstraints { make in
            make.edges.equalTo(self.tabBar)
        }
        customTabbar = tabbar
    }
    
    func addChildViewControllers() {
        
        // 首页
        let homeVC = HomeViewController()
        self.addChildViewController(homeVC, title: "首页", image: "home_normal", selectedImg: "home_chosen")
        // 发现
        let findVC = FindViewController()
        self.addChildViewController(findVC, title: "发现", image: "find_normal", selectedImg: "find_chosen")
        
        // 关注
        let followVC = FollowViewController()
        self.addChildViewController(followVC, title: "关注", image: "care_normal", selectedImg: "care_chosen")
        
        // 个人
        let mineVC = MineViewController()
        self.addChildViewController(mineVC, title: "我的", image: "me_normal", selectedImg: "me_chosen")
    }
    
    func addChildViewController(child: UIViewController, title: String?, image: String, selectedImg: String) {
        child.tabBarItem.title = title
        child.tabBarItem.image = UIImage(named: image)
        let selectedImage = UIImage(named: selectedImg)
        child.tabBarItem.selectedImage = selectedImage?.imageWithRenderingMode(.AlwaysOriginal)
        child.title = title
        let navi = YGNavigationController(rootViewController: child)
        customTabbar.addTabBarButtonWithItem(child.tabBarItem)
        self.addChildViewController(navi)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension YGTabbarController: YGTabbarDelegate {
    func tabbarDidSelect(tabbar: YGTabbar, didSelectedfrom: Int, to: Int) {
        if to == 5 {
            if UserSingleton.sharedInstance.isLogin() {
                let issuevc = IssueViewController()
                let navi = YGNavigationController(rootViewController: issuevc)
                self.presentViewController(navi, animated: true, completion: {})
            } else {
                let logView = YGLogView()
                logView.animation()
//                logView.tapLogViewClosure({ (type) in
//                    LogInfo(UIApplication.sharedApplication().keyWindow?.rootViewController)
//                    guard let controller = self.tabBar else {return}
//                        let navi = YGNavigationController(rootViewController: controller)
//                        Util.logViewTap(navi, type: type)
//                })
            }
//            navi.view.backgroundColor = UIColor(r: 0, g: 0, b: 0, a: 0.4)
//            self.definesPresentationContext = true
//            issuevc.view.backgroundColor = UIColor(r: 0, g: 0, b: 0, a: 0.4)
//            issuevc.modalPresentationStyle = .OverCurrentContext
            
        }
        self.selectedIndex = to
    }
}
