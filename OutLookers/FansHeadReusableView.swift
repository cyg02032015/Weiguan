//
//  FansHeadReusableView.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/21.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class FansHeadReusableView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    
    func setupSubViews() {
        let label = UILabel.createLabel(14, textColor: UIColor(hex: 0x999999))
        label.text = "选择成为TA的认证粉丝（最多3个）"
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(kScale(15))
            make.centerY.equalTo(label.superview!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
