//
//  RecommendHotmanCollectionCell.swift
//  OutLookers
//
//  Created by C on 16/7/3.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class RecommendHotmanCollectionCell: UICollectionViewCell {
    
    var info: HotmanList! {
        didSet {
//            imgView.sd_setImageWithURL(NSURL(string: info.headImgUrl), placeholderImage: UIImage(named: ""))
            nameLabel.text = info.name
            jobLabel.text = info.nickname
        }
    }
    var imgView: UIImageView!
    var nameLabel: UILabel!
    var jobLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    func setupSubViews() {
        imgView = UIImageView()
        imgView.layer.cornerRadius = 5
        imgView.clipsToBounds = true
        imgView.backgroundColor = UIColor.blackColor()
        contentView.addSubview(imgView)
        
        imgView.snp.makeConstraints { (make) in
            make.edges.equalTo(imgView.superview!)
        }
        
        nameLabel = UILabel()
        nameLabel.font = UIFont.customFontOfSize(16)
        nameLabel.textAlignment = .Center
        nameLabel.textColor = UIColor.whiteColor()
        imgView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.superview!).offset(kScale(152))
            make.left.right.equalTo(nameLabel.superview!)
            make.height.equalTo(kHeight(16))
        }
        
        jobLabel = UILabel()
        jobLabel.font = UIFont.customFontOfSize(14)
        jobLabel.textColor = UIColor.whiteColor()
        jobLabel.textAlignment = .Center
        imgView.addSubview(jobLabel)
        
        jobLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(kScale(8))
            make.left.right.equalTo(nameLabel)
            make.height.equalTo(kHeight(14))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
