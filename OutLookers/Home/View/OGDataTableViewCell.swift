//
//  OGDataTableViewCell.swift
//  OutLookers
//
//  Created by C on 16/7/9.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class OGDataTableViewCell: UITableViewCell {

    var leftLabel: UILabel!
    var rightLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        
        leftLabel = UILabel()
        leftLabel.font = UIFont.customFontOfSize(16)
        leftLabel.textColor = UIColor(hex: 0x777777)
        contentView.addSubview(leftLabel)
        leftLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(leftLabel.superview!)
            make.left.equalTo(leftLabel.superview!).offset(kScale(15))
            make.height.equalTo(kScale(16))
            make.width.equalTo(kScale(65))
        }
        
        rightLabel = UILabel()
        rightLabel.font = UIFont.customFontOfSize(14)
        contentView.addSubview(rightLabel)
        rightLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(leftLabel)
            make.left.equalTo(leftLabel.snp.right).offset(kScale(50))
            make.height.equalTo(kScale(14))
        }
        
        let lineV = UIView()
        lineV.backgroundColor = kLineColor
        contentView.addSubview(lineV)
        lineV.snp.makeConstraints { (make) in
            make.left.equalTo(lineV.superview!).offset(kScale(15))
            make.right.equalTo(lineV.superview!).offset(kScale(-15))
            make.bottom.equalTo(lineV.superview!)
            make.height.equalTo(1)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
