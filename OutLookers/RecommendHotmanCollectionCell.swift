//
//  RecommendHotmanCollectionCell.swift
//  OutLookers
//
//  Created by C on 16/7/3.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class RecommendHotmanCollectionCell: UICollectionViewCell {
    
    var imgView: UIImageView!
    var nameLabel: UILabel!
    var jobLabel: UILabel!
    var leftLabel: UILabel!
    var rightLabel: UILabel!
    var leftText: NSString? {
        didSet {
            guard let text = leftText else { LogWarn(" leftlabel text is nil");return }
            leftLabel.text = text as String
            let size = text.sizeWithFonts(12, maxX: 60)
            leftLabel.snp.updateConstraints { (make) in
                make.width.equalTo(kScale(size.width + 8))
                make.height.equalTo(kHeight(12+6))
            }
        }
    }
    var rightText: NSString? {
        didSet {
            guard let text = rightText else { LogWarn(" rightlabel text is nil");return }
            rightLabel.text = text as String
            let size = text.sizeWithFonts(12 * scale, maxX: 60)
            rightLabel.snp.updateConstraints { (make) in
                make.width.equalTo(kScale(size.width + 8))
                make.height.equalTo(kHeight(12+6))
            }
        }
    }
    
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
            make.top.equalTo(nameLabel.superview!).offset(kScale(126))
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
        
        leftLabel = UILabel()
        leftLabel.textAlignment = .Center
        leftLabel.textColor = UIColor.whiteColor()
        leftLabel.font = UIFont.customFontOfSize(12)
        leftLabel.layer.borderColor = UIColor.whiteColor().CGColor
        leftLabel.layer.borderWidth = 1
        leftLabel.layer.cornerRadius = kScale(4)
        imgView.addSubview(leftLabel)
        
        leftLabel.snp.makeConstraints { (make) in
            make.left.lessThanOrEqualTo(leftLabel.superview!).offset(kScale(21))
            make.top.equalTo(jobLabel.snp.bottom).offset(kScale(8))
        }
        
        rightLabel = UILabel()
        rightLabel.textAlignment = .Center
        rightLabel.textColor = UIColor.whiteColor()
        rightLabel.font = UIFont.customFontOfSize(12)
        rightLabel.layer.borderColor = UIColor.whiteColor().CGColor
        rightLabel.layer.borderWidth = 1
        rightLabel.layer.cornerRadius = kScale(4)
        imgView.addSubview(rightLabel)
        
        rightLabel.snp.makeConstraints { (make) in
            make.left.equalTo(leftLabel.snp.right).offset(kScale(12))
            make.top.equalTo(leftLabel)
            make.right.lessThanOrEqualTo(rightLabel.superview!).offset(kScale(-21)) // greterthan
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
