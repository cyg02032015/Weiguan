//
//  InvitedDetailTableViewCell.swift
//  OutLookers
//
//  Created by C on 16/8/29.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class InvitedDetailTableViewCell: UITableViewCell {

    var info: FindNoticeDetailResp! {
        didSet {
            details.text = info.details
        }
    }
    var details: UILabel!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        let label = UILabel()
        label.font = UIFont.customNumFontOfSize(16)
        label.text = "活动介绍"
        contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(label.superview!).offset(kScale(15))
            make.top.equalTo(label.superview!).offset(kScale(10))
            make.height.equalTo(kScale(16))
        }
        
        let line = UIView()
        line.backgroundColor = kLineColor
        contentView.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.equalTo(line.superview!).offset(kScale(15))
            make.right.equalTo(line.superview!).offset(kScale(-15))
            make.top.equalTo(label.snp.bottom).offset(kScale(10))
            make.height.equalTo(1)
        }
        
        details = UILabel.createLabel(14)
        details.numberOfLines = 0
        contentView.addSubview(details)
        details.snp.makeConstraints { (make) in
            make.left.equalTo(line)
            make.right.equalTo(line)
            make.top.equalTo(line.snp.bottom).offset(kScale(11))
            make.bottom.lessThanOrEqualTo(details.superview!).offset(kScale(-30))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
