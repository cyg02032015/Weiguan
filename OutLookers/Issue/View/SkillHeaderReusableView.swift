//
//  SkillHeaderReusableView.swift
//  OutLookers
//
//  Created by Youngkook on 16/6/20.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class SkillHeaderReusableView: UICollectionReusableView {
    
    var imgView: UIImageView!
    var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    func setupSubViews() {
        imgView = UIImageView()
        addSubview(imgView)
        
        label = UILabel()
        label.font = UIFont.customFontOfSize(16)
        addSubview(label)
        
        imgView.snp.makeConstraints { (make) in
            make.size.equalTo(kSize(33, height: 33))
            make.left.equalTo(kScale(12))
            make.centerY.equalTo(imgView.superview!)
        }
        
        label.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.snp.right)
            make.centerY.equalTo(imgView)
            make.height.equalTo(kScale(16))
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
