//
//  SkillTypeCell.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/29.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class SkillTypeCell: UITableViewCell {

    
    var label: UILabel!
    var skill: UIButton!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        label = UILabel()
        label.font = UIFont.customFontOfSize(16)
        contentView.addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.left.equalTo(label.superview!).offset(kScale(15))
            make.centerY.equalTo(label.superview!)
            make.height.equalTo(kScale(16))
        }
        
        skill = UIButton()
        skill.backgroundColor = kCommonColor
        skill.layer.cornerRadius = kScale(24/2)
        skill.titleLabel?.font = UIFont.customFontOfSize(14)
        skill.userInteractionEnabled = false
        contentView.addSubview(skill)
        
        skill.snp.makeConstraints { (make) in
            make.right.equalTo(skill.superview!).offset(kScale(-15))
            make.centerY.equalTo(skill.superview!)
            make.size.equalTo(kSize(80, height: 24))
        }
    }
    
    func setTextInCell(text: String, placeholder: String) {
        label.text = text
        skill.setTitle(placeholder, forState: .Normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
