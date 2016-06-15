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
    }

    func addTabbar() {
        let tabbar = YGTabbar(frame: self.tabBar.bounds)
        tabbar.delegate = self
        self.tabBar.addSubview(tabbar)
        customTabbar = tabbar
    }
    
    func addChildViewControllers() {
        
        // 首页
        let homeVC = HomeViewController()
        self.addChildViewController(homeVC, title: "首页", image: "tab_home", selectedImg: "tab_home_selected")
        // 广场
        let squareVC = SquareViewController()
        self.addChildViewController(squareVC, title: "广场", image: "tab_order", selectedImg: "tab_order_selected")
        // 发布
        let issueVC = IssueViewController()
        self.addChildViewController(issueVC, title: "订单", image: "tab_list", selectedImg: "tab_list_selected")
        
        let followVC = FollowViewController()
        self.addChildViewController(followVC, title: "关注", image: "", selectedImg: "")
        
        // 个人
        let mineVC = MineViewController()
        self.addChildViewController(mineVC, title: "我的", image: "tab_people", selectedImg: "tab_people_selected")
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
//        if to == 2 && UserSingleton.shareManager.cookie == nil {
//            self.selectedIndex = didSelectedfrom
//            let logVC = SBQuick.loadStoryBoard(Identifier.Main, identifier: Identifier.LogRegSegue) as! LogIn_RegistViewController
//            logVC.isPresent = true
//            let navi = YGNavigationController(rootViewController: logVC)
//            presentViewController(navi, animated: true, completion: nil)
//            return
//        }
        self.selectedIndex = to
    }
}
