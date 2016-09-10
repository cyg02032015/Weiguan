//
//  FriendCollectionCell.swift
//  OutLookers
//
//  Created by C on 16/7/31.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class FriendCollectionCell: UICollectionViewCell {
    
    var imgView: UIImageView!
    var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.whiteColor()
        setupSubViews()
    }
    
    func setupSubViews() {
        imgView = UIImageView()
        contentView.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.top.equalTo(imgView.superview!).offset(kScale(21))
            make.centerX.equalTo(imgView.superview!)
            make.size.equalTo(kSize(25, height: 25))
        }
        
        label = UILabel.createLabel(14, textColor: kGrayTextColor)
        label.textAlignment = .Center
        contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.right.equalTo(label.superview!)
            make.top.equalTo(imgView.snp.bottom).offset(kScale(9))
            make.height.equalTo(kScale(14))
        }
        
        imgView.backgroundColor = UIColor.yellowColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
