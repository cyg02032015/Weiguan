//
//  MyCommentCell.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/20.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class MyCommentCell: UITableViewCell {

    var imgView: UIImageView!
    var nameLabel: UILabel!
    var timeLabel: UILabel!
    var ratingView: HCSStarRatingView!
    var content: UILabel!
    var atName: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        imgView = UIImageView()
        contentView.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.superview!).offset(kScale(16))
            make.top.equalTo(imgView.superview!).offset(kScale(16))
            make.size.equalTo(kSize(36, height: 36))
        }
        
        nameLabel = UILabel.createLabel(14)
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.snp.right).offset(kScale(10))
            make.top.equalTo(nameLabel.superview!).offset(kScale(18))
            make.height.equalTo(kScale(14))
        }
        
        timeLabel = UILabel.createLabel(14, textColor: UIColor(hex: 0xc0c0c0c))
        timeLabel.textAlignment = .Right
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(timeLabel.superview!).offset(kScale(-15))
            make.top.equalTo(timeLabel.superview!).offset(kScale(15))
            make.height.equalTo(kScale(14))
        }
        
        ratingView = HCSStarRatingView()
        ratingView.allowsHalfStars = true
        ratingView.halfStarImage = UIImage(named: "Star 1 Copy 13")
        ratingView.emptyStarImage = UIImage(named: "Star 1 Copy 14")
        ratingView.filledStarImage = UIImage(named: "Star 1 Copy 10")
        contentView.addSubview(ratingView)
        ratingView.snp.makeConstraints { (make) in
            make.size.equalTo(kSize(68, height: 12))
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(kScale(6))
        }
        
        content = UILabel.createLabel(14, textColor: UIColor(hex: 0x666666))
        content.numberOfLines = 0
        contentView.addSubview(content)
        content.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.right.equalTo(timeLabel)
            make.top.equalTo(ratingView.snp.bottom).offset(kScale(12))
        }
        
        atName = UILabel.createLabel(14, textColor: UIColor(hex: 0x999999))
        contentView.addSubview(atName)
        atName.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.top.equalTo(content.snp.bottom).offset(kScale(20))
            make.height.equalTo(kScale(14))
            make.bottom.lessThanOrEqualTo(atName.superview!).offset(kScale(-10))
        }
        
        let lineV = UIView()
        lineV.backgroundColor = kLineColor
        contentView.addSubview(lineV)
        lineV.snp.makeConstraints { (make) in
            make.left.equalTo(kScale(16))
            make.right.bottom.equalTo(lineV.superview!)
            make.height.equalTo(1)
        }
        
        imgView.backgroundColor = UIColor.yellowColor()
        nameLabel.text = "客户昵称"
        timeLabel.text = "2016.07.13"
        ratingView.value = 3.5
        content.text = "真不错，以后继续合作真不错，以后继续合作真不错，以后继续合作真不错，以后继续合作真不错，以后继续合作"
        atName.text = "@才艺名称"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
