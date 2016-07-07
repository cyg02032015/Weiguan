//
//  DataTableViewCell.swift
//  OutLookers
//
//  Created by C on 16/7/7.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        let lineImgView1 = UIImageView(image: UIImage(named: "home_lead"))
        contentView.addSubview(lineImgView1)
        lineImgView1.snp.makeConstraints { (make) in
            make.top.equalTo(lineImgView1.superview!).offset(kScale(16))
            make.left.equalTo(lineImgView1.superview!).offset(kScale(15))
            make.size.equalTo(kSize(4, height: 15))
        }
        
        let basicDataLabel = UILabel()
        basicDataLabel.font = UIFont.customFontOfSize(16)
        contentView.addSubview(basicDataLabel)
        basicDataLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(lineImgView1)
            make.left.equalTo(lineImgView1.snp.right).offset(kScale(5))
            make.height.equalTo(kScale(16))
        }
        
        let editBtn1 = UIButton()
        editBtn1.setImage(UIImage(named: "Fill"), forState: .Normal)
        contentView.addSubview(editBtn1)
        editBtn1.snp.makeConstraints { (make) in
            make.centerY.equalTo(basicDataLabel)
            make.right.equalTo(editBtn1.superview!).offset(kScale(-15))
            make.size.equalTo(kSize(15, height: 17))
        }
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
