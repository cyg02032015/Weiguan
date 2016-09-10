//
//  MCommentCell.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/21.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class MCommentCell: UITableViewCell {

    var headImgView: IconHeaderView!
    var nameLabel: UILabel!
    var comment: UILabel!
    var time: UILabel!
    var desc: UILabel!
    var imgView: TouchImageView!
    
    var info: CommentList! {
        didSet {
            headImgView.iconURL = info.headImgUrl.addImagePath(kSize(40, height: 40))
            headImgView.setVimage(Util.userType(info.detailsType))
            time.text = CPDateUtil.dateToString(CPDateUtil.stringToDate(info.createTime), dateFormat: "MM-dd HH:mm")
            nameLabel.text = info.nickname
            desc.text = info.text
            imgView.yy_setImageWithURL(info.cover.addImagePath(kSize(40, height: 40)), placeholder: nil)
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        headImgView = IconHeaderView()
        contentView.addSubview(headImgView)
        headImgView.snp.makeConstraints { (make) in
            make.top.equalTo(kScale(10))
            make.left.equalTo(headImgView.superview!).offset(kScale(15))
            make.size.equalTo(kSize(40, height: 40))
        }
        
        imgView = TouchImageView()
        contentView.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.right.equalTo(imgView.superview!).offset(kScale(-15))
            make.top.equalTo(imgView.superview!).offset(kScale(11))
            make.size.equalTo(kSize(40, height: 40))
        }
        
        nameLabel = UILabel()
        nameLabel.font = UIFont.customNumFontOfSize(16)
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(headImgView.snp.right).offset(kScale(11))
            make.top.equalTo(nameLabel.superview!).offset(kScale(15))
            make.height.equalTo(kScale(16))
        }
        
        comment = UILabel.createLabel(16, textColor: UIColor(hex: 0xc0c0c0))
        contentView.addSubview(comment)
        comment.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.right).offset(kScale(6))
            make.centerY.equalTo(nameLabel)
            make.height.equalTo(kScale(16))
            make.width.equalTo(kScale(32))
            make.right.lessThanOrEqualTo(imgView.snp.left).offset(kScale(-5))
        }
        
        time = UILabel.createLabel(14, textColor: UIColor(hex: 0xc8c8c8))
        contentView.addSubview(time)
        time.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(kScale(4))
            make.height.equalTo(kScale(17))
        }
        
        desc = UILabel.createLabel(16, textColor: UIColor(hex: 0x666666))
        contentView.addSubview(desc)
        desc.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.right.equalTo(imgView)
            make.top.equalTo(time.snp.bottom).offset(kScale(9))
            make.bottom.lessThanOrEqualTo(desc.superview!).offset(kScale(10))
        }
        
        headImgView.iconPlaceholder = kHeadPlaceholder
        imgView.image = kPlaceholder
        nameLabel.text = ""
        time.text = "- :"
        desc.text = ""
        comment.text = ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
