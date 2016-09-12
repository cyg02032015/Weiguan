//
//  DynamicCell.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/7.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

@objc protocol DynamicCellDelegate: class {
    func dynamicCellTapPraise(sender: UIButton, indexPath: NSIndexPath)
    func dynamicCellTapComment(sender: UIButton, indexPath: NSIndexPath)
    func dynamicCellTapShare(sender: UIButton, indexPath: NSIndexPath)
    optional
    func dynamicCellTapFollow(sender: UIButton, indexPath: NSIndexPath)
}

class DynamicCell: UITableViewCell, VideoPlayerProtocol {

    weak var tableView: UITableView!
    var info: DynamicResult! {
        didSet {
            headImgView.iconURL = info.photo.addImagePath(kSize(35, height: 35))
            headImgView.setVimage(Util.userType(info.detailsType))
            nameLabel.text = info.name
            timeLabel.text = info.createTime.dateFromString()?.getShowFormat()
            bigImgView.yy_setImageWithURL(info.cover.addImagePath(), placeholder: kPlaceholder)
            details.text = info.text
            if UserSingleton.sharedInstance.isLogin() {
                if info.isLike == 1 {
                    praiseBtn.selected = true
                } else {
                    praiseBtn.selected = false
                }
                if isSquare {
                    if info.follow == 1 { // 已关注
                        followButton.hidden = true
                    } else {
                        followButton.hidden = false
                    }
                } else {
                    followButton.hidden = true
                }
            } else {
                praiseBtn.selected = false
                if isSquare {
                    followButton.hidden = false
                } else {
                    followButton.hidden = true
                }
            }
            
            if info.likeCount > 0 {
                praiseBtn.setTitle("\(info.likeCount)", forState: .Normal)
            } else {
                praiseBtn.setTitle("赞TA", forState: .Normal)
            }
            if info.replyCount > 0 {
                commentBtn.setTitle("\(info.replyCount)", forState: .Normal)
            } else {
                commentBtn.setTitle("评论", forState: .Normal)
            }
            if info.isVideo == 1 { // 不是视频
                videoImgView.hidden = true
            } else {
                videoImgView.hidden = false
            }
            
        }
    }
    var isSquare: Bool = false
    var indexPath: NSIndexPath!
    weak var delegate: DynamicCellDelegate!
    var headImgView: IconHeaderView!
    var nameLabel: UILabel!
    var timeLabel: UILabel!
    var bigImgView: UIImageView!
    var details: UILabel!
    var followButton: UIButton!
    var praiseBtn: UIButton!
    var commentBtn: UIButton!
    var videoImgView: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        headImgView = IconHeaderView(frame: CGRect(origin: CGPointZero, size: kSize(35, height: 35)))
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
            make.height.equalTo(kScale(20))
        }
        
        let timeImgView = UIImageView(image: UIImage(named: "time"))
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
        
        followButton = UIButton()
        followButton.setImage(UIImage(named: "follow11"), forState: .Normal)
        followButton.setTitleColor(kCommonColor, forState: .Normal)
        followButton.titleLabel!.font = UIFont.customFontOfSize(10)
        contentView.addSubview(followButton)
        followButton.snp.makeConstraints { (make) in
            make.right.equalTo(followButton.superview!).offset(kScale(-16))
            make.size.equalTo(kSize(50, height: 20))
            make.centerY.equalTo(headImgView)
        }
        
        bigImgView = UIImageView()
        bigImgView.tag = 111
        bigImgView.contentMode = .ScaleAspectFill
        bigImgView.clipsToBounds = true
        contentView.addSubview(bigImgView)
        bigImgView.snp.makeConstraints { (make) in
            make.top.equalTo(headImgView.snp.bottom).offset(kScale(10))
            make.size.equalTo(CGSize(width: ScreenWidth, height: ScreenWidth))
            make.left.equalTo(bigImgView.superview!)
        }
        
        videoImgView = UIImageView(image: UIImage(named: "play"))
        videoImgView.hidden = true
        bigImgView.addSubview(videoImgView)
        videoImgView.snp.makeConstraints { (make) in
            make.centerX.equalTo(videoImgView.superview!)
            make.centerY.equalTo(videoImgView.superview!)
            make.size.equalTo(kSize(73, height: 73))
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
        praiseBtn = UIButton()
        praiseBtn.setImage(UIImage(named: "like_normal"), forState: .Normal)
        praiseBtn.setImage(UIImage(named: "like_chosen"), forState: .Selected)
        praiseBtn.setTitle("赞TA", forState: .Normal)
        praiseBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        praiseBtn.titleLabel!.font = UIFont.customFontOfSize(16)
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
        
        commentBtn = UIButton()
        commentBtn.setImage(UIImage(named: "dis"), forState: .Normal)
        commentBtn.setTitle("评论", forState: .Normal)
        commentBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        commentBtn.titleLabel!.font = UIFont.customFontOfSize(16)
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
        shareBtn.setImage(UIImage(named: "share"), forState: .Normal)
        shareBtn.setTitle("分享", forState: .Normal)
        shareBtn.titleLabel!.font = UIFont.customFontOfSize(16)
        shareBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        shareBtn.setTitleColor(kGrayColor, forState: .Normal)
        shareContainer.addSubview(shareBtn)

        shareBtn.snp.makeConstraints { (make) in
            make.edges.equalTo(shareBtn.superview!)
        }
        
        praiseBtn.rx_tap.subscribeNext {
            if self.delegate != nil {
                self.delegate.dynamicCellTapPraise(self.praiseBtn, indexPath: self.indexPath)
            }
        }.addDisposableTo(disposeBag)
        
        commentBtn.rx_tap.subscribeNext {
            if self.delegate != nil {
                self.delegate.dynamicCellTapComment(self.commentBtn, indexPath: self.indexPath)
            }
        }.addDisposableTo(disposeBag)
        
        shareBtn.rx_tap.subscribeNext {
            if self.delegate != nil {
                self.delegate.dynamicCellTapShare(shareBtn, indexPath: self.indexPath)
            }
        }.addDisposableTo(disposeBag)
        
        followButton.rx_tap.subscribeNext {
            if self.delegate != nil && self.followButton.hidden == false {
                self.delegate.dynamicCellTapFollow!(self.followButton, indexPath: self.indexPath)
            }
        }.addDisposableTo(disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
