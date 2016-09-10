//
//  HomeCell.swift
//  OutLookers
//
//  Created by C on 16/7/15.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private extension Selector {
    static let tapHeadImg = #selector(HomeCell.tapHeadImg)
}

class HomeCell: UITableViewCell {
    
    var info: DynamicResult! {
        didSet {
            backImgView.yy_setImageWithURL(info.cover.addImagePath(), placeholder: kPlaceholder)
            headImgView.yy_setImageWithURL(info.photo.addImagePath(kSize(36, height: 36)), placeholder: kPlaceholder)
            nameLabel.text = info.name
            detailLabel.text = info.text
            if info.replyCount > 0 {
                commentButton.setTitle("\(info.replyCount)", forState: .Normal)
            }
            if info.likeCount > 0 {
                zanButton.setTitle("\(info.likeCount)", forState: .Normal)
            }
        }
    }
    var headClosure: (()->Void)!
    var backImgView: UIImageView!
    var headImgView: TouchImageView!
    var nameLabel: UILabel!
    var zanButton: UIButton!
    var commentButton: UIButton!
    var detailLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        backImgView = UIImageView()
        contentView.addSubview(backImgView)
        backImgView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(backImgView.superview!)
            make.height.equalTo(ScreenWidth)
        }
        
        headImgView = TouchImageView()
        headImgView.clipsToBounds = true
        headImgView.layer.borderWidth = 2
        headImgView.layer.borderColor = UIColor.whiteColor().CGColor
        headImgView.layer.cornerRadius = kScale(36/2)
        headImgView.addTarget(self, action: .tapHeadImg)
        contentView.addSubview(headImgView)
        headImgView.snp.makeConstraints { (make) in
            make.left.equalTo(headImgView.superview!).offset(kScale(15))
            make.size.equalTo(kSize(36, height: 36))
            make.top.equalTo(backImgView.snp.bottom).offset(kScale(-15))
        }
        
        nameLabel = UILabel.createLabel(12, textColor: kGrayColor)
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(headImgView.snp.right).offset(kScale(8))
            make.top.equalTo(backImgView.snp.bottom).offset(kScale(8))
            make.height.equalTo(kScale(12))
        }
        
        commentButton = UIButton()
        commentButton.setImage(UIImage(named: "dis"), forState: .Normal)
        commentButton.setTitleColor(kLightGrayColor, forState: .Normal)
        commentButton.titleLabel!.font = UIFont.customFontOfSize(12)
        contentView.addSubview(commentButton)
        commentButton.snp.makeConstraints { (make) in
            make.right.equalTo(commentButton.superview!).offset(kScale(-15))
            make.top.equalTo(backImgView.snp.bottom).offset(kScale(10))
            make.height.equalTo(kScale(15))
        }
        
        zanButton = UIButton()
        zanButton.setImage(UIImage(named: "like"), forState: .Normal)
        zanButton.setImage(UIImage(named: "like_chosen"), forState: .Highlighted)
        zanButton.setTitleColor(kLightGrayColor, forState: .Normal)
        zanButton.titleLabel!.font = UIFont.customFontOfSize(12)
        contentView.addSubview(zanButton)
        zanButton.snp.makeConstraints { (make) in
            make.right.equalTo(commentButton.snp.left).offset(kScale(-10))
            make.height.equalTo(commentButton)
            make.centerY.equalTo(commentButton)
        }
        
        detailLabel = UILabel.createLabel(14)
        detailLabel.numberOfLines = 3
        contentView.addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(detailLabel.superview!).offset(kScale(15))
            make.right.equalTo(detailLabel.superview!).offset(kScale(-15))
            make.top.equalTo(headImgView.snp.bottom).offset(kScale(10))
            make.bottom.lessThanOrEqualTo(detailLabel.superview!).offset(kScale(-25))
        }
        
        zanButton.setTitle("赞TA", forState: .Normal)
        commentButton.setTitle("评论", forState: .Normal)
        
    }
    
    func tapHeadImg() {
        if headClosure != nil {
            headClosure()
        }
    }
    
    func tapHeadBlock(closure:()->Void) {
        headClosure = closure
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
