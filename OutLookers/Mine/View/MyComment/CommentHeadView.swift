//
//  CommentHeadView.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/20.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import Device

class CommentHeadView: UIView {

    var rating: UILabel!
    var overallScore: UILabel!
    var talentScore: UILabel!
    var inviteScore: UILabel!
    var talentRating: HCSStarRatingView!
    var inviteRating: HCSStarRatingView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    
    func setupSubViews() {
        backgroundColor = UIColor.whiteColor()
        rating = UILabel()
        rating.font = UIFont(name: "Helvetica", size: kScale(24))
        rating.textAlignment = .Center
        rating.textColor = kCommonColor
        addSubview(rating)
        
        rating.snp.makeConstraints { (make) in
            make.left.equalTo(rating.superview!)
            make.width.equalTo(kScale(Device.isSmallerThanScreenSize(.Screen4_7Inch) ? 90 : 124))
            make.width.greaterThanOrEqualTo(kScale(90))
            make.top.equalTo(rating.superview!).offset(kScale(18))
            make.height.equalTo(kScale(29))
        }
        
        overallScore = UILabel.createLabel(16, textColor: UIColor(hex: 0x666666))
        overallScore.textAlignment = .Center
        addSubview(overallScore)
        overallScore.snp.makeConstraints { (make) in
            make.left.equalTo(rating)
            make.width.equalTo(rating)
            make.height.equalTo(kScale(16))
            make.top.equalTo(rating.snp.bottom).offset(kScale(6))
        }
        
        let line = UIView()
        line.backgroundColor = kLineColor
        addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.equalTo(rating.snp.right)
            make.size.equalTo(CGSize(width: 1, height: kScale(50)))
            make.centerY.equalTo(line.superview!)
        }
        
        let talent = UILabel.createLabel(14, textColor: UIColor(hex: 0x666666))
        addSubview(talent)
        talent.snp.makeConstraints { (make) in
            make.left.equalTo(line.snp.right).offset(kScale(20))
            make.width.equalTo(kScale(57))
            make.top.equalTo(talent.superview!).offset(kScale(26))
            make.height.equalTo(kScale(14))
        }
        
        let invite = UILabel.createLabel(14, textColor: UIColor(hex: 0x666666))
        addSubview(invite)
        invite.snp.makeConstraints { (make) in
            make.left.equalTo(talent)
            make.width.equalTo(talent)
            make.top.equalTo(talent.snp.bottom).offset(kScale(8))
            make.height.equalTo(talent)
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
        
        inviteRating = HCSStarRatingView()
        inviteRating.allowsHalfStars = true
        inviteRating.halfStarImage = UIImage(named: "Star 1 Copy 13")
        inviteRating.emptyStarImage = UIImage(named: "Star 1 Copy 14")
        inviteRating.filledStarImage = UIImage(named: "Star 1 Copy 10")
        addSubview(inviteRating)
        inviteRating.snp.makeConstraints { (make) in
            make.left.equalTo(talentRating)
            make.centerY.equalTo(invite)
            make.size.equalTo(talentRating)
        }
        
        talentScore = UILabel.createLabel(14, textColor: kCommonColor)
        addSubview(talentScore)
        talentScore.snp.makeConstraints { (make) in
            make.left.equalTo(talentRating.snp.right).offset(kScale(10))
            make.centerY.equalTo(talentRating)
            make.height.equalTo(kScale(14))
            make.right.lessThanOrEqualTo(talentScore.superview!).offset(kScale(-15))
        }
        
        inviteScore = UILabel.createLabel(14, textColor: kCommonColor)
        addSubview(inviteScore)
        inviteScore.snp.makeConstraints { (make) in
            make.left.equalTo(talentScore)
            make.centerY.equalTo(inviteRating)
            make.height.equalTo(kScale(14))
            make.right.lessThanOrEqualTo(inviteScore.superview!).offset(kScale(-15))
        }
        
        rating.text = "3.5"
        overallScore.text = "综合评分"
        talent.text = "才艺评分"
        invite.text = "邀约评分"
        talentRating.value = 3.3
        inviteRating.value = 4.6
        talentScore.text = "3.5"
        inviteScore.text = "4.6"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
