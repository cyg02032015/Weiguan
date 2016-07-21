//
//  MessageCell.swift
//  OutLookers
//
//  Created by C on 16/7/2.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    var badgeButton: UIButton!
    var imgView: UIImageView!
    var label: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        imgView = UIImageView()
        imgView.contentMode = .ScaleAspectFit
        contentView.addSubview(imgView)
        
        imgView.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.superview!).offset(kScale(15))
            make.centerY.equalTo(imgView.superview!)
            make.size.equalTo(kSize(20, height: 20))
        }
        
        label = UILabel()
        label.font = UIFont.customFontOfSize(14)
        contentView.addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.snp.right).offset(kScale(10))
            make.centerY.equalTo(imgView)
        }
        
        let arrow = UIImageView(image: UIImage(named: "open"))
        contentView.addSubview(arrow)
        
        arrow.snp.makeConstraints { (make) in
            make.right.equalTo(arrow.superview!).offset(kScale(-15))
            make.size.equalTo(kSize(8, height: 15))
            make.centerY.equalTo(imgView)
        }
        
        badgeButton = UIButton()
        contentView.addSubview(badgeButton)
        
        badgeButton.snp.makeConstraints { (make) in
            make.right.equalTo(arrow.snp.left).offset(kScale(-10))
            make.size.equalTo(kSize(24, height: 16))
            make.centerY.equalTo(imgView)
        }
        layoutIfNeeded()
        badgeButton.badgeValue = "99"
        badgeButton.badgeOriginX = 0
        badgeButton.badgeOriginY = -3
        
    }
    
    func setImgAndText(imgName: String, text: String) {
        imgView.image = UIImage(named: imgName)
        label.text = text
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
