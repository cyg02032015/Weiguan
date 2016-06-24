//
//  ShareCollectionCell.swift
//  OutLookers
//
//  Created by Youngkook on 16/6/24.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class ShareCollectionCell: UICollectionViewCell {
    
    var shareButton: UIButton!
    var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    func setDataWithShare(selectImage: UIImage, unSelectImage: UIImage, title: String) {
        shareButton.setImage(selectImage, forState: .Selected)
        shareButton.setImage(unSelectImage, forState: .Normal)
        label.text = title
    }
    
    
    func setupSubViews() {
        shareButton = UIButton()
        shareButton.userInteractionEnabled = false
        contentView.addSubview(shareButton)
        
        label = UILabel()
        label.textAlignment = .Center
        label.font = UIFont.systemFontOfSize(10)
        label.textColor = UIColor(hex: 0x777777)
        contentView.addSubview(label)
        
        shareButton.snp.makeConstraints { (make) in
            make.top.equalTo(shareButton.superview!).offset(18)
            make.centerX.equalTo(shareButton.superview!)
            make.size.equalTo(CGSize(width: 25, height: 25))
        }
        
        label.snp.makeConstraints { (make) in
            make.left.right.equalTo(label.superview!)
            make.top.equalTo(shareButton.snp.bottom).offset(3)
            make.height.equalTo(10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
