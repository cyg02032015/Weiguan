//
//  DynamicCell.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/7.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class DynamicCell: UITableViewCell {

    var headImgView: IconHeaderView!
    var nameLabel: UILabel!
    var timeLabel: UILabel!
    var bigImgView: UIImageView!
    var details: UILabel!
    
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
            make.top.equalTo(headImgView.superview!).offset(kScale(10))
            make.left.equalTo(headImgView.superview!).offset(kScale(15))
            make.size.equalTo(kSize(35, height: 35))
        }
        
        nameLabel = UILabel()
        nameLabel.font = UIFont.customFontOfSize(16)
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.superview!).offset(kScale(15))
            make.left.equalTo(headImgView.snp.right).offset(kScale(10))
            make.height.equalTo(kScale(16))
            make.right.equalTo(nameLabel.superview!).offset(kScale(-15))
        }
        
        let timeImgView = UIImageView(image: UIImage(named: ""))
        contentView.addSubview(timeImgView)
        timeImgView.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(kScale(4))
            make.left.equalTo(headImgView.snp.right).offset(kScale(10))
            make.size.equalTo(kSize(10, height: 10))
        }
        
        timeLabel = UILabel()
        timeLabel.font = UIFont.customFontOfSize(12)
        timeLabel.textColor = UIColor(hex: 0xc8c8c8)
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(timeImgView)
            make.left.equalTo(timeImgView.snp.right).offset(kScale(4))
            make.height.equalTo(kScale(12))
        }
        
        bigImgView = UIImageView()
        contentView.addSubview(bigImgView)
        bigImgView.snp.makeConstraints { (make) in
            make.top.equalTo(headImgView.snp.bottom).offset(kScale(10))
            make.size.equalTo(CGSize(width: ScreenWidth, height: ScreenWidth))
            make.left.equalTo(bigImgView.superview!)
        }
        
        details = UILabel()
        details.numberOfLines = 3
        details.font = UIFont.customFontOfSize(14)
        contentView.addSubview(details)
        details.snp.makeConstraints { (make) in
            make.top.equalTo(bigImgView.snp.bottom).offset(kScale(10))
            make.left.equalTo(headImgView)
            make.right.equalTo(details.superview!).offset(kScale(-15))
        }
        
        let lineV = UIView()
        lineV.backgroundColor = kLineColor
        contentView.addSubview(lineV)
        lineV.snp.makeConstraints { (make) in
            make.top.equalTo(details.snp.bottom).offset(kScale(15))
            make.left.equalTo(lineV.superview!).offset(kScale(15))
            make.right.equalTo(lineV.superview!).offset(kScale(-15))
            make.height.equalTo(1)
        }
        
        // tool
        let toolContainer = UIView()
        contentView.addSubview(toolContainer)
        
        toolContainer.snp.makeConstraints { (make) in
            make.top.equalTo(lineV.snp.bottom)
            make.left.right.equalTo(toolContainer.superview!)
            make.height.equalTo(kScale(44))
            make.bottom.lessThanOrEqualTo(toolContainer.superview!)
        }
        
        // 赞TA
        let praiseTAContainer = UIView()
        toolContainer.addSubview(praiseTAContainer)
        
        let praiseBtn = UIButton()
        praiseBtn.setImage(UIImage(named: "home_lead"), forState: .Normal)
        praiseBtn.setTitle("赞TA", forState: .Normal)
        praiseBtn.titleLabel?.font = UIFont.customFontOfSize(22)
        praiseBtn.setTitleColor(kGrayColor, forState: .Normal)
        praiseTAContainer.addSubview(praiseBtn)
        
        praiseTAContainer.snp.makeConstraints { (make) in
            make.top.equalTo(toolContainer)
            make.left.equalTo(praiseTAContainer.superview!)
            make.width.equalTo(praiseTAContainer.superview!).multipliedBy(1.0/3.0)
            make.height.equalTo(toolContainer)
        }
        
        praiseBtn.snp.makeConstraints { (make) in
            make.edges.equalTo(praiseBtn.superview!)
        }
        
        let verticalLine1 = UIView()
        verticalLine1.backgroundColor = kLineColor
        toolContainer.addSubview(verticalLine1)
        
        verticalLine1.snp.makeConstraints { (make) in
            make.left.equalTo(praiseTAContainer.snp.right)
            make.size.equalTo(CGSize(width: 1, height: 24))
            make.centerY.equalTo(verticalLine1.superview!)
        }
        
        // 评论
        let commentContainer = UIView()
        toolContainer.addSubview(commentContainer)
        
        let commentBtn = UIButton()
        commentBtn.setImage(UIImage(named: "home_lead"), forState: .Normal)
        commentBtn.setTitle("评论", forState: .Normal)
        commentBtn.titleLabel?.font = UIFont.customFontOfSize(22)
        commentBtn.setTitleColor(kGrayColor, forState: .Normal)
        commentContainer.addSubview(commentBtn)
        
        commentContainer.snp.makeConstraints { (make) in
            make.top.equalTo(toolContainer)
            make.left.equalTo(praiseTAContainer.snp.right)
            make.width.equalTo(praiseTAContainer)
            make.height.equalTo(toolContainer)
        }
        
        commentBtn.snp.makeConstraints { (make) in
            make.edges.equalTo(commentBtn.superview!)
        }
        
        let verticalLine2 = UIView()
        verticalLine2.backgroundColor = kLineColor
        toolContainer.addSubview(verticalLine2)
        
        verticalLine2.snp.makeConstraints { (make) in
            make.left.equalTo(commentContainer.snp.right)
            make.size.equalTo(CGSize(width: 1, height: 24))
            make.centerY.equalTo(verticalLine2.superview!)
        }
        
        // share
        let shareContainer = UIView()
        toolContainer.addSubview(shareContainer)
        
        shareContainer.snp.makeConstraints { (make) in
            make.top.equalTo(toolContainer)
            make.left.equalTo(commentContainer.snp.right)
            make.width.equalTo(commentContainer)
            make.height.equalTo(toolContainer)
        }
        
        let shareBtn = UIButton()
        shareBtn.setImage(UIImage(named: "home_lead"), forState: .Normal)
        shareBtn.setTitle("评论", forState: .Normal)
        shareBtn.titleLabel?.font = UIFont.customFontOfSize(22)
        shareBtn.setTitleColor(kGrayColor, forState: .Normal)
        shareContainer.addSubview(shareBtn)

        shareBtn.snp.makeConstraints { (make) in
            make.edges.equalTo(shareBtn.superview!)
        }

        nameLabel.text = "晨曦"
        timeImgView.backgroundColor = UIColor.yellowColor()
        timeLabel.text = "15:02"
        headImgView.backgroundColor = UIColor.redColor()
        bigImgView.backgroundColor = UIColor.grayColor()
        details.text = "asdfaslfkasjdfsalfkhasglsakghaskgjahgwoeiurtqwporiewyuotpqiwytqwoptiyq"
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
