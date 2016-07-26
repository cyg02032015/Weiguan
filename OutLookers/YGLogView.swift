//
//  YGLogView.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/26.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private extension Selector {
    static let tapCancel = #selector(YGLogView.tapCancel(_:))
    static let tapLogView = #selector(YGLogView.tapLogView(_:))
    static let tapView = #selector(YGLogView.tapView(_:))
}

enum LogViewTapType: Int {
    case Wechat = 1300
    case QQ = 1301
    case Weibo = 1302
    case Phone = 1303
    case Iagree = 1304
    case Register = 1305
}

class YGLogView: UIView {
    typealias TapLogViewClosure = (type: LogViewTapType)->()
    var container: UIView!
    var cancel: UIButton!
    var line1: UIView!
    var line2: UIView!
    var logLabel: UILabel!
    var wechat: CircelView!
    var qq: CircelView!
    var weibo: CircelView!
    var phoneLog: UIButton!
    var iagree: UIButton!
    var register: UIButton!
    var tapClosure: TapLogViewClosure!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    func setupSubViews() {
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        let tap = UITapGestureRecognizer(target: self, action: .tapView)
        tap.delegate = self
        addGestureRecognizer(tap)
        
        container = UIView()
        container.layer.cornerRadius = kScale(12)
        container.backgroundColor = UIColor.whiteColor()
        addSubview(container)
        
        cancel = UIButton()
        cancel.setImage(UIImage(named: "cancel"), forState: .Normal)
        cancel.layer.cornerRadius = kScale(32/2)
        cancel.addTarget(self, action: .tapCancel, forControlEvents: .TouchUpInside)
        container.addSubview(cancel)
        
        line1 = UIView()
        line1.backgroundColor = kLineColor
        container.addSubview(line1)
        
        logLabel = UILabel.createLabel(12, textColor: UIColor(hex: 0x666666))
        logLabel.text = "登录纯氧"
        logLabel.textAlignment = .Center
        container.addSubview(logLabel)
        
        line2 = UIView()
        line2.backgroundColor = kLineColor
        container.addSubview(line2)
        
        wechat = CircelView(logCircleframe: CGRectZero, imgname: kSelectedWechat, title: "微信登录")
        wechat.tag = LogViewTapType.Wechat.rawValue
        container.addSubview(wechat)
        let tapWechat = UITapGestureRecognizer(target: self, action: .tapLogView)
        wechat.addGestureRecognizer(tapWechat)
        
        qq = CircelView(logCircleframe: CGRectZero, imgname: kSelectedQQ, title: "QQ登录")
        qq.tag = LogViewTapType.QQ.rawValue
        container.addSubview(qq)
        let tapQQ = UITapGestureRecognizer(target: self, action: .tapLogView)
        qq.addGestureRecognizer(tapQQ)
        
        weibo = CircelView(logCircleframe: CGRectZero, imgname: kSelectedSina, title: "微博登录")
        weibo.tag = LogViewTapType.Weibo.rawValue
        container.addSubview(weibo)
        let tapWeibo = UITapGestureRecognizer(target: self, action: .tapLogView)
        weibo.addGestureRecognizer(tapWeibo)
        
        phoneLog = UIButton()
        phoneLog.tag = LogViewTapType.Phone.rawValue
        phoneLog.addTarget(self, action: .tapLogView, forControlEvents: .TouchUpInside)
        phoneLog.layer.cornerRadius = kScale(8)
        phoneLog.backgroundColor = kCommonColor
        phoneLog.setTitle("手机号登录", forState: .Normal)
        phoneLog.titleLabel!.font = UIFont.customFontOfSize(14)
        container.addSubview(phoneLog)
        
        iagree = UIButton()
        iagree.tag = LogViewTapType.Iagree.rawValue
        iagree.addTarget(self, action: .tapLogView, forControlEvents: .TouchUpInside)
        iagree.setTitle("我同意《纯氧用户协议》", forState: .Normal)
        iagree.setTitleColor(UIColor(hex: 0x666666), forState: .Normal)
        iagree.titleLabel!.font = UIFont.customFontOfSize(12)
        container.addSubview(iagree)
        
        register = UIButton()
        register.tag = LogViewTapType.Register.rawValue
        register.addTarget(self, action: .tapLogView, forControlEvents: .TouchUpInside)
        register.setTitle("注册账号", forState: .Normal)
        register.setTitleColor(UIColor(hex: 0xff6464), forState: .Normal)
        register.titleLabel!.font = UIFont.customFontOfSize(12)
        container.addSubview(register)
    }
    
    override func layoutSubviews() {
        container.snp.makeConstraints { (make) in
            make.width.equalTo(kScale(270))
            make.height.equalTo(kScale(248))
            make.centerX.equalTo(container.superview!)
            make.centerY.equalTo(container.superview!).offset(ScreenHeight).priorityLow()
        }
        
        cancel.snp.makeConstraints { (make) in
            make.left.equalTo(cancel.superview!).offset(kScale(-14))
            make.top.equalTo(cancel.superview!).offset(kScale(-13))
            make.size.equalTo(CGSize(width: 32, height: 32))
        }

        logLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(logLabel.superview!)
            make.top.equalTo(kScale(20))
            make.width.equalTo(kScale(48))
            make.height.equalTo(kScale(12))
        }
        
        line1.snp.makeConstraints { (make) in
            make.centerY.equalTo(logLabel)
            make.left.equalTo(line1.superview!).offset(kScale(25))
            make.right.equalTo(logLabel.snp.left).offset(kScale(-6))
            make.height.equalTo(1)
        }
        
        line2.snp.makeConstraints { (make) in
            make.centerY.equalTo(logLabel)
            make.left.equalTo(logLabel.snp.right).offset(kScale(6))
            make.right.equalTo(line2.superview!).offset(kScale(-25))
            make.height.equalTo(1)
        }
        
        qq.snp.makeConstraints { (make) in
            make.centerX.equalTo(qq.superview!)
            make.size.equalTo(kSize(50, height: 72))
            make.top.equalTo(logLabel.snp.bottom).offset(kScale(25))
        }
        
        wechat.snp.makeConstraints { (make) in
            make.right.equalTo(qq.snp.left).offset(kScale(-35))
            make.size.equalTo(qq)
            make.centerY.equalTo(qq)
        }
        
        weibo.snp.makeConstraints { (make) in
            make.left.equalTo(qq.snp.right).offset(kScale(35))
            make.size.equalTo(qq)
            make.centerY.equalTo(qq)
        }
        
        phoneLog.snp.makeConstraints { (make) in
            make.left.equalTo(phoneLog.superview!).offset(kScale(25))
            make.right.equalTo(phoneLog.superview!).offset(kScale(-25))
            make.top.equalTo(qq.snp.bottom).offset(kScale(25))
            make.height.equalTo(kScale(44))
        }
        
        register.snp.makeConstraints { (make) in
            make.right.equalTo(register.superview!).offset(kScale(-25))
            make.size.equalTo(kSize(50, height: 15))
            make.bottom.equalTo(kScale(-13))
        }
        
        iagree.snp.makeConstraints { (make) in
            make.left.equalTo(iagree.superview!).offset(kScale(25))
            make.bottom.equalTo(iagree.superview!).offset(kScale(-13))
            make.right.equalTo(register.snp.left).offset(kScale(-38))
            make.height.equalTo(kScale(15))
        }
    }
    
    func tapLogViewClosure(closure: TapLogViewClosure) {
        self.tapClosure = closure
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
                make.centerY.equalTo(self.container.superview!)
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
            make.centerY.equalTo(container.superview!).offset(ScreenHeight)
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
    
    func tapLogView(sender: AnyObject) {
        if self.superview == nil {
            LogError("picker does not superview")
            return
        }
        if tapClosure != nil {
            if let btn = sender as? UIButton {
                if btn.tag == LogViewTapType.Phone.rawValue {
                    tapClosure(type: .Phone)
                } else if btn.tag == LogViewTapType.Iagree.rawValue {
                    tapClosure(type: .Iagree)
                } else if btn.tag == LogViewTapType.Register.rawValue {
                    tapClosure(type: .Register)
                } else {
                    LogError("no bind type")
                }
            }
            if let tap = sender as? UITapGestureRecognizer {
                if tap.view!.tag == LogViewTapType.Wechat.rawValue {
                    tapClosure(type: .Wechat)
                } else if tap.view!.tag == LogViewTapType.QQ.rawValue {
                    tapClosure(type: .QQ)
                } else if tap.view!.tag == LogViewTapType.Weibo.rawValue {
                    tapClosure(type: .Weibo)
                } else {
                    LogError("no bind type")
                }
            }
        }
        				
        container.snp.updateConstraints { (make) in
            make.centerY.equalTo(container.superview!).offset(ScreenHeight)
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
            make.centerY.equalTo(container.superview!).offset(ScreenHeight)
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
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension YGLogView: UIGestureRecognizerDelegate {
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        if touch.view == container {
            return false
        } else {
            return true
        }
    }
}
