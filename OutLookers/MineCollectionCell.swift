//
//  MineCollectionCell.swift
//  OutLookers
//
//  Created by C on 16/7/2.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class MineCollectionCell: UICollectionViewCell {
    
    var imgButton: UIButton!
    var label: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
        setupSubViews()
    }
    
    func setupSubViews() {
        imgButton = UIButton()
        imgButton.userInteractionEnabled = false
        contentView.addSubview(imgButton)
        
        imgButton.snp.makeConstraints { (make) in
            make.top.equalTo(imgButton.superview!).offset(kScale(25))
            make.size.equalTo(kSize(30, height: 30))
            make.centerX.equalTo(imgButton.superview!)
        }
        layoutIfNeeded()
        imgButton.badgeOriginX = imgButton.right - 10
        imgButton.badgeOriginY = imgButton.top - 30
        
        label = UILabel()
        label.font = UIFont.customFontOfSize(14)
        label.textAlignment = .Center
        contentView.addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.left.right.equalTo(label.superview!)
            make.top.equalTo(imgButton.snp.bottom).offset(kScale(10))
            make.height.equalTo(kScale(14))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
