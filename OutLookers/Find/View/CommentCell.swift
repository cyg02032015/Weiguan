//
//  CommentCell.swift
//  OutLookers
//
//  Created by C on 16/7/17.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    var info: CommentList! {
        didSet {
            headImgView.iconURL = info.headImgUrl.addImagePath(kSize(35, height: 35))
            headImgView.setVimage(Util.userType(info.detailsType))
            timeLabel.text = info.createTime.dateFromString()?.getShowFormat()
            nameLabel.text = info.nickname
            detail.text = info.text
        }
    }
    
    var headImgView: IconHeaderView!
    var nameLabel: UILabel!
    var timeLabel: UILabel!
    var detail: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        headImgView = IconHeaderView()
        headImgView.customCornerRadius = kScale(35/2)
        contentView.addSubview(headImgView)
        headImgView.snp.makeConstraints { (make) in
            make.top.equalTo(headImgView.superview!).offset(kScale(11))
            make.left.equalTo(headImgView.superview!).offset(kScale(15))
            make.size.equalTo(kSize(35, height: 35))
        }
        
        nameLabel = UILabel()
        nameLabel.font = UIFont.customFontOfSize(14)
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.superview!).offset(kScale(13))
            make.left.equalTo(headImgView.snp.right).offset(kScale(10))
            make.height.equalTo(kScale(14))
        }
        
        timeLabel = UILabel()
        timeLabel.font = UIFont.customFontOfSize(12)
        timeLabel.textColor = UIColor(hex: 0xc8c8c8)
        timeLabel.textAlignment = .Right
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(timeLabel.superview!).offset(kScale(-15))
            make.top.equalTo(timeLabel.superview!).offset(kScale(15))
            make.height.equalTo(kScale(12))
        }

        detail = UILabel.createLabel(14, textColor: UIColor(hex: 0x666666))
        detail.numberOfLines = 0
        contentView.addSubview(detail)
        detail.snp.makeConstraints { (make) in
            make.left.equalTo(headImgView.snp.right).offset(kScale(10))
            make.right.equalTo(detail.superview!).offset(kScale(-15))
            make.top.equalTo(nameLabel.snp.bottom).offset(kScale(10))
            make.bottom.equalTo(detail.superview!).offset(kScale(-10))
        }
        
        let lineV = UIView()
        lineV.backgroundColor = kLineColor
        contentView.addSubview(lineV)
        lineV.snp.makeConstraints { (make) in
            make.left.equalTo(lineV.superview!).offset(kScale(15))
            make.right.equalTo(lineV.superview!).offset(kScale(-15))
            make.bottom.equalTo(lineV.superview!)
            make.height.equalTo(1)
        }
        
        nameLabel.text = "adf"
        timeLabel.text = "2016-7-10"
        detail.text = "sdfdfsfsdfdssdfs"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
