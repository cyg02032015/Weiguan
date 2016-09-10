//
//  PHTaTableViewCell.swift
//  OutLookers
//
//  Created by C on 16/7/13.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//  Ta参与的cell

import UIKit

class PHTaTableViewCell: UITableViewCell {

    var imgView: UIImageView!
    var nameLabel: UILabel!
    var timeLabel: UILabel!
    var moneyLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        imgView = UIImageView()
        contentView.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.centerY.equalTo(imgView.superview!)
            make.left.equalTo(imgView.superview!).offset(kScale(15))
            make.size.equalTo(kSize(80, height: 80))
        }
        
        nameLabel = UILabel.createLabel(14, textColor: UIColor(hex: 0x393939))
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.superview!).offset(kScale(24))
            make.left.equalTo(imgView.snp.right).offset(kScale(10))
            make.height.equalTo(kScale(14))
        }
        
        timeLabel = UILabel.createLabel(12, textColor: UIColor(hex: 0x666666))
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(kScale(10))
            make.height.equalTo(kScale(12))
        }
        
        moneyLabel = UILabel.createLabel(12, textColor: UIColor(hex: 0x666666))
        contentView.addSubview(moneyLabel)
        moneyLabel.snp.makeConstraints { (make) in
            make.left.equalTo(timeLabel)
            make.top.equalTo(timeLabel.snp.bottom).offset(kScale(10))
            make.height.equalTo(kScale(12))
        }
        
        let lineV = UIView()
        lineV.backgroundColor = kLineColor
        contentView.addSubview(lineV)
        lineV.snp.makeConstraints { (make) in
            make.left.equalTo(lineV.superview!).offset(kScale(15))
            make.right.equalTo(lineV.superview!).offset(kScale(-15))
            make.height.equalTo(1)
            make.bottom.equalTo(lineV.superview!)
        }
        
        imgView.backgroundColor = UIColor.yellowColor()
        nameLabel.text = "罗曼·哈根布洛克现场影像表演"
        timeLabel.text = "2016.6.25－2016.7.10"
        moneyLabel.text = "2000元"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
