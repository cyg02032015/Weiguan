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
            replyLabel.hidden = isEmptyString(info.replyNickname)
            replyNickNameLabel.hidden = isEmptyString(info.replyNickname)
            replyNickNameLabel.text = info.replyNickname
        }
    }
    
    var headImgView: IconHeaderView!
    var replyNickNameLabel: TouchLabel!
    var replyLabel: UILabel!
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
        headImgView.snp.makeConstraints { [unowned self](make) in
            make.top.equalTo(self.headImgView.superview!).offset(kScale(11))
            make.left.equalTo(self.headImgView.superview!).offset(kScale(15))
            make.size.equalTo(kSize(35, height: 35))
        }
        
        nameLabel = UILabel()
        nameLabel.font = UIFont.customFontOfSize(14)
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { [unowned self](make) in
            make.top.equalTo(self.nameLabel.superview!).offset(kScale(13))
            make.left.equalTo(self.headImgView.snp.right).offset(kScale(10))
            //make.height.equalTo(kScale(14))
        }
        
        replyLabel = UILabel()
        replyLabel.hidden = true
        replyLabel.font = UIFont.customFontOfSize(12)
        replyLabel.textColor = UIColor(hex: 0xc8c8c8)
        replyLabel.text = "回复"
        contentView.addSubview(replyLabel)
        replyLabel.snp.makeConstraints { [unowned self](make) in
            make.centerY.equalTo(self.nameLabel)
            make.left.equalTo(self.nameLabel.snp.right).offset(2)
        }
        
        replyNickNameLabel = TouchLabel()
        replyNickNameLabel.hidden = true
        replyNickNameLabel.font = UIFont.customFontOfSize(14)
        replyNickNameLabel.text = "回复"
        contentView.addSubview(replyNickNameLabel)
        replyNickNameLabel.snp.makeConstraints { [unowned self](make) in
            make.centerY.equalTo(self.nameLabel)
            make.left.equalTo(self.replyLabel.snp.right).offset(2)
        }
        
        timeLabel = UILabel()
        timeLabel.font = UIFont.customFontOfSize(14)
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
            make.height.equalTo(1/UIScreen.mainScreen().scale)
        }
        
        nameLabel.text = ""
        timeLabel.text = "--"
        detail.text = ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
