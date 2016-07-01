
//
//  YKSelectDateView.swift
//  OutLookers
//
//  Created by C on 16/6/19.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import SnapKit

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
    var picker: UIPickerView!
    var titleLabel: UILabel!
    var container: UIView!
    var cancel: UIButton!
    var sure: UIButton!
    var topContainer: UIView!
    var lineV: UIView!
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
        
        topContainer = UIView()
        container.addSubview(topContainer)
        
        cancel = UIButton()
        cancel.setTitle("取消", forState: .Normal)
        cancel.setTitleColor(kRedColor, forState: .Normal)
        cancel.titleLabel?.font = UIFont.customFontOfSize(16)
        cancel.layer.cornerRadius = 5
        cancel.layer.borderColor = kRedColor.CGColor
        cancel.layer.borderWidth = 1
        cancel.addTarget(self, action: .tapCancel, forControlEvents: .TouchUpInside)
        topContainer.addSubview(cancel)
        
        sure = UIButton()
        sure.setTitle("确定", forState: .Normal)
        sure.titleLabel?.font = UIFont.customFontOfSize(16)
        sure.layer.cornerRadius = 5
        sure.backgroundColor = kRedColor
        sure.addTarget(self, action: .tapSure, forControlEvents: .TouchUpInside)
        topContainer.addSubview(sure)
        
        titleLabel = UILabel()
        titleLabel.text = "才艺标价单位"
        titleLabel.textAlignment = .Center
        titleLabel.font = UIFont.customFontOfSize(16)
        topContainer.addSubview(titleLabel)
        
        lineV = UIView()
        lineV.backgroundColor = UIColor(hex: 0xE4E4E4)
        topContainer.addSubview(lineV)
        
        picker = UIPickerView()
        picker.delegate = delegate
        picker.dataSource = delegate
        container.addSubview(picker)
    }
    
    override func layoutSubviews() {
        container.snp.makeConstraints { (make) in
            make.left.right.equalTo(container.superview!)
            make.height.equalTo(kSelectDateHeight)
            make.bottom.equalTo(container.superview!).offset(kSelectDateHeight).priorityLow()
        }
        
        topContainer.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(topContainer.superview!)
            make.height.equalTo(50.5)
        }
        
        cancel.snp.makeConstraints { (make) in
            make.left.equalTo(cancel.superview!).offset(20)
            make.size.equalTo(CGSize(width: 60, height: 30))
            make.centerY.equalTo(cancel.superview!)
        }
        
        sure.snp.makeConstraints { (make) in
            make.right.equalTo(sure.superview!).offset(-20)
            make.size.equalTo(CGSize(width: 60, height: 30))
            make.centerY.equalTo(sure.superview!)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(cancel.snp.right).offset(10)
            make.right.equalTo(sure.snp.left).offset(-10)
            make.centerY.equalTo(titleLabel.superview!)
            make.height.equalTo(20)
        }
        
        lineV.snp.makeConstraints { (make) in
            make.left.right.equalTo(lineV.superview!)
            make.bottom.equalTo(lineV.superview!)
            make.height.equalTo(0.5)
        }
        
        picker.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(picker.superview!)
            make.top.equalTo(topContainer.snp.bottom)
        }
    }
    
    func animation() {
        
        container.snp.updateConstraints { (make) in
            make.bottom.equalTo(container.superview!)
        }
        setNeedsUpdateConstraints()
        updateConstraints()
        self.hidden = false
        UIView.animateWithDuration(0.3) {
            self.layoutIfNeeded()
            self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        }
    }
    
    func tapCancel(sender: UIButton) {
        container.snp.updateConstraints { (make) in
            make.bottom.equalTo(container.superview!).offset(kSelectDateHeight)
        }
        setNeedsUpdateConstraints()
        updateConstraints()
        UIView.animateWithDuration(0.3, animations: {
            self.layoutIfNeeded()
            self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        }) { (isCompleted) in
            self.hidden = true
        }
    }
    
    func tapSure(sender: UIButton) {
        container.snp.updateConstraints { (make) in
            make.bottom.equalTo(container.superview!).offset(kSelectDateHeight)
        }
        setNeedsUpdateConstraints()
        updateConstraints()
        delegate.pickerViewSelectedSure(sender)
        UIView.animateWithDuration(0.3, animations: {
            self.layoutIfNeeded()
            self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        }) { (isCompleted) in
            self.hidden = true
        }
    }
    
    func tapView(sender: UITapGestureRecognizer) {
        container.snp.updateConstraints { (make) in
            make.bottom.equalTo(container.superview!).offset(kSelectDateHeight)
        }
        setNeedsUpdateConstraints()
        updateConstraints()
        UIView.animateWithDuration(0.3, animations: {
            self.layoutIfNeeded()
            self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        }) { (isCompleted) in
            self.hidden = true
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}