//
//  InvitationCircularCell.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/22.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class InvitationCircularCell: UITableViewCell {

    var imgView: UIImageView!
    var nameLabel: UILabel!
    var jobLabel: UILabel!
    
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
            make.size.equalTo(kSize(62, height: 62))
        }
        
        nameLabel = UILabel.createLabel(16)
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.superview!).offset(kScale(14))
            make.height.equalTo(kScale(16))
            make.left.equalTo(imgView.snp.right).offset(kScale(10))
        }
        
        jobLabel = UILabel.createLabel(16)
        contentView.addSubview(jobLabel)
        jobLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(kScale(11))
            make.height.equalTo(kScale(16))
        }
        
        imgView.backgroundColor = UIColor.yellowColor()
        nameLabel.text = "北京国际车展"
        jobLabel.text = "车模"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
