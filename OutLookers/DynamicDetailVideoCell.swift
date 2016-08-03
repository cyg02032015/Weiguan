//
//  DynamicDetailVideoCell.swift
//  OutLookers
//
//  Created by C on 16/7/17.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

let talentPadding: CGFloat = 15


class DynamicDetailVideoCell: UITableViewCell {

    var info: DynamicDetailResp! {
        didSet {
            guard let url = info.pictureList.first?.url else {return}
            timeLabel.text = info.createTime.dateFromString()?.getShowFormat()
            bigImgView.yy_setImageWithURL(url.addImagePath(CGSize(width: ScreenWidth, height: ScreenWidth)), placeholder: kPlaceholder)
            details.text = info.text
            
            if shareButton != nil {
                return
            }

            // 图片还是视频
            if info.isVideo == "1" {  // 图片
                bigImgView.hidden = false
                player.hidden = true
            } else { // 视频
                bigImgView.hidden = true
                player.hidden = false
                Server.getSanpshots("\(info.cover)", handler: { [unowned self](success, msg, value) in
                    if success {
                        guard let object = value else {return}
                        let item = self.preparePlayerItem(object[0].addSnapshots(), url: url.addVideoPath())
                        self.player.playWithPlayerItem(item)
                        LogDebug(url.addVideoPath())
                    } else {
                        LogError("获取视频截图失败 = \(msg)")
                    }
                })
            }
            
            
            // talent tags 实现
            let padding: CGFloat = 8
            let container = UIView()
            contentView.addSubview(container)
            container.frame = CGRect(x: talentPadding, y: details.gg_bottom + 10, width: contentView.gg_width - 2 * talentPadding, height: 0)
            var totalWidth: CGFloat = 0
            var totalHeight: CGFloat = 0
            var labelX: CGFloat = 0
            var labelY: CGFloat = 0
            for (idx, talent) in info.talentList.enumerate() {
                let index = CGFloat(idx)
                let label = UILabel.createLabel(12, textColor: kGrayTextColor)
                label.textAlignment = .Center
                label.backgroundColor = UIColor.blackColor()
                label.text = talent.name
                container.addSubview(label)
                let size = (talent.name as NSString).sizeWithFonts(12)
                // 加边距
                let labelW = size.width + 15
                let labelH = size.height + 3
                if index > 0 {
                    labelX = totalWidth + padding
                }
                totalWidth = labelX + labelW
                if container.gg_width < totalWidth {
                    labelX = 0
                    totalWidth = labelW// + padding
                    labelY = labelH + padding + labelY
                }
                totalHeight = labelY + labelH
                label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            }
            container.gg_height = totalHeight
            
            // 线条底部布局
            let lineV = UIView()
            lineV.backgroundColor = kLineColor
            contentView.addSubview(lineV)
            lineV.snp.makeConstraints { (make) in
                make.left.equalTo(lineV.superview!).offset(kScale(15))
                make.right.equalTo(lineV.superview!).offset(kScale(-15))
                make.height.equalTo(1)
                make.top.equalTo(container.snp.bottom).offset(kScale(10))
            }
            
            praiseButton = UIButton()
            praiseButton.setImage(UIImage(named: "like"), forState: .Normal)
            praiseButton.setImage(UIImage(named: "like_chosen"), forState: .Selected)
            contentView.addSubview(praiseButton)
            praiseButton.snp.makeConstraints { (make) in
                make.left.equalTo(lineV)
                make.top.equalTo(lineV.snp.bottom).offset(kScale(10))
                make.size.equalTo(kSize(30, height: 30))
                make.bottom.lessThanOrEqualTo(praiseButton.superview!).offset(kScale(-15)).priorityLow()
            }
            
            shareButton = UIButton()
            shareButton.setImage(UIImage(named: "share"), forState: .Normal)
            contentView.addSubview(shareButton)
            shareButton.snp.makeConstraints { (make) in
                make.right.equalTo(shareButton.superview!).offset(kScale(-15))
                make.centerY.equalTo(praiseButton)
                make.size.equalTo(praiseButton)
            }
            
            let layout = UICollectionViewFlowLayout()
            layout.headerReferenceSize = CGSize(width: ScreenWidth, height: kScale(60))
            layout.itemSize = CGSize(width: (ScreenWidth - 2) / 3, height: kHeight(100))
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
            layout.minimumLineSpacing = 20
            layout.minimumInteritemSpacing = 0
            collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
            collectionView.backgroundColor = kBackgoundColor
            collectionView.delegate = self
            collectionView.dataSource = self
            contentView.addSubview(collectionView)
            collectionView.snp.makeConstraints { (make) in
                make.left.equalTo(praiseButton.snp.right).offset(kScale(10))
                make.right.equalTo(shareButton.snp.left).offset(kScale(-10))
                make.centerY.equalTo(praiseButton)
                make.height.equalTo(kScale(40))
            }
            
        }
    }
    
    var userInfo: DynamicResult! {
        didSet {
            headImgView.iconURL = userInfo.photo
            headImgView.setVimage(Util.userType(userInfo.detailsType))
            nameLabel.text = userInfo.name
            followButton.hidden = userInfo.follow == 1 ? true : false
        }
    }
    var player: BMPlayer!
    var praiseButton: UIButton!
    var shareButton: UIButton!
    var collectionView: UICollectionView!
    var headImgView: IconHeaderView!
    var nameLabel: UILabel!
    var timeLabel: UILabel!
    var bigImgView: UIImageView!
    var details: UILabel!
    var followButton: UIButton!
    
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
        followButton.setImage(UIImage(named: ""), forState: .Normal)
        followButton.setTitle("关注", forState: .Normal)
        followButton.setTitleColor(kCommonColor, forState: .Normal)
        followButton.titleLabel!.font = UIFont.customFontOfSize(10)
        followButton.layer.cornerRadius = kScale(23/2)
        followButton.layer.borderColor = kCommonColor.CGColor
        followButton.layer.borderWidth = 1
        contentView.addSubview(followButton)
        followButton.snp.makeConstraints { (make) in
            make.right.equalTo(followButton.superview!).offset(kScale(-16))
            make.size.equalTo(kSize(48, height: 23))
            make.centerY.equalTo(headImgView)
        }
        
        bigImgView = UIImageView()
        bigImgView.hidden = true
        contentView.addSubview(bigImgView)
        bigImgView.snp.makeConstraints { (make) in
            make.top.equalTo(headImgView.snp.bottom).offset(kScale(14))
            make.size.equalTo(CGSize(width: ScreenWidth, height: ScreenWidth))
            make.left.equalTo(bigImgView.superview!)
        }
        
        player = BMPlayer()
        player.hidden = true
        BMPlayerConf.allowLog = false
        BMPlayerConf.shouldAutoPlay = true
        BMPlayerConf.tintColor = UIColor.whiteColor()
        BMPlayerConf.topBarShowInCase = .HorizantalOnly
        BMPlayerConf.loaderType  = NVActivityIndicatorType.BallRotateChase
        contentView.addSubview(player)
        player.snp.makeConstraints { (make) in
            make.top.equalTo(headImgView.snp.bottom).offset(kScale(14))
            make.size.equalTo(CGSize(width: ScreenWidth, height: ScreenWidth))
            make.left.equalTo(player.superview!)
        }
        
        details = UILabel.createLabel(16, textColor: UIColor(hex: 0x666666))
        contentView.addSubview(details)
        details.snp.makeConstraints { (make) in
            make.top.equalTo(bigImgView.snp.bottom).offset(kScale(10))
            make.left.equalTo(headImgView)
            make.right.equalTo(details.superview!).offset(kScale(-15))
            make.height.equalTo(kScale(16))
        }
        layoutIfNeeded()
        
        followButton.rx_tap.subscribeNext {
            LogInfo("点击关注")
        }.addDisposableTo(disposeBag)
    }
    
    func preparePlayerItem(cover: String, url: String) -> BMPlayerItem {
        let resource0 = BMPlayerItemDefinitionItem(url: NSURL(string: url)!,
                                                   definitionName: "高清")
        
        let item    = BMPlayerItem(title: "",
                                   resource: [resource0,],
                                   cover: cover)
        return item
    }
    
    deinit {
        player.prepareToDealloc()
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DynamicDetailVideoCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
