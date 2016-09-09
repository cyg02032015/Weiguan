//
//  MPraiseCell.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/21.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class MPraiseCell: UITableViewCell {

    private let header_width: CGFloat = 40
    var likeData: LikeList? {
        didSet {
            headImgView.iconURL = likeData?.headImgUrl.addImagePath(kSize(header_width, height: header_width))
            headImgView.setVimage(Util.userType(likeData!.detailsType))
            nameLabel.text = likeData?.nickname
            time.text = CPDateUtil.dateToString(CPDateUtil.stringToDate(likeData!.createTime), dateFormat: "MM-dd HH:mm")
            imgView.yy_setImageWithURL(likeData!.cover.addImagePath(kSize(header_width, height: header_width)), placeholder: nil)
        }
    }
    var headImgView: IconHeaderView!
    var nameLabel: UILabel!
    var comment: UILabel!
    var time: UILabel!
    var imgView: TouchImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        headImgView = IconHeaderView()
        headImgView.iconPlaceholder = kHeadPlaceholder
        contentView.addSubview(headImgView)
        headImgView.snp.makeConstraints { (make) in
            make.top.equalTo(kScale(10))
            make.left.equalTo(headImgView.superview!).offset(kScale(15))
            make.size.equalTo(kSize(header_width, height: header_width))
        }
        headImgView.customCornerRadius = kScale(header_width/2)
        
        imgView = TouchImageView()
        contentView.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.right.equalTo(imgView.superview!).offset(kScale(-15))
            make.top.equalTo(imgView.superview!).offset(kScale(11))
            make.size.equalTo(kSize(header_width, height: header_width))
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
            make.left.equalTo(nameLabel.snp.right).offset(kScale(10))
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
        
        imgView.image = kPlaceholder
        nameLabel.text = ""
        time.text = "-- :"
        comment.text = "赞了"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
