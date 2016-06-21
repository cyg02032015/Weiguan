//
//  SkillCell.swift
//  OutLookers
//
//  Created by Youngkook on 16/6/20.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//  SelectSkillViewController 里的cell

import UIKit

class SkillCell: UICollectionViewCell {
    
    var skill: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }

    
    func setupSubViews() {
        skill = UIButton()
        skill.setTitle("商业演出", forState: .Normal)
        skill.backgroundColor = UIColor(hex: 0xC8C8C8)
        skill.layer.cornerRadius = kSizeScale(24) / 2
        skill.titleLabel?.font = UIFont.systemFontOfSize(14)
        skill.userInteractionEnabled = false
        contentView.addSubview(skill)
        
        skill.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(skill.superview!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
