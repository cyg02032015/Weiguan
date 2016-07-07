//
//  PHToolView.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/7.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class PHToolView: UIView {

    var follow: UIButton!      // 关注
    var privateLatter: UIButton!  // 私信
    var invitation: UIButton!     // 邀约
    
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
            make.width.equalTo(follow.superview!).multipliedBy(1/3.0)
        }
        
        privateLatter = UIButton()
        privateLatter.setTitle("私信", forState: .Normal)
        privateLatter.setTitleColor(kCommonColor, forState: .Normal)
        privateLatter.titleLabel?.font = UIFont.customFontOfSize(16)
        privateLatter.setImage(UIImage(named: "private letter"), forState: .Normal)
        privateLatter.backgroundColor = UIColor.whiteColor()
        addSubview(privateLatter)
        privateLatter.snp.makeConstraints { (make) in
            make.left.equalTo(follow.snp.right)
            make.width.equalTo(follow)
            make.top.equalTo(privateLatter.superview!).offset(1)
            make.bottom.equalTo(privateLatter.superview!).offset(-1)
        }
        
        invitation = UIButton()
        invitation.setTitle("邀约", forState: .Normal)
        invitation.titleLabel?.font = UIFont.customFontOfSize(16)
        invitation.setImage(UIImage(named: "invitation"), forState: .Normal)
        invitation.backgroundColor = kCommonColor
        addSubview(invitation)
        invitation.snp.makeConstraints { (make) in
            make.left.equalTo(privateLatter.snp.right)
            make.width.equalTo(privateLatter)
            make.top.bottom.equalTo(follow)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
