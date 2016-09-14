
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



class YGSelectDateView: UIView {
    typealias GetDate = (date: NSDate) -> Void
    var getDate: GetDate!
    var datePicker: UIDatePicker!
    var titleLabel: UILabel!
    var container: UIView!
    var minimumDate: NSDate? {
        didSet {
            self.datePicker.minimumDate = minimumDate
        }
    }
    var maximumDate: NSDate? {
        didSet {
            self.datePicker.maximumDate = maximumDate
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    func setupSubViews() {
        
        let tap = UITapGestureRecognizer(target: self, action: .tapView)
        addGestureRecognizer(tap)
        
        container = UIView()
        container.backgroundColor = UIColor.whiteColor()
        addSubview(container)
        
        let topContainer = UIView()
        container.addSubview(topContainer)
        
        let cancel = UIButton()
        cancel.setTitle("取消", forState: .Normal)
        cancel.setTitleColor(kCommonColor, forState: .Normal)
        cancel.titleLabel?.font = UIFont.customFontOfSize(16)
        cancel.layer.cornerRadius = 5
        cancel.layer.borderColor = kCommonColor.CGColor
        cancel.layer.borderWidth = 1
        cancel.addTarget(self, action: .tapCancel, forControlEvents: .TouchUpInside)
        topContainer.addSubview(cancel)
        
        let sure = UIButton()
        sure.setTitle("确定", forState: .Normal)
        sure.titleLabel?.font = UIFont.customFontOfSize(16)
        sure.layer.cornerRadius = 5
        sure.backgroundColor = kCommonColor
        sure.addTarget(self, action: .tapSure, forControlEvents: .TouchUpInside)
        topContainer.addSubview(sure)
        
        titleLabel = UILabel()
        titleLabel.text = "请选择时间"
        titleLabel.textAlignment = .Center
        titleLabel.font = UIFont.customFontOfSize(16)
        topContainer.addSubview(titleLabel)
        
        let lineV = UIView()
        lineV.backgroundColor = UIColor(hex: 0xE4E4E4)
        topContainer.addSubview(lineV)
        
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .Date
        container.addSubview(datePicker)
        datePicker.locale = NSLocale(localeIdentifier: "zh_Hans")
        
        container.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(container.superview!)
            make.height.equalTo(kSelectDateHeight)
        }
        
        topContainer.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(topContainer.superview!)
            make.height.equalTo(50.5)
        }
        
        cancel.snp.makeConstraints { (make) in
            make.left.equalTo(cancel.superview!).offset(20)
            make.centerY.equalTo(cancel.superview!)
            make.size.equalTo(CGSize(width: 60, height: 30))
        }
        
        sure.snp.makeConstraints { (make) in
            make.right.equalTo(sure.superview!).offset(-20)
            make.centerY.equalTo(cancel)
            make.size.equalTo(cancel)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(cancel.snp.right).offset(10)
            make.right.equalTo(sure.snp.left).offset(-10)
            make.centerY.equalTo(titleLabel.superview!)
        }
        
        lineV.snp.makeConstraints { (make) in
            make.left.right.equalTo(lineV.superview!)
            make.height.equalTo(0.5)
            make.bottom.equalTo(lineV.superview!)
        }
        
        datePicker.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(datePicker.superview!)
            make.top.equalTo(topContainer.snp.bottom)
        }
        
    }
    
    func animation() {
        guard let view = UIApplication.sharedApplication().keyWindow else {
            LogError("keyWindow is nil")
            return
        }
        view.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.edges.equalTo(self.superview!)
        }
        delay(0.05) { [unowned self] in
            self.container.snp.updateConstraints { (make) in
                make.bottom.equalTo(self.container.superview!)
            }
            self.setNeedsUpdateConstraints()
            self.updateConstraints()
            UIView.animateWithDuration(0.3) {
                self.layoutIfNeeded()
                self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
            }
        }
    }
    
    func tapCancel(sender: UIButton) {
        if self.superview == nil {
            LogError("picker does not superview")
            return
        }
        container.snp.updateConstraints { (make) in
            make.bottom.equalTo(container.superview!).offset(kSelectDateHeight)
        }
        setNeedsUpdateConstraints()
        updateConstraints()
        UIView.animateWithDuration(0.3, animations: {
            self.layoutIfNeeded()
            self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        }) { (isCompleted) in
            self.removeFromSuperview()
        }
    }
    
    func tapSure(sender: UIButton) {
        if self.superview == nil {
            LogError("picker does not superview")
            return
        }
        if getDate != nil {
            self.getDate(date: datePicker.date)
        }
        
        container.snp.updateConstraints { (make) in
            make.bottom.equalTo(container.superview!).offset(kSelectDateHeight)
        }
        setNeedsUpdateConstraints()
        updateConstraints()
        UIView.animateWithDuration(0.3, animations: {
            self.layoutIfNeeded()
            self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        }) { (isCompleted) in
            self.removeFromSuperview()
        }
    }
    
    func tapView(sender: UITapGestureRecognizer) {
        if self.superview == nil {
            LogError("picker does not superview")
            return
        }
        container.snp.updateConstraints { (make) in
            make.bottom.equalTo(container.superview!).offset(kSelectDateHeight)
        }
        setNeedsUpdateConstraints()
        updateConstraints()
        UIView.animateWithDuration(0.3, animations: {
            self.layoutIfNeeded()
            self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        }) { (isCompleted) in
            self.removeFromSuperview()
        }
    }
    
    func tapSureClosure(closure: GetDate) {
        self.getDate = closure
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}