//
//  LogButtonCell.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/26.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class LogButtonCell: UITableViewCell {

    var label: UILabel!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        label = UILabel.createLabel(14, textColor: kCommonColor)
        label.textAlignment = .Center
        contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.edges.equalTo(label.superview!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
