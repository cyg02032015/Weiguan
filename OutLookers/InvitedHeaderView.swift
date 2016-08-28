//
//  InvitedHeaderView.swift
//  OutLookers
//
//  Created by C on 16/8/28.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class InvitedHeaderView: UIView {

    var cycleView: SDCycleScrollView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    func setupSubViews() {
        cycleView = SDCycleScrollView(frame: bounds, delegate: nil, placeholderImage: kPlaceholder)
        cycleView.pageDotImage = UIImage(named: "home_point_normal")
        cycleView.currentPageDotImage = UIImage(named: "home_point_chosen")
        cycleView.pageControlDotSize = kSize(6, height: 6)
        cycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter
        cycleView.bannerImageViewContentMode = .ScaleAspectFill
        addSubview(cycleView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
