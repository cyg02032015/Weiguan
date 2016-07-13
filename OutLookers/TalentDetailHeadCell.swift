//
//  TalentDetailHeadCell.swift
//  OutLookers
//
//  Created by C on 16/7/14.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class TalentDetailHeadCell: UITableViewCell {

    var headImgView: IconHeaderView!
    var nameLabel: UILabel!
    var button: UIButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        headImgView = IconHeaderView()
        contentView.addSubview(headImgView)
        headImgView.snp.makeConstraints { (make) in
            make.left.equalTo(headImgView.superview!).offset(kScale(15))
            make.centerY.equalTo(headImgView.superview!)
            make.size.equalTo(kSize(35, height: 35))
        }
        
        button = UIButton()
        button.setImage(UIImage(named: ""), forState: .Normal)
        contentView.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.right.equalTo(button.superview!).offset(kScale(-15))
            make.centerY.equalTo(button.superview!)
            make.size.equalTo(kSize(35, height: 35))
        }
        
        nameLabel = UILabel.createLabel(16)
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(headImgView)
            make.left.equalTo(headImgView.snp.right).offset(kScale(10))
            make.height.equalTo(kScale(16))
            make.right.equalTo(button.snp.left).offset(kScale(-10))
        }
        
        headImgView.backgroundColor = UIColor.yellowColor()
        button.backgroundColor = UIColor.redColor()
        nameLabel.text = "sdfsdfsd"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
