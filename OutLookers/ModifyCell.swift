//
//  ModifyCell.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/19.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class ModifyCell: UITableViewCell {

    var label: UILabel!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        label = UILabel.createLabel(16)
        contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(label.superview!).offset(kScale(15))
            make.centerY.equalTo(label.superview!)
        }
        
        let arrow = UIImageView(image: UIImage(named: "open"))
        contentView.addSubview(arrow)
        arrow.snp.makeConstraints { (make) in
            make.right.equalTo(arrow.superview!).offset(kScale(-15))
            make.centerY.equalTo(arrow.superview!)
            make.size.equalTo(kSize(8, height: 15))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
