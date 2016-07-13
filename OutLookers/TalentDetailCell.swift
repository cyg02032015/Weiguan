//
//  TalentDetailCell.swift
//  OutLookers
//
//  Created by C on 16/7/14.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class TalentDetailCell: UITableViewCell {

    var jobLabel: UILabel!      // 时装模特
    var moneyLabel: UILabel!
    var styleLabel: UILabel!    // 风格特征
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        let view = UIView()
        view.backgroundColor = UIColor.blackColor()
        contentView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(view.superview!)
            make.height.equalTo(kScale(50))
        }
        
        jobLabel = UILabel.createLabel(16, textColor: UIColor.whiteColor())
        view.addSubview(jobLabel)
        jobLabel.snp.makeConstraints { (make) in
            make.left.equalTo(jobLabel.superview!).offset(kScale(16))
            make.centerY.equalTo(jobLabel.superview!)
            make.height.equalTo(kScale(16))
        }
        
        moneyLabel = UILabel.createLabel(14, textColor: UIColor.whiteColor())
        moneyLabel.layer.borderColor = UIColor.whiteColor().CGColor
        moneyLabel.layer.borderWidth = 1
        moneyLabel.layer.cornerRadius = kScale(5)
        moneyLabel.textAlignment = .Center
        view.addSubview(moneyLabel)
        moneyLabel.snp.makeConstraints { (make) in
            make.right.equalTo(moneyLabel.superview!).offset(kScale(-15))
            make.size.equalTo(kSize(80, height: 24))
            make.centerY.equalTo(moneyLabel.superview!)
        }
        
        let descLabel = UILabel.createLabel(16, textColor: UIColor(hex: 0x434343))
        descLabel.text = "相关介绍"
        descLabel.textAlignment = .Center
        contentView.addSubview(descLabel)
        descLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.bottom).offset(kScale(10))
            make.centerX.equalTo(descLabel.superview!)
            make.height.equalTo(kScale(16))
        }
        
        let leftLine = UIView()
        leftLine.backgroundColor = UIColor(hex: 0x434343)
        contentView.addSubview(leftLine)
        leftLine.snp.makeConstraints { (make) in
            make.left.equalTo(leftLine.superview!).offset(kScale(15))
            make.height.equalTo(1)
            make.right.equalTo(descLabel.snp.left).offset(kScale(-11))
            make.centerY.equalTo(descLabel)
        }
        
        let rightLine = UIView()
        rightLine.backgroundColor = UIColor(hex: 0x434343)
        contentView.addSubview(rightLine)
        rightLine.snp.makeConstraints { (make) in
            make.left.equalTo(descLabel.snp.right).offset(kScale(10))
            make.height.equalTo(1)
            make.right.equalTo(rightLine.superview!).offset(kScale(-15))
            make.centerY.equalTo(descLabel)
        }
        
        styleLabel = UILabel.createLabel(14)
        styleLabel.numberOfLines = 0
        contentView.addSubview(styleLabel)
        styleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(styleLabel.superview!).offset(kScale(15))
            make.right.equalTo(styleLabel.superview!).offset(kScale(-15))
            make.top.equalTo(descLabel.snp.bottom).offset(kScale(10))
        }
        
        let view1 = UIView()
        view1.backgroundColor = UIColor.yellowColor()
        contentView.addSubview(view1)
        view1.snp.makeConstraints { (make) in
            make.left.right.equalTo(view1.superview!)
            make.top.equalTo(styleLabel.snp.bottom).offset(kScale(7))
            make.height.equalTo(kScale(285))
        }
        
        let view2 = UIView()
        view2.backgroundColor = UIColor.grayColor()
        contentView.addSubview(view2)
        view2.snp.makeConstraints { (make) in
            make.left.right.equalTo(view2.superview!)
            make.top.equalTo(view1.snp.bottom).offset(kScale(5.2))
            make.height.equalTo(kScale(548))
            make.bottom.lessThanOrEqualTo(view2.superview!)
        }
        
        jobLabel.text = "时装模特"
        moneyLabel.text = "1000元/天"
        styleLabel.text = "风格特征：欧美 日韩 街头 性感 中国风欧美 日韩 街头 性感 中国风欧美 日韩 街头 性感 中国风欧美 日韩 街头 性感 中国风欧美 日韩 街头 性感 "
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
