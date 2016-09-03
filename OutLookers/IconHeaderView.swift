//
//  IconHeaderView.swift
//  OutLookers
//
//  Created by C on 16/7/1.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//  利用本类的需要指定size  为了获取图片的尺寸 哎

import UIKit

class IconHeaderView: UIView {
    
    typealias HeaderClosure = () -> ()
    var closure: HeaderClosure!
    var iconView: UIImageView!
    var vImgView: UIImageView!
    var didSetupConstraint: Bool = false
    
    var iconURL: NSURL! {
        didSet {
            iconView.yy_setImageWithURL(iconURL, placeholder: kHeadPlaceholder)
        }
    }
    
    var iconPlaceholder: UIImage! {
        didSet {
            iconView.image = iconPlaceholder
        }
    }
    private var _customCornerRadius: CGFloat = kScale(50/2)
    var customCornerRadius: CGFloat! {
        set {
            guard let radius = newValue else { LogWarn(" radius is nil "); return }
            _customCornerRadius = radius
            iconView.layer.cornerRadius = radius
        }
        get {
            return _customCornerRadius
        }
    }
    
    var vImgSize: CGSize! {
        didSet  {
            guard let vImg = vImgView else {return}
            vImg.snp.updateConstraints { (make) in
                make.size.equalTo(vImgSize)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    func setupSubViews() {
        iconView = UIImageView()
        iconView.userInteractionEnabled = true
        iconView.clipsToBounds = true
        iconView.layer.cornerRadius = _customCornerRadius
        addSubview(iconView)
        
        vImgView = UIImageView()
        addSubview(vImgView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(IconHeaderView.tapHeader))
        self.addGestureRecognizer(tap)
        iconView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(iconView.superview!)
        }
        
        vImgView.snp.makeConstraints { (make) in
            make.bottom.equalTo(vImgView.superview!)
            make.right.equalTo(vImgView.superview!)
            make.size.equalTo(kSize(12, height: 12))
        }
    }
    
    func setVimage(type: UserType) {
        switch type {
        case .HotMan: vImgView.image = UIImage(named: "Red")
        case .Organization: vImgView.image = UIImage(named: "blue")
        case .Fans: vImgView.image = UIImage(named: "Green")
        default: ""
        }
    }
    
    func tapHeader() {
        if self.closure != nil {
            self.closure()
        }
    }
    
    func iconHeaderTap(closure: HeaderClosure) {
        self.closure = closure
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
