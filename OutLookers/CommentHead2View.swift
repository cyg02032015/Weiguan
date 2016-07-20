//
//  CommentHead2View.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/20.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class CommentHead2View: UIView {
    
    var talent: UILabel!
    var talentScore: UILabel!
    var talentRating: HCSStarRatingView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    
    func setupSubViews() {
        backgroundColor = UIColor.whiteColor()
        
        let container = UIView()
        addSubview(container)
        container.snp.makeConstraints { (make) in
            make.centerX.equalTo(container.superview!)
            make.top.equalTo(kScale(36))
            make.width.equalTo(kScale(212))
            make.height.equalTo(kScale(19))
        }
        talent = UILabel.createLabel(16, textColor: UIColor(hex: 0x666666))
        container.addSubview(talent)
        talent.snp.makeConstraints { (make) in
            make.left.equalTo(talent.superview!)
            make.width.equalTo(kScale(65))
            make.top.equalTo(talent.superview!)
            make.height.equalTo(kScale(16))
        }
        
        talentRating = HCSStarRatingView()
        talentRating.allowsHalfStars = true
        talentRating.halfStarImage = UIImage(named: "Star 1 Copy 13")
        talentRating.emptyStarImage = UIImage(named: "Star 1 Copy 14")
        talentRating.filledStarImage = UIImage(named: "Star 1 Copy 10")
        addSubview(talentRating)
        talentRating.snp.makeConstraints { (make) in
            make.left.equalTo(talent.snp.right).offset(kScale(10))
            make.centerY.equalTo(talent)
            make.size.equalTo(kSize(94, height: 16))
        }
        
        talentScore = UILabel()
        talentScore.font = UIFont(name: "Helvetica", size: kScale(16))
        talentScore.textColor = kCommonColor
        addSubview(talentScore)
        talentScore.snp.makeConstraints { (make) in
            make.left.equalTo(talentRating.snp.right).offset(kScale(10))
            make.centerY.equalTo(talentRating)
            make.height.equalTo(kScale(16))
            make.right.lessThanOrEqualTo(talentScore.superview!).offset(kScale(-15))
        }
        
        talent.text = "才艺评分"
        talentRating.value = 3.3
        talentScore.text = "3.5"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}