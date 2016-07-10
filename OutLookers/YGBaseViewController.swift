//
//  YGBaseViewController.swift
//  SuperWay
//
//  Created by C on 15/9/16.
//  Copyright © 2015年 YoungKook. All rights reserved.
//

import UIKit

extension Selector {
    static let tapRightButton = #selector(YGBaseViewController.tapRightButton(_:))
}

class YGBaseViewController: UIViewController {
    
    
    //MARK: -LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = kBackgoundColor
    }
    
    func createNaviRightButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, forState: .Normal)
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 30)
        button.titleLabel?.font = UIFont.systemFontOfSize(16)
        button.addTarget(self, action: .tapRightButton, forControlEvents: .TouchUpInside)
        let rightBarButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = rightBarButton
        return button
    }
    
    func tapRightButton(sender: UIButton) {
        LogVerbose("baseviewcontroller tap right")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
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
}



