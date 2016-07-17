//
//  PersonCharacterHeadView.swift
//  OutLookers
//
//  Created by C on 16/7/17.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class PersonCharacterHeadView: UICollectionReusableView {
    
    var title: UILabel!
    var option: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    func setupSubViews() {
        
        let sectionV = UIView()
        sectionV.backgroundColor = kBackgoundColor
        addSubview(sectionV)
        sectionV.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(sectionV.superview!)
            make.height.equalTo(kScale(10))
        }
        
        title = UILabel.createLabel(16)
        addSubview(title)
        title.snp.makeConstraints { (make) in
            make.left.equalTo(title.superview!).offset(kScale(15))
            make.top.equalTo(sectionV.snp.bottom).offset(kScale(15))
            make.height.equalTo(kScale(16))
        }
        
        option = UILabel.createLabel(16, textColor: UIColor(hex: 0x777777))
        addSubview(option)
        option.snp.makeConstraints { (make) in
            make.left.equalTo(title.snp.right).offset(kScale(5))
            make.centerY.equalTo(title)
            make.height.equalTo(kScale(16))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
