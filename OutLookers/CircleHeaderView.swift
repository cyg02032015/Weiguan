//
//  CircleHeaderView.swift
//  OutLookers
//
//  Created by C on 16/8/14.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class CircleHeaderView: UICollectionReusableView {
    var banner: SDCycleScrollView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    func setupSubViews() {
        banner = SDCycleScrollView(frame: bounds, delegate: nil, placeholderImage: UIImage(named: ""))
        banner.pageDotImage = UIImage(named: "home_point_normal")
        banner.currentPageDotImage = UIImage(named: "home_point_chosen")
        banner.pageControlDotSize = kSize(6, height: 6)
        banner.pageControlAliment = SDCycleScrollViewPageContolAlimentRight
        addSubview(banner)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
