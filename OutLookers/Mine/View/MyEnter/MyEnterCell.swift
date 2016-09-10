//
//  MyEnterCell.swift
//  OutLookers
//
//  Created by C on 16/7/18.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class MyEnterCell: UITableViewCell {

    var imgView: UIImageView!
    var subjectLabel: UILabel!  // 通告主题
    var enterType: UILabel!     // 报名的类型
    var sponsor: UILabel!       // 发起人
    var timeLabel: UILabel!
    var statusLabel: UILabel!
    
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
            make.centerY.equalTo(imgView.superview!)
            make.size.equalTo(kSize(72, height: 72))
        }
        
        timeLabel = UILabel.createLabel(12, textColor: UIColor(hex: 0xc0c0c0))
        timeLabel.textAlignment = .Right
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(timeLabel.superview!).offset(kScale(-15))
            make.height.equalTo(kScale(12))
            make.top.equalTo(timeLabel.superview!).offset(kScale(17))
        }
        
        subjectLabel = UILabel()
        subjectLabel.font = UIFont.customNumFontOfSize(16)
        contentView.addSubview(subjectLabel)
        subjectLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.snp.right).offset(kScale(8))
            make.top.equalTo(subjectLabel.superview!).offset(kScale(20))
            make.height.equalTo(kScale(16))
            make.right.equalTo(timeLabel.snp.left).offset(kScale(-15))
        }
        
        enterType = UILabel.createLabel(14, textColor: UIColor(hex: 0x666666))
        contentView.addSubview(enterType)
        enterType.snp.makeConstraints { (make) in
            make.left.equalTo(subjectLabel)
            make.top.equalTo(subjectLabel.snp.bottom).offset(kScale(12))
            make.height.equalTo(kScale(14))
        }
        
        sponsor = UILabel.createLabel(14, textColor: UIColor(hex: 0x666666))
        contentView.addSubview(sponsor)
        sponsor.snp.makeConstraints { (make) in
            make.left.equalTo(subjectLabel)
            make.top.equalTo(enterType.snp.bottom).offset(kScale(12))
            make.height.equalTo(kScale(14))
        }
        
        statusLabel = UILabel.createLabel(14, textColor: UIColor(hex: 0x555555))
        statusLabel.textAlignment = .Right
        contentView.addSubview(statusLabel)
        statusLabel.snp.makeConstraints { (make) in
            make.right.equalTo(statusLabel.superview!).offset(kScale(-15))
            make.height.equalTo(kScale(14))
            make.centerY.equalTo(sponsor)
        }
        
        let lineV = UIView()
        lineV.backgroundColor = kLineColor
        contentView.addSubview(lineV)
        lineV.snp.makeConstraints { (make) in
            make.left.equalTo(imgView)
            make.bottom.right.equalTo(lineV.superview!)
            make.height.equalTo(1)
        }
        
        imgView.backgroundColor = UIColor.yellowColor()
        subjectLabel.text = "通告主题"
        timeLabel.text = "2016-05-30"
        enterType.text = "报名的类型"
        sponsor.text = "发起人"
        statusLabel.text = "【不合适】"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
