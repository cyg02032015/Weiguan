//
//  DynamicDetailVideoCell.swift
//  OutLookers
//
//  Created by C on 16/7/17.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class DynamicDetailVideoCell: UITableViewCell {

    var headImgView: IconHeaderView!
    var nameLabel: UILabel!
    var timeLabel: UILabel!
    var bigImgView: UIImageView!
    var details: UILabel!
    var followButton: UIButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        headImgView = IconHeaderView()
        headImgView.customCornerRadius = kScale(35/2)
        contentView.addSubview(headImgView)
        headImgView.snp.makeConstraints { (make) in
            make.top.equalTo(headImgView.superview!).offset(kScale(10))
            make.left.equalTo(headImgView.superview!).offset(kScale(15))
            make.size.equalTo(kSize(35, height: 35))
        }
        
        nameLabel = UILabel()
        nameLabel.font = UIFont.customFontOfSize(16)
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.superview!).offset(kScale(15))
            make.left.equalTo(headImgView.snp.right).offset(kScale(10))
            make.height.equalTo(kScale(16))
        }
        
        let timeImgView = UIImageView(image: UIImage(named: "time"))
        contentView.addSubview(timeImgView)
        timeImgView.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(kScale(4))
            make.left.equalTo(headImgView.snp.right).offset(kScale(10))
            make.size.equalTo(kSize(10, height: 10))
        }
        
        timeLabel = UILabel()
        timeLabel.font = UIFont.customFontOfSize(12)
        timeLabel.textColor = UIColor(hex: 0xc8c8c8)
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(timeImgView)
            make.left.equalTo(timeImgView.snp.right).offset(kScale(4))
            make.height.equalTo(kScale(12))
        }
        
        followButton = UIButton()
        followButton.setImage(UIImage(named: ""), forState: .Normal)
        followButton.setTitle("关注", forState: .Normal)
        followButton.setTitleColor(kCommonColor, forState: .Normal)
        followButton.titleLabel!.font = UIFont.customFontOfSize(10)
        followButton.layer.cornerRadius = kScale(23/2)
        followButton.layer.borderColor = kCommonColor.CGColor
        followButton.layer.borderWidth = 1
        contentView.addSubview(followButton)
        followButton.snp.makeConstraints { (make) in
            make.right.equalTo(followButton.superview!).offset(kScale(-16))
            make.size.equalTo(kSize(48, height: 23))
            make.centerY.equalTo(headImgView)
        }
        
        bigImgView = UIImageView()
        contentView.addSubview(bigImgView)
        bigImgView.snp.makeConstraints { (make) in
            make.top.equalTo(headImgView.snp.bottom).offset(kScale(14))
            make.size.equalTo(CGSize(width: ScreenWidth, height: ScreenWidth))
            make.left.equalTo(bigImgView.superview!)
        }
        
        details = UILabel.createLabel(16, textColor: UIColor(hex: 0x666666))
        contentView.addSubview(details)
        details.snp.makeConstraints { (make) in
            make.top.equalTo(bigImgView.snp.bottom).offset(kScale(10))
            make.left.equalTo(headImgView)
            make.right.equalTo(details.superview!).offset(kScale(-15))
            make.height.equalTo(kScale(16))
        }
        
        bigImgView.backgroundColor = UIColor.greenColor()
        details.text = "sdfsdfs"
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
