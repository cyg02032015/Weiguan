//
//  PHToolView.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/7.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private extension Selector {
    static let tapFollow = #selector(PHToolView.tapFollow(_:))
    static let tapPrivateLatter = #selector(PHToolView.tapPrivateLatter(_:))
    //static let tapInvitation = #selector(PHToolView.tapInvitation(_:))
}

protocol PHToolViewDelegate: class {
    func toolViewTapFollow(sender: UIButton)
    func toolViewTapPrivateLatter(sender: UIButton)
    //func toolViewTapInvitation(sender: UIButton)
}

class PHToolView: UIView {

    weak var delegate: PHToolViewDelegate!
    var follow: UIButton!      // 关注
    var privateLatter: UIButton!  // 私信
//    var invitation: UIButton!     // 邀约
    
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
        
        privateLatter = UIButton()
        privateLatter.addTarget(self, action: .tapPrivateLatter, forControlEvents: .TouchUpInside)
        privateLatter.setTitle("私信", forState: .Normal)
        privateLatter.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        privateLatter.titleLabel?.font = UIFont.customFontOfSize(16)
        privateLatter.setImage(UIImage(named: "chat"), forState: .Normal)
        privateLatter.backgroundColor = kCommonColor
        addSubview(privateLatter)
        privateLatter.snp.makeConstraints { (make) in
            make.left.equalTo(follow.snp.right)
            make.width.equalTo(follow)
            make.top.equalTo(privateLatter.superview!)
            make.bottom.equalTo(privateLatter.superview!)
        }
        
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        addSubview(view)
        view.snp.makeConstraints { (make) in
            make.top.equalTo(view.superview!).offset(4)
            make.bottom.equalTo(view.superview!).offset(-4)
            make.width.equalTo(1)
            make.centerX.equalTo(view.superview!)
        }
//        
//        invitation = UIButton()
//        invitation.addTarget(self, action: .tapInvitation, forControlEvents: .TouchUpInside)
//        invitation.setTitle("邀约", forState: .Normal)
//        invitation.titleLabel?.font = UIFont.customFontOfSize(16)
//        invitation.setImage(UIImage(named: "invitation"), forState: .Normal)
//        invitation.backgroundColor = kCommonColor
//        addSubview(invitation)
//        invitation.snp.makeConstraints { (make) in
//            make.left.equalTo(privateLatter.snp.right)
//            make.width.equalTo(privateLatter)
//            make.top.bottom.equalTo(follow)
//        }
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
    
//    func tapInvitation(sender: UIButton) {
//        if delegate != nil {
//            delegate.toolViewTapInvitation(sender)
//        }
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
