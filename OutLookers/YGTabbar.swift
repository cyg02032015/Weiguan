//
//  YGTabbar.swift
//  SuperWay
//
//  Created by C on 15/9/16.
//  Copyright © 2015年 YoungKook. All rights reserved.
//

import UIKit

private extension Selector {
    static let tabbarClick = #selector(YGTabbar.tabbarClick(_:))
}

public protocol YGTabbarDelegate {
    func tabbarDidSelect(tabbar: YGTabbar, didSelectedfrom: Int, to: Int)
}

let MaxTabButtonCount: CGFloat = 5

public class YGTabbar: UIView {

    
    public var delegate: YGTabbarDelegate!
    
    
    private var tabbarButtonCount: Int = 0
    private lazy var selectButton: YGTabbarButton = {
        let btn = YGTabbarButton()
        return btn
    }()
    public override init(frame: CGRect) {
        super.init(frame: frame)
        //TODO: - 设置背景
        self.backgroundColor = UIColor.redColor()
        
    }

    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented - YGTabbar")
    }

    public func addTabBarButtonWithItem(item: UITabBarItem) {
        
        if tabbarButtonCount > Int(MaxTabButtonCount) { return }
        let btn = YGTabbarButton()
        let btnY = 0 as CGFloat
        let btnW = self.width / MaxTabButtonCount
        let btnX = btnW * CGFloat(tabbarButtonCount)
        let btnH = self.height
        btn.frame = CGRect(x: btnX, y: btnY, width: btnW, height: btnH)
        btn.addTarget(self, action: .tabbarClick, forControlEvents: UIControlEvents.TouchDown)
        btn.tag = tabbarButtonCount
        if tabbarButtonCount == 0 {
            self.tabbarClick(btn)
        }
        btn.item = item
        self.addSubview(btn)
        tabbarButtonCount += 1
    }
    
    func tabbarClick(btn: YGTabbarButton) {
        delegate.tabbarDidSelect(self, didSelectedfrom: selectButton.tag, to: btn.tag)
//        if btn.tag == 2 && UserSingleton.shareManager.cookie == nil {
//            return
//        }
        selectButton.selected = false
        btn.selected = true
        selectButton = btn
    }
}
