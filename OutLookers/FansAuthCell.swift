//
//  FansAuthCell.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/20.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class FansAuthCell: UICollectionViewCell {
    
    var imgView: UIImageView!
    var selectButton: UIButton!
    var name: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    
    func setupSubViews() {
        imgView = UIImageView()
        imgView.layer.cornerRadius = kScale(72/2)
        contentView.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.size.equalTo(kSize(72, height: 72))
            make.centerX.equalTo(imgView.superview!)
            make.top.equalTo(imgView.superview!)
        }
        
        name = UILabel.createLabel(14, textColor: UIColor(hex: 0x666666))
        name.textAlignment = .Center
        contentView.addSubview(name)
        name.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(name.superview!)
            make.height.equalTo(kScale(14))
        }
        
        selectButton = UIButton()
        selectButton.setImage(UIImage(named: "chosen"), forState: .Normal)
        selectButton.setImage(UIImage(named: "normal copy 3"), forState: .Selected)
        selectButton.userInteractionEnabled = false
        contentView.addSubview(selectButton)
        selectButton.snp.makeConstraints { (make) in
            make.size.equalTo(kSize(24, height: 24))
            make.right.equalTo(imgView)
            make.top.equalTo(imgView)
        }
        
        imgView.backgroundColor = UIColor.yellowColor()
        name.text = "qwqeqe"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
