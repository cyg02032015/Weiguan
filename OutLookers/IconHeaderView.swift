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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }

    func setupSubViews() {
        iconView = UIImageView()
        iconView.userInteractionEnabled = true
        iconView.clipsToBounds = true
//        iconView.layer.cornerRadius = 50/2
        addSubview(iconView)
        
        vImgView = UIImageView()
        addSubview(vImgView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(IconHeaderView.tapHeader))
        self.addGestureRecognizer(tap)
        
        iconView.backgroundColor = UIColor.yellowColor()
        vImgView.backgroundColor = UIColor.redColor()
        
        iconView.snp.makeConstraints { (make) in
            make.edges.equalTo(iconView.superview!)
        }
        
        vImgView.snp.makeConstraints { (make) in
            make.bottom.equalTo(vImgView.superview!)
            make.right.equalTo(vImgView.superview!)
            make.size.equalTo(CGSize(width: 12, height: 12))
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
