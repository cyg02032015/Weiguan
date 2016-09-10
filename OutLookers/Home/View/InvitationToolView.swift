//
//  InvitationToolView.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/22.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import Device

class InvitationToolView: UIView {

    var money: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    
    func setupSubViews() {
        let button = UIButton()
        button.backgroundColor = kCommonColor
        button.setTitle("立即邀约", forState: .Normal)
        button.titleLabel!.font = UIFont.customNumFontOfSize(16)
        addSubview(button)
        button.snp.makeConstraints { (make) in
            make.top.bottom.right.equalTo(button.superview!)
            make.width.equalTo(Device.isSmallerThanScreenSize(.Screen4_7Inch) ? kScale(100) : kScale(150))
        }
        
        let label = UILabel()
        label.font = UIFont.customNumFontOfSize(16)
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(label.superview!).offset(kScale(15))
            make.centerY.equalTo(label.superview!)
        }
        
        money = UILabel()
        money.font = UIFont(name: "Helvetica-Bold", size: 16)
        money.textColor = UIColor(hex: 0xFF4E4E)
        addSubview(money)
        money.snp.makeConstraints { (make) in
            make.left.equalTo(label.snp.right)
            make.centerY.equalTo(label)
            make.right.lessThanOrEqualTo(button.snp.left).offset(kScale(-10))
        }
        
        label.text = "合计金额："
        money.text = "0元"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
