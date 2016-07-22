//
//  OGToolView.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/11.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private extension Selector {
    static let tapFollow = #selector(OGToolView.tapFollow(_:))
    static let tapPrivateLatter = #selector(OGToolView.tapPrivateLatter(_:))
}

protocol OGToolViewDelegate: class {
    func toolViewTapFollow(sender: UIButton)
    func toolViewTapPrivateLatter(sender: UIButton)
}

class OGToolView: UIView {

    weak var delegate: OGToolViewDelegate!
    var follow: UIButton!      // 关注
    var privateLatter: UIButton!  // 私信
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
        backgroundColor = kCommonColor
    }
    
    
    func setupSubViews() {
        follow = UIButton()
        follow.addTarget(self, action: .tapFollow, forControlEvents: .TouchUpInside)
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
        privateLatter.addTarget(self, action: .tapPrivateLatter, forControlEvents: .TouchUpInside)
        privateLatter.setTitle("私信", forState: .Normal)
        privateLatter.titleLabel?.font = UIFont.customFontOfSize(16)
        privateLatter.setImage(UIImage(named: "white"), forState: .Normal)
        privateLatter.backgroundColor = kCommonColor
        addSubview(privateLatter)
        privateLatter.snp.makeConstraints { (make) in
            make.left.equalTo(lineV.snp.right)
            make.width.equalTo(follow)
            make.top.equalTo(privateLatter.superview!)
            make.bottom.equalTo(privateLatter.superview!)
        }
    }
    
    func tapFollow(sender: UIButton) {
        if delegate != nil {
            delegate.toolViewTapFollow(sender)
        }
    }
    
    func tapPrivateLatter(sender: UIButton) {
        if delegate != nil {
            delegate.toolViewTapPrivateLatter(sender)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
