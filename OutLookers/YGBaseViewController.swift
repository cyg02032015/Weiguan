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





