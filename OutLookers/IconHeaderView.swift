//
//  IconHeaderView.swift
//  OutLookers
//
//  Created by C on 16/7/1.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class IconHeaderView: UIView {
    
    typealias HeaderClosure = () -> ()
    var closure: HeaderClosure!
    var iconView: UIImageView!
    var vImgView: UIImageView!
    
    var iconURL: String! {
        didSet {
            iconView.yy_setImageWithURL(iconURL.addImagePath(CGSize(width: iconView.gg_width, height: iconView.gg_height)), placeholder: kPlaceholder)
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
            make.edges.equalTo(iconView.superview!)
        }
        
        vImgView.snp.makeConstraints { (make) in
            make.bottom.equalTo(vImgView.superview!)
            make.right.equalTo(vImgView.superview!)
            make.size.equalTo(kSize(12, height: 12))
        }
        layoutIfNeeded()
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
