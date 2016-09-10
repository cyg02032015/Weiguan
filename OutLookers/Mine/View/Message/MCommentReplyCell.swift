//
//  MCommentReplyCell.swift
//  OutLookers
//
//  Created by 宋碧海 on 16/9/9.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class MCommentReplyCell: UITableViewCell {

    var headImgView: IconHeaderView!
    var nameLabel: UILabel!
    var comment: UILabel!
    var time: UILabel!
    var desc: UILabel!
    var imgView: TouchImageView!
    var replyNameLabel: TouchLabel!
    
    var info: CommentList! {
        didSet {
            headImgView.iconURL = info.headImgUrl.addImagePath(kSize(40, height: 40))
            headImgView.setVimage(Util.userType(info.detailsType))
            time.text = CPDateUtil.dateToString(CPDateUtil.stringToDate(info.createTime), dateFormat: "MM-dd HH:mm")
            nameLabel.text = info.nickname
            desc.text = info.text
            imgView.yy_setImageWithURL(info.cover.addImagePath(kSize(40, height: 40)), placeholder: nil)
            replyNameLabel.text = info.replyNickname
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubViews() {
        headImgView = IconHeaderView()
        headImgView.customCornerRadius = kScale(40/2)
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
//            make.height.equalTo(kScale(16))
            make.width.equalTo(kScale(32))
            make.right.lessThanOrEqualTo(imgView.snp.left).offset(kScale(-5))
        }
        
        replyNameLabel = TouchLabel()
        replyNameLabel.font = UIFont.customFontOfSize(16)
        replyNameLabel.textColor = UIColor.init(hex: 0xc0c0c0)
        contentView.addSubview(replyNameLabel)
        replyNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(comment.snp.right).offset(kScale(6))
            make.centerY.equalTo(comment)
//            make.height.equalTo(kScale(16))
            make.right.equalTo(replyNameLabel.superview!).offset(-60)
            make.right.lessThanOrEqualTo(imgView.snp.left).offset(kScale(-5))
        }
        
        
        time = UILabel.createLabel(14, textColor: UIColor(hex: 0xc8c8c8))
        contentView.addSubview(time)
        time.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(kScale(4))
//            make.height.equalTo(kScale(17))
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
        imgView.backgroundColor = UIColor.grayColor()
        nameLabel.text = ""
        time.text = "- :"
        desc.text = ""
        comment.text = "回复"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
