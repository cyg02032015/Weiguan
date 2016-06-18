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

let MaxTabButtonCount: Int = 5

public class YGTabbar: UIView {

    
    public var delegate: YGTabbarDelegate!
    
    private var lastButton: UIButton?
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
        if tabbarButtonCount > MaxTabButtonCount { return }
        if tabbarButtonCount == 2 {
            let centerBtn = UIButton()
            centerBtn.addTarget(self, action: .tabbarClick, forControlEvents: .TouchUpInside)
            centerBtn.tag = 5
            addSubview(centerBtn)
            centerBtn.snp.makeConstraints { make in
                make.left.equalTo(lastButton!.snp.right)
                make.width.equalTo(centerBtn.superview!).multipliedBy(1.0/CGFloat(MaxTabButtonCount))
                make.top.bottom.equalTo(centerBtn.superview!)
            }
            tabbarButtonCount += 1
            lastButton = centerBtn
        }
        let btn = YGTabbarButton()
        addSubview(btn)
        btn.snp.makeConstraints { make in
            make.left.equalTo(lastButton == nil ? btn.superview! : lastButton!.snp.right)
            make.top.bottom.equalTo(btn.superview!)
            make.width.equalTo(btn.superview!).multipliedBy(1.0/CGFloat(MaxTabButtonCount))
            if tabbarButtonCount == MaxTabButtonCount {
                make.right.equalTo(btn.superview!)
            }
        }
        btn.addTarget(self, action: .tabbarClick, forControlEvents: UIControlEvents.TouchDown)
        if tabbarButtonCount == 3 {
            let t = tabbarButtonCount - 1
            btn.tag = t
        } else {
            btn.tag = tabbarButtonCount == 4 ? 3 : tabbarButtonCount
        }
        if tabbarButtonCount == 0 {
            self.tabbarClick(btn)
        }
        lastButton = btn
        btn.item = item
        tabbarButtonCount += 1
    }
    
    func tabbarClick(btn: YGTabbarButton) {
        delegate.tabbarDidSelect(self, didSelectedfrom: selectButton.tag, to: btn.tag)
        if btn.tag == 5 {
            return
        }
        // TODO
        selectButton.selected = false
        btn.selected = true
        selectButton = btn
    }
}
