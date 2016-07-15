//
//  CircularCell.swift
//  OutLookers
//
//  Created by C on 16/7/15.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class CircularCell: UITableViewCell {

    var imgView: UIImageView!
    var subjectLabel: UILabel!
    var recruitLabel: UILabel!
    var dayLabel: UILabel!
    var addressLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        imgView = UIImageView()
        contentView.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(imgView.superview!)
            make.height.equalTo(kScale(210))
        }
        
        subjectLabel = UILabel()
        subjectLabel.font = UIFont.customHelveticaFontOfSize(16)
        contentView.addSubview(subjectLabel)
        subjectLabel.snp.makeConstraints { (make) in
            make.left.equalTo(subjectLabel.superview!).offset(kScale(15))
            make.height.equalTo(kScale(16))
            make.top.equalTo(imgView.snp.bottom).offset(kScale(10))
        }
        
        recruitLabel = UILabel.createLabel(12, textColor: UIColor(hex: 0x666666))
        contentView.addSubview(recruitLabel)
        recruitLabel.snp.makeConstraints { (make) in
            make.left.equalTo(subjectLabel)
            make.top.equalTo(subjectLabel.snp.bottom).offset(kScale(10))
            make.height.equalTo(kScale(12))
        }
        
        dayLabel = UILabel.createLabel(12, textColor: UIColor(hex: 0x666666))
        contentView.addSubview(dayLabel)
        dayLabel.snp.makeConstraints { (make) in
            make.left.equalTo(recruitLabel)
            make.top.equalTo(recruitLabel.snp.bottom).offset(kScale(6))
            make.height.equalTo(kScale(12))
            make.right.equalTo(dayLabel.superview!).offset(kScale(-15))
        }
        
        imgView.backgroundColor = UIColor.greenColor()
        subjectLabel.text = "2016法兰克福国际车展"
        recruitLabel.text = "招募：车模/礼仪"
        dayLabel.text = "6月19日-6月26日  北京市|西城区|蓝色港湾中央广场"
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
