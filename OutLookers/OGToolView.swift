//
//  OGToolView.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/11.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class OGToolView: UIView {

    var follow: UIButton!      // 关注
    var privateLatter: UIButton!  // 私信
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
        backgroundColor = kCommonColor
    }
    
    
    func setupSubViews() {
        follow = UIButton()
        follow.setTitle("关注", forState: .Normal)
        follow.titleLabel?.font = UIFont.customFontOfSize(16)
        follow.setImage(UIImage(named: "follow"), forState: .Normal)
        follow.backgroundColor = kCommonColor
        addSubview(follow)
        follow.snp.makeConstraints { (make) in
            make.top.bottom.left.equalTo(follow.superview!)
            make.width.equalTo(follow.superview!).multipliedBy(1/2.0)
        }
        
        let lineV = UIView()
        lineV.backgroundColor = UIColor.whiteColor()
        addSubview(lineV)
        lineV.snp.makeConstraints { (make) in
            make.left.equalTo(follow.snp.right)
            make.size.equalTo(kSize(1, height: 29))
            make.centerY.equalTo(lineV.superview!)
        }
        
        privateLatter = UIButton()
        privateLatter.setTitle("私信", forState: .Normal)
        privateLatter.titleLabel?.font = UIFont.customFontOfSize(16)
        privateLatter.setImage(UIImage(named: "private letter"), forState: .Normal)
        privateLatter.backgroundColor = kCommonColor
        addSubview(privateLatter)
        privateLatter.snp.makeConstraints { (make) in
            make.left.equalTo(lineV.snp.right)
            make.width.equalTo(follow)
            make.top.equalTo(privateLatter.superview!)
            make.bottom.equalTo(privateLatter.superview!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
