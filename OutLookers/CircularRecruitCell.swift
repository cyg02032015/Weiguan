//
//  CircularRecruitCell.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/22.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class CircularRecruitCell: UITableViewCell {

    var headerView: SDCycleScrollView!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        headerView = SDCycleScrollView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: kHeight(219)), delegate: self, placeholderImage: UIImage(named: ""))
        contentView.addSubview(headerView)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CircularRecruitCell: SDCycleScrollViewDelegate {
    
}
