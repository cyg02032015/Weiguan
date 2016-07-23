//
//  YGBaseViewController.swift
//  SuperWay
//
//  Created by C on 15/9/16.
//  Copyright © 2015年 YoungKook. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

private extension Selector {
    static let backButtonPressed = #selector(YGBaseViewController.backButtonPressed(_:))
}

class YGBaseViewController: UIViewController {
    
    //MARK: -LifeCycle
    var back: UIButton!
    var backImgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = kBackgoundColor
        if self.navigationController?.viewControllers.count > 1 {
            let tumple: (UIButton, UIImageView) = Util.setupLeftBarButtonItemOfViewController(self, imgName: "back-1")
            back = tumple.0
            backImgView = tumple.1
            back.addTarget(self, action: .backButtonPressed, forControlEvents: .TouchUpInside)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if self.tabBarController?.tabBar.subviews.count > 2 {
            for child in self.tabBarController!.tabBar.subviews {
                if child.isKindOfClass(UIControl.self) {
                    child.removeFromSuperview()
                }
            }
        }
    }
    
    func backButtonPressed(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        print("\(NSStringFromClass(self.dynamicType))被销毁")
    }
}

extension YGBaseViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return kHeight(10)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(origin: CGPointZero, size: CGSize(width: ScreenWidth, height: kHeight(10))))
        view.backgroundColor = kBackgoundColor
        return view
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(origin: CGPointZero, size: CGSize(width: ScreenWidth, height: kHeight(10))))
        view.backgroundColor = kBackgoundColor
        return view
    }
}



