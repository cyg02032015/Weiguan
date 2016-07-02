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
        backgroundColor = UIColor.whiteColor()
        let lineV = UIView()
        lineV.backgroundColor = UIColor(hex: 0xDCDCDC)
        addSubview(lineV)
        lineV.snp.makeConstraints { (make) in
            make.top.equalTo(lineV.superview!).offset(-1)
            make.left.right.equalTo(lineV.superview!)
            make.height.equalTo(1)
        }
    }

    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented - YGTabbar")
    }

    public func addTabBarButtonWithItem(item: UITabBarItem) {
        if tabbarButtonCount > MaxTabButtonCount { return }
        if tabbarButtonCount == 2 {
            let centerContainer = UIView()
            centerContainer.clipsToBounds = true
            addSubview(centerContainer)
            let centerBtn = UIButton()
            centerBtn.addTarget(self, action: .tabbarClick, forControlEvents: .TouchUpInside)
            centerBtn.tag = 5
            centerBtn.contentMode = .ScaleAspectFit
            centerBtn.clipsToBounds = true
            centerBtn.setImage(UIImage(named: "add"), forState: .Normal)
            centerContainer.addSubview(centerBtn)
//            centerBtn.frame = CGRect(x: lastButton!.right, y: 0, width: self.width/CGFloat(MaxTabButtonCount), height: self.height)
            centerContainer.snp.makeConstraints { make in
                make.left.equalTo(lastButton!.snp.right)
                make.width.equalTo(centerContainer.superview!).multipliedBy(1.0/CGFloat(MaxTabButtonCount))
                make.height.equalTo(65)
                make.bottom.equalTo(centerContainer.superview!)
            }
            
            centerBtn.snp.makeConstraints(closure: { (make) in
                make.centerX.equalTo(centerBtn.superview!)
                make.centerY.equalTo(centerBtn.superview!)
                make.size.equalTo(65)
            })
            tabbarButtonCount += 1
            lastButton = centerBtn
        }
        let btn = YGTabbarButton()
        addSubview(btn)
//        btn.frame = CGRect(x: lastButton == nil ? 0 : lastButton!.right, y: 0, width: self.width/CGFloat(MaxTabButtonCount), height: self.height)
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
