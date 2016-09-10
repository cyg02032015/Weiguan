//
//  MessageSectionCell.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/21.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class MessageSectionCell: UITableViewCell {

    var imgView: IconHeaderView!
    var nameLabel: UILabel!
    var desc: UILabel!
    var time: UILabel!
    var badgeButton: UIButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        imgView = IconHeaderView()
        contentView.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.superview!).offset(kScale(15))
            make.centerY.equalTo(imgView.superview!)
            make.size.equalTo(kSize(40, height: 40))
        }
        
        nameLabel = UILabel()
        nameLabel.font = UIFont(name: "STHeitiSC-Medium", size: 16)
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.snp.right).offset(kScale(15))
            make.top.equalTo(nameLabel.superview!).offset(kScale(17))
            make.height.equalTo(kScale(16))
        }
        
        time = UILabel.createLabel(14, textColor: UIColor(hex: 0x777777))
        time.textAlignment = .Right
        contentView.addSubview(time)
        time.snp.makeConstraints { (make) in
            make.top.equalTo(time.superview!).offset(kScale(16))
            make.right.equalTo(time.superview!).offset(kScale(-15))
            make.height.equalTo(kScale(14))
        }
        
        badgeButton = UIButton()
        contentView.addSubview(badgeButton)
        badgeButton.snp.makeConstraints { (make) in
            make.right.equalTo(badgeButton.superview!).offset(kScale(-20))
            make.size.equalTo(kSize(16, height: 16))
            make.bottom.equalTo(badgeButton.superview!).offset(kScale(-13))
        }
        
        desc = UILabel.createLabel(14, textColor: UIColor(hex: 0x666666))
        contentView.addSubview(desc)
        desc.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(kScale(10))
            make.height.equalTo(kScale(14))
            make.right.equalTo(badgeButton.snp.left).offset(kScale(-5))
        }
        
        layoutIfNeeded()
        badgeButton.badgeValue = "99"
        badgeButton.badgeOriginX = 0
        badgeButton.badgeOriginY = -3
        imgView.backgroundColor = UIColor.yellowColor()
        nameLabel.text = "围观小秘书"
        desc.text = "你的摄影师拍的很好啊！"
        time.text = "10:27"
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
