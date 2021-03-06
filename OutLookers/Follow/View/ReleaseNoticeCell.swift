//
//  ReleaseNoticeCell.swift
//  OutLookers
//
//  Created by C on 16/7/11.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//  关注-发布了通告

import UIKit

class ReleaseNoticeCell: UITableViewCell {

    var headImgView: IconHeaderView!
    var nameLabel: UILabel!
    var timeLabel: UILabel!
    var bigImgView: UIImageView!
    var subjectLabel: UILabel! // 主题
    var recruitLabel: UILabel! // 招募
    var timeAddress: UILabel!
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
        
        recruitLabel = UILabel.createLabel(12, textColor: UIColor(hex: 0x666666))
        contentView.addSubview(recruitLabel)
        recruitLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(subjectLabel)
            make.height.equalTo(kScale(12))
            make.top.equalTo(subjectLabel.snp.bottom).offset(kScale(7))
        }
        
        timeAddress = UILabel.createLabel(12, textColor: UIColor(hex: 0x666666))
        contentView.addSubview(timeAddress)
        timeAddress.snp.makeConstraints { (make) in
            make.left.right.equalTo(subjectLabel)
            make.height.equalTo(kScale(12))
            make.top.equalTo(recruitLabel.snp.bottom).offset(kScale(7))
        }
        
        headImgView.backgroundColor = UIColor.yellowColor()
        nameLabel.text = "阿里星球"
        timeLabel.text = "16:02"
        bigImgView.backgroundColor = UIColor.grayColor()
        subjectLabel.text = "招募主题招募主题招募主题招募主题招募主题"
        recruitLabel.text = "招募:唱歌／模特"
        timeAddress.text = "6月19日-6月26日  北京|西城区|蓝色港湾中央广场"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
