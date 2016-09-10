//
//  IssueTalentListHeader.swift
//  OutLookers
//
//  Created by C on 16/8/21.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class IssueTalentListHeader: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    func setupSubViews() {
        let label = UILabel.createLabel(14, textColor: UIColor(hex: 0x666666))
        label.text = "才艺关联"
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(label.superview!).offset(kScale(15))
            make.centerY.equalTo(label.superview!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
