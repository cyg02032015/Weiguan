//
//  YGNavigationController.swift
//  SuperWay
//
//  Created by C on 15/9/16.
//  Copyright © 2015年 YoungKook. All rights reserved.
//

import UIKit

public class YGNavigationController: UINavigationController {

    public override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented-YGNavigationController")
    }
    
    public override func pushViewController(viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count>0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
    }
    
    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
