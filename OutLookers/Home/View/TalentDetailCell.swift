//
//  TalentDetailCell.swift
//  OutLookers
//
//  Created by C on 16/7/14.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class TalentDetailCell: UITableViewCell {
    
    
    var info: TalentDtailResp! {
        didSet {
            jobLabel.text = info.name
            moneyLabel.text = "\(info.price)" + Util.unit(info.unit)
            styleLabel.text = info.details
            // TODO
            dateLabel.text = CPDateUtil.dateToString(CPDateUtil.stringToDate(info.createTime), dateFormat: "MM-dd HH:mm")
            imgView.yy_setImageWithURL(info.worksCover.addImagePath(CGSize(width: ScreenWidth, height: kScale(285))), placeholder: kPlaceholder)
            label.text = info.details
        }
    }
    var jobLabel: UILabel!      // 时装模特
    var moneyLabel: UILabel!
    var styleLabel: UILabel!    // 风格特征
    var dateLabel: UILabel!
    var label: UILabel!         // 我是小包子，我为自己代言
    var imgView: UIImageView!
    
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
        descLabel.text = "才艺详情"
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
        
        let lineV = UIView()
        lineV.backgroundColor = kLineColor
        contentView.addSubview(lineV)
        lineV.snp.makeConstraints { (make) in
            make.left.right.equalTo(lineV.superview!)
            make.top.equalTo(styleLabel.snp.bottom).offset(kScale(16))
            make.height.equalTo(0.5)
        }
        
        dateLabel = UILabel.createLabel(16, textColor: UIColor(hex: 0x434343))
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(styleLabel)
            make.top.equalTo(lineV.snp.bottom).offset(kScale(10))
            make.height.equalTo(kScale(19))
        }
        
        label = UILabel.createLabel(14, textColor: UIColor(hex: 0x434343))
        contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(dateLabel.snp.bottom).offset(kScale(7))
            make.left.equalTo(dateLabel)
            make.height.equalTo(kScale(14))
            make.right.equalTo(label.superview!).offset(kScale(-15))
        }
        
        imgView = UIImageView()
        contentView.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.left.right.equalTo(imgView.superview!)
            make.top.equalTo(label.snp.bottom).offset(kScale(7))
            make.bottom.equalTo(contentView)
        }
        
        let view2 = UIView()
        view2.backgroundColor = UIColor.grayColor()
        contentView.addSubview(view2)
        view2.snp.makeConstraints { (make) in
            make.left.right.equalTo(view2.superview!)
            make.top.equalTo(imgView.snp.bottom).offset(kScale(5.2))
            make.height.equalTo(kScale(548))
            make.bottom.lessThanOrEqualTo(view2.superview!)
        }
        // TODO
        label.text = ""
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
