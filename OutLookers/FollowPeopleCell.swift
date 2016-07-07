//
//  FollowPeopleCell.swift
//  OutLookers
//
//  Created by C on 16/6/30.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class FollowPeopleCell: UITableViewCell {

    var header: IconHeaderView!
    var nameLabel: UILabel!
    var plusImageView: UIImageView!
    var followLabel: UILabel!
    var followContainer: UIView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        
        header = IconHeaderView()
        header.layer.cornerRadius = kScale(50/2)
        header.clipsToBounds = true
        contentView.addSubview(header)
        
        nameLabel = UILabel()
        nameLabel.font = UIFont.customFontOfSize(16)
        contentView.addSubview(nameLabel)
        
        followContainer = UIView()
        followContainer.layer.cornerRadius = kScale(24/2)
        followContainer.layer.borderColor = kCommonColor.CGColor
        followContainer.layer.borderWidth = 1
        contentView.addSubview(followContainer)
        
        plusImageView = UIImageView()
        followContainer.addSubview(plusImageView)
        
        followLabel = UILabel()
        followLabel.font = UIFont.customFontOfSize(12)
        followLabel.textColor = kCommonColor
        followContainer.addSubview(followLabel)
        
        nameLabel.text = "我的关注"
        plusImageView.backgroundColor = UIColor.yellowColor()
        followLabel.text = "关注"
        
        header.snp.makeConstraints { (make) in
            make.left.equalTo(header.superview!).offset(kScale(15))
            make.centerY.equalTo(header.superview!)
            make.size.equalTo(kSize(50, height: 50))
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(header.snp.right).offset(kScale(15))
            make.centerY.equalTo(nameLabel.superview!)
        }
        
        followContainer.snp.makeConstraints { (make) in
            make.right.equalTo(followContainer.superview!).offset(kScale(-15))
            make.centerY.equalTo(followContainer.superview!)
            make.size.equalTo(kSize(60, height: 24))
        }
        
        plusImageView.snp.makeConstraints { (make) in
            make.size.equalTo(kSize(12, height: 12))
            make.centerY.equalTo(plusImageView.superview!)
            make.left.equalTo(plusImageView.superview!).offset(kScale(9))
        }
        
        followLabel.snp.makeConstraints { (make) in
            make.left.equalTo(plusImageView.snp.right).offset(kScale(5))
            make.centerY.equalTo(followLabel.superview!)
            make.right.equalTo(followLabel.superview!).offset(kScale(-5))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
