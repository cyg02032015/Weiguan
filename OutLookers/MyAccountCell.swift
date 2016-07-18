//
//  MyAccountCell.swift
//  OutLookers
//
//  Created by C on 16/7/18.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class MyAccountCell: UITableViewCell {

    var imgView: UIImageView!
    var label: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        imgView = UIImageView()
        contentView.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.superview!).offset(kScale(15))
            make.centerY.equalTo(imgView.superview!)
            make.size.equalTo(kSize(18, height: 18))
        }
        
        label = UILabel.createLabel(16)
        contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.snp.right).offset(kScale(10))
            make.centerY.equalTo(imgView)
            make.height.equalTo(kScale(16))
        }
        
        let arrow = UIImageView(image: UIImage(named: "open"))
        contentView.addSubview(arrow)
        arrow.snp.makeConstraints { (make) in
            make.right.equalTo(arrow.superview!).offset(kScale(-15))
            make.size.equalTo(kSize(8, height: 15))
            make.centerY.equalTo(arrow.superview!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
