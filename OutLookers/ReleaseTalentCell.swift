//
//  ReleaseTalentCell.swift
//  OutLookers
//
//  Created by C on 16/7/11.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class ReleaseTalentCell: UITableViewCell {

    var headImgView: IconHeaderView!
    var nameLabel: UILabel!
    var timeLabel: UILabel!
    var bigImgView: UIImageView!
    var subjectLabel: UILabel! // 主题
    var talentLabel: UILabel! // 招募
    var moneyLabel: UILabel!
    var releaseLabel: UILabel! // 发布了通告
    
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
        
        nameLabel = UILabel.createLabel(16)
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.superview!).offset(kScale(15))
            make.left.equalTo(headImgView.snp.right).offset(kScale(10))
            make.height.equalTo(kScale(16))
        }
        
        releaseLabel = UILabel.createLabel(14, textColor: UIColor(hex: 0xc0c0c0))
        contentView.addSubview(releaseLabel)
        releaseLabel.snp.makeConstraints { (make) in
            make.top.equalTo(releaseLabel.superview!).offset(kScale(22))
            make.left.equalTo(nameLabel.snp.right).offset(kScale(20))
            make.height.equalTo(14)
            make.right.lessThanOrEqualTo(releaseLabel.superview!).offset(kScale(-15))
        }
        
        let timeImgView = UIImageView(image: UIImage(named: "time"))
        contentView.addSubview(timeImgView)
        timeImgView.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(kScale(4))
            make.left.equalTo(headImgView.snp.right).offset(kScale(10))
            make.size.equalTo(kSize(10, height: 10))
        }
        
        timeLabel = UILabel.createLabel(12, textColor: UIColor(hex: 0xc8c8c8))
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(timeImgView)
            make.left.equalTo(timeImgView.snp.right).offset(kScale(4))
            make.height.equalTo(kScale(12))
        }
        
        bigImgView = UIImageView()
        contentView.addSubview(bigImgView)
        bigImgView.snp.makeConstraints { (make) in
            make.top.equalTo(headImgView.snp.bottom).offset(kScale(8))
            make.left.right.equalTo(bigImgView.superview!)
            make.height.equalTo(kScale(210))
            
        }
        
        subjectLabel = UILabel.createLabel(16)
        contentView.addSubview(subjectLabel)
        subjectLabel.snp.makeConstraints { (make) in
            make.top.equalTo(bigImgView.snp.bottom).offset(kScale(10))
            make.left.equalTo(subjectLabel.superview!).offset(kScale(15))
            make.right.equalTo(subjectLabel.superview!).offset(kScale(-15))
            make.height.equalTo(kScale(16))
        }
        
        talentLabel = UILabel.createLabel(12, textColor: UIColor(hex: 0x666666))
        talentLabel.backgroundColor = UIColor(hex: 0xd8d8d8)
        talentLabel.layer.cornerRadius = kScale(5)
        talentLabel.clipsToBounds = true
        contentView.addSubview(talentLabel)
        talentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(subjectLabel)
            make.height.equalTo(kScale(20))
            make.top.equalTo(subjectLabel.snp.bottom).offset(kScale(7))
        }
        
        moneyLabel = UILabel.createLabel(12, textColor: UIColor(hex: 0x666666))
        contentView.addSubview(moneyLabel)
        moneyLabel.snp.makeConstraints { (make) in
            make.height.equalTo(kScale(12))
            make.centerY.equalTo(talentLabel)
            make.left.equalTo(talentLabel.snp.right).offset(kScale(9))
        }
        
        headImgView.backgroundColor = UIColor.yellowColor()
        timeImgView.backgroundColor = UIColor.redColor()
        nameLabel.text = "阿里星球"
        timeLabel.text = "16:02"
        bigImgView.backgroundColor = UIColor.grayColor()
        subjectLabel.text = "开场演出唱歌表演"
        talentLabel.text = "商业演出"
        moneyLabel.text = "2000元／场"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
