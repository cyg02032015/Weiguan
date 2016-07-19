//
//  TransactionCell.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/19.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class TransactionCell: UITableViewCell {

    var week: UILabel!
    var day: UILabel!
    var headImgView: IconHeaderView!
    var money: UILabel!
    var status: UILabel! // 退款成功
    var desc: UILabel!   // 收款方
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        week = UILabel.createLabel(14, textColor: UIColor(hex: 0xc8c8c8))
        week.textAlignment = .Center
        contentView.addSubview(week)
        week.snp.makeConstraints { (make) in
            make.left.equalTo(week.superview!)
            make.top.equalTo(week.superview!).offset(kScale(17))
            make.size.equalTo(kSize(58, height: 14))
        }
        
        day = UILabel.createLabel(12, textColor: UIColor(hex: 0xc8c8c8))
        day.textAlignment = .Center
        contentView.addSubview(day)
        day.snp.makeConstraints { (make) in
            make.left.equalTo(week)
            make.top.equalTo(week.snp.bottom).offset(kScale(5))
            make.size.equalTo(week)
        }
        
        headImgView = IconHeaderView()
        contentView.addSubview(headImgView)
        headImgView.snp.makeConstraints { (make) in
            make.left.equalTo(week.snp.right).offset(kScale(8))
            make.centerY.equalTo(headImgView.superview!)
            make.size.equalTo(kSize(40, height: 40))
        }
        
        money = UILabel()
        money.font = UIFont.customNumFontOfSize(16)
        contentView.addSubview(money)
        money.snp.makeConstraints { (make) in
            make.left.equalTo(headImgView.snp.right).offset(kScale(16))
            make.top.equalTo(money.superview!).offset(kScale(17))
            make.height.equalTo(kScale(16))
        }
        
        desc = UILabel.createLabel(14, textColor: UIColor(hex: 0x666666))
        contentView.addSubview(desc)
        desc.snp.makeConstraints { (make) in
            make.left.equalTo(money)
            make.top.equalTo(money.snp.bottom).offset(kScale(5))
            make.height.equalTo(kScale(14))
        }
        
        status = UILabel.createLabel(14)
        status.textAlignment = .Right
        contentView.addSubview(status)
        status.snp.makeConstraints { (make) in
            make.right.equalTo(status.superview!).offset(kScale(-15))
            make.top.equalTo(status.superview!).offset(kScale(18))
            make.height.equalTo(kScale(14))
        }
        
        let lineV = UIView()
        lineV.backgroundColor = kLineColor
        contentView.addSubview(lineV)
        lineV.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(lineV.superview!)
            make.height.equalTo(1)
        }
        
        week.text = "今天"
        day.text = "12：00"
        headImgView.backgroundColor = UIColor.yellowColor()
        money.text = "3000"
        desc.text = "收款方"
        status.text = "退款成功"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
