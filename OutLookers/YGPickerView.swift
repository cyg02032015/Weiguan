
//
//  YKSelectDateView.swift
//  OutLookers
//
//  Created by C on 16/6/19.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let kSelectDateHeight: CGFloat = 197

private extension Selector {
    static let tapCancel = #selector(YGSelectDateView.tapCancel(_:))
    static let tapSure = #selector(YGSelectDateView.tapSure(_:))
    static let tapView = #selector(YGSelectDateView.tapView(_:))
}

protocol YGPickerViewDelegate: class {
    func pickerViewSelectedSure(sender: UIButton)
}


class YGPickerView: UIView {
    var pickerView: UIPickerView!
    var titleLabel: UILabel!
    var container: UIView!
    weak var delegate: YGPickerViewDelegate!
    
    convenience init(frame: CGRect, delegate: protocol<UIPickerViewDataSource, UIPickerViewDelegate>) {
        self.init(frame: frame)
        setupSubViews(delegate)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setupSubViews()
    }
    
    func setupSubViews(delegate: protocol<UIPickerViewDataSource, UIPickerViewDelegate>) {
        
        let tap = UITapGestureRecognizer(target: self, action: .tapView)
        addGestureRecognizer(tap)
        
        container = UIView()
        container.backgroundColor = UIColor.whiteColor()
        addSubview(container)
        
        let topContainer = UIView()
        container.addSubview(topContainer)
        
        let cancel = UIButton()
        cancel.setTitle("取消", forState: .Normal)
        cancel.setTitleColor(kRedColor, forState: .Normal)
        cancel.titleLabel?.font = UIFont.systemFontOfSize(16)
        cancel.layer.cornerRadius = 5
        cancel.layer.borderColor = kRedColor.CGColor
        cancel.layer.borderWidth = 1
        cancel.addTarget(self, action: .tapCancel, forControlEvents: .TouchUpInside)
        topContainer.addSubview(cancel)
        
        let sure = UIButton()
        sure.setTitle("确定", forState: .Normal)
        sure.titleLabel?.font = UIFont.systemFontOfSize(16)
        sure.layer.cornerRadius = 5
        sure.backgroundColor = kRedColor
        sure.addTarget(self, action: .tapSure, forControlEvents: .TouchUpInside)
        topContainer.addSubview(sure)
        
        titleLabel = UILabel()
        titleLabel.text = "才艺标价单位"
        titleLabel.textAlignment = .Center
        titleLabel.font = UIFont.systemFontOfSize(16)
        topContainer.addSubview(titleLabel)
        
        let lineV = UIView()
        lineV.backgroundColor = UIColor(hex: 0xE4E4E4)
        topContainer.addSubview(lineV)
        
        pickerView = UIPickerView()
        pickerView.delegate = delegate
        pickerView.dataSource = delegate
        container.addSubview(pickerView)
        
        container.frame = CGRect(x: 0, y: ScreenHeight, width: ScreenWidth, height: kSelectDateHeight)
        
        topContainer.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 50.5)
        
        cancel.frame = CGRect(x: 20, y: topContainer.center.y - 15, width: 60, height: 30)
        
        sure.frame = CGRect(x: ScreenWidth - 20 - 60, y: topContainer.center.y - 15, width: 60, height: 30)
        
        titleLabel.frame = CGRect(x: CGRectGetMaxX(cancel.frame) + 10, y: topContainer.center.y - 15, width: ScreenWidth - CGRectGetMaxX(cancel.frame) - CGRectGetMinX(sure.frame), height: 30)
        
        lineV.frame = CGRect(x: 0, y: CGRectGetMaxY(topContainer.frame) - 1, width: ScreenWidth, height: 1)
        
        pickerView.frame = CGRect(x: 0, y: CGRectGetMaxY(topContainer.frame), width: ScreenWidth, height: CGRectGetHeight(container.frame) - CGRectGetHeight(topContainer.frame))

    }
    
    func animation() {
        self.hidden = false
        UIView.animateWithDuration(0.3) {
            self.container.frame.origin.y = ScreenHeight - kSelectDateHeight
            self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        }
    }
    
    func tapCancel(sender: UIButton) {
        UIView.animateWithDuration(0.3, animations: {
            self.container.frame.origin.y = ScreenHeight
            self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        }) { (isCompleted) in
            self.hidden = true
        }
    }
    
    func tapSure(sender: UIButton) {
        delegate.pickerViewSelectedSure(sender)
        UIView.animateWithDuration(0.3, animations: {
            self.container.frame.origin.y = ScreenHeight
            self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        }) { (isCompleted) in
            self.hidden = true
        }
    }
    
    func tapView(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.3, animations: {
            self.container.frame.origin.y = ScreenHeight
            self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        }) { (isCompleted) in
            self.hidden = true
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}