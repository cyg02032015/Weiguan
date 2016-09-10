//
//  RecommendHeaderView.swift
//  OutLookers
//
//  Created by C on 16/7/3.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class RecommendHeaderView: UICollectionReusableView {

    var label: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    func setupSubViews() {
        backgroundColor = UIColor.whiteColor()
        
        let imgView = UIImageView(image: UIImage(named: "home_lead"))
        addSubview(imgView)
        
        imgView.snp.makeConstraints { (make) in
            make.size.equalTo(kSize(4, height: 15))
            make.left.equalTo(kScale(0))
            make.centerY.equalTo(imgView.superview!)
        }
        
        label = UILabel()
        label.text = "推荐红人"
        label.font = UIFont.customFontOfSize(16)
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.height.equalTo(kHeight(16))
            make.left.equalTo(imgView.snp.right).offset(kScale(6))
            make.centerY.equalTo(imgView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
