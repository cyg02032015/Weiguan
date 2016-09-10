//
//  MyAccountHeadCell.swift
//  OutLookers
//
//  Created by C on 16/7/18.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class MyAccountHeadCell: UITableViewCell {

    var money: UILabel!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        let imgView = UIImageView(image: UIImage(named: "Page 1"))
        contentView.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.centerX.equalTo(imgView.superview!)
            make.size.equalTo(kSize(82, height: 82))
            make.top.equalTo(imgView.superview!).offset(kScale(20))
        }
        
        let account = UILabel.createLabel(14, textColor: UIColor(hex: 0x666666))
        account.textAlignment = .Center
        contentView.addSubview(account)
        account.snp.makeConstraints { (make) in
            make.left.right.equalTo(account.superview!)
            make.top.equalTo(imgView.snp.bottom).offset(kScale(15))
            make.height.equalTo(kScale(14))
        }
        
        money = UILabel()
        money.font = UIFont.customMoneyFontOfSize(28)
        money.textAlignment = .Center
        contentView.addSubview(money)
        money.snp.makeConstraints { (make) in
            make.left.right.equalTo(money.superview!)
            make.height.equalTo(kScale(34))
            make.top.equalTo(account.snp.bottom).offset(kScale(4))
        }
        
        account.text = "余额账户"
        money.text = "￥30000"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
