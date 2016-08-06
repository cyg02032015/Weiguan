//
//  PersonStyleCell.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/15.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//  个人档案-个人特征Cell

import UIKit

class PersonStyleCell: UITableViewCell {
    
    var style: UILabel!             // 风格
    var appearance: UILabel!        // 外貌
    var shape: UILabel!             // 体型
    var charm: UILabel!             // 魅力
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        style = UILabel.createLabel(16)
        contentView.addSubview(style)
        style.snp.makeConstraints { (make) in
            make.left.equalTo(style.superview!).offset(kScale(15))
            make.top.equalTo(style.superview!).offset(kScale(15))
            make.height.equalTo(kScale(16))
            make.right.equalTo(style.superview!).offset(kScale(-15))
        }
        
        appearance = UILabel.createLabel(16)
        contentView.addSubview(appearance)
        appearance.snp.makeConstraints { (make) in
            make.left.equalTo(style)
            make.top.equalTo(style.snp.bottom).offset(kScale(10))
            make.height.equalTo(style)
            make.right.equalTo(style)
        }
        
        shape = UILabel.createLabel(16)
        contentView.addSubview(shape)
        shape.snp.makeConstraints { (make) in
            make.left.equalTo(appearance)
            make.top.equalTo(appearance.snp.bottom).offset(kScale(10))
            make.height.equalTo(appearance)
            make.right.equalTo(appearance)
        }
        
        charm = UILabel.createLabel(16)
        contentView.addSubview(charm)
        charm.snp.makeConstraints { (make) in
            make.left.equalTo(shape)
            make.top.equalTo(shape.snp.bottom).offset(kScale(10))
            make.height.equalTo(shape)
            make.right.equalTo(shape)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
