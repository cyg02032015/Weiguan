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

let praiseListCollectionCellId = "praiseListCollectionCellId"

protocol DynamicDetailDelegate: class {
    func dynamicDetailTapShare(sender: UIButton)
    func dynamicDetailTapFollow(sender: UIButton)
    func dynamicDetailTapPraise(sender: UIButton)
    func dynamicDetailTapComment(sender: UIButton)
}

class DynamicDetailVideoCell: UITableViewCell {
    var lastImgView: UIImageView!
    weak var tableView: UITableView!
    var isSelf: Bool = false
    var playerButton: UIButton!
    var clickHeaderIcon: ((String) -> Void)?
    var isFollow: IsFollowData? {
        didSet {
            followButton.hidden = isFollow!.concerned == 1
        }
    }
    
    var toTalentClick: ((Int) -> Void)?
    var info: DynamicDetailResp! {
        didSet {
            guard let _ = info.pictureList.first?.url else {return}
            timeLabel.text = info.createTime.dateFromString()?.getShowFormat()
            followButton.hidden = isSelf
            if shareButton != nil {
                return
            }
            // 图片还是视频
            var imgView: UIImageView!
            if info.isVideo == "1" {  // 图片
                playerView.hidden = true
                if info.pictureList.count > 0 {
                    for obj in info.pictureList {
                        imgView = UIImageView()
                        imgView.yy_setImageWithURL(obj.url.addImagePath(CGSize(width: 1080, height: 1080)), placeholder: kPlaceholder)
                        contentView.addSubview(imgView)
                        imgView.snp.makeConstraints(closure: { (make) in
                            make.top.equalTo(self.lastImgView == nil ? headImgView.snp.bottom : self.lastImgView.snp.bottom).offset(self.lastImgView == nil ? kScale(14) : 10)
                            make.left.right.equalTo(imgView.superview!)
                            make.height.equalTo(ScreenWidth * CGFloat(obj.height) / CGFloat(obj.width))
                        })
                        lastImgView = imgView
                    }
                }
            } else { // 视频
                playerView.hidden = false
                playerView.yy_setImageWithURL(info.cover.addImagePath(kSize(ScreenWidth, height: ScreenWidth)), placeholder: kPlaceholder)
            }

            if !isEmptyString(info.text) {
                details = UILabel.createLabel(16, textColor: UIColor(hex: 0x666666))
                contentView.addSubview(details)
                details.numberOfLines = 0
                details.text = info.text
                details.snp.makeConstraints(closure: { (make) in
                make.left.equalTo(details.superview!).offset(kScale(15))
                    make.right.equalTo(details.superview!).offset(kScale(-15))
                    if info.isVideo == "1" {
                        make.top.equalTo(imgView.snp.bottom).offset(kScale(8))
                    } else {
                        make.top.equalTo(playerView.snp.bottom).offset(kScale(8))
                    }
                    //make.height.equalTo(kScale(16))
                })
            }
            
            layoutIfNeeded()
            
            // talent tags 实现
            let xpadding: CGFloat = 20
            let ypadding: CGFloat = 8
            let container = UIView()
            contentView.addSubview(container)
            var containerY: CGFloat!
            if details == nil {
                if info.isVideo == "1" {
                    containerY = imgView.gg_bottom
                } else {
                    containerY = playerView.gg_bottom
                }
            } else {
                containerY = details.gg_bottom
            }
            if info.talentList.count > 0 {
                containerY = containerY + 10
            }
            container.frame = CGRect(x: talentPadding, y: containerY, width: contentView.gg_width - 2 * talentPadding, height: 0)
            var totalWidth: CGFloat = 0
            var totalHeight: CGFloat = 0
            var labelX: CGFloat = 0
            var labelY: CGFloat = 0
            for (idx, talent) in info.talentList.enumerate() {
                let index = CGFloat(idx)
                let label = UIButton()
                label.titleLabel!.font = UIFont.customFontOfSize(12)
                label.setTitleColor(UIColor(hex: 0xFA8B37), forState: .Normal)
                label.layer.cornerRadius = kScale(20/2)
                label.layer.borderColor = UIColor(hex: 0xFA8B37).CGColor
                label.layer.borderWidth = 1
                label.setTitle(talent.name, forState: .Normal)
                _ = label.rx_tap.subscribeNext({ [unowned self](sender) in
                    if let _ = self.toTalentClick {
                        self.toTalentClick!(idx)
                    }
                })
                container.addSubview(label)
                let size = (talent.name as NSString).sizeWithFonts(12)
                // 加边距
                let labelW = size.width + 15
                let labelH = size.height + 3
                if index > 0 {
                    labelX = totalWidth + xpadding
                }
                totalWidth = labelX + labelW
                if container.gg_width < totalWidth {
                    labelX = 0
                    totalWidth = labelW// + padding
                    labelY = labelH + ypadding + labelY
                }
                totalHeight = labelY + labelH
                label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            }
            container.gg_height = totalHeight
            
            let commentButton = UIButton()
            commentButton.setImage(UIImage(named: "comment"), forState: .Normal)
            contentView.addSubview(commentButton)
            commentButton.snp.makeConstraints { (make) in
                make.centerX.equalTo(commentButton.superview!)
                make.size.equalTo(kSize(30, height: 30))
                make.top.equalTo(container.snp.bottom).offset(kScale(13))
            }
            
            let praiseButton = UIButton()
            praiseButton.setImage(UIImage(named: "like"), forState: .Normal)
            praiseButton.setImage(UIImage(named: "likecopy"), forState: .Selected)
            contentView.addSubview(praiseButton)
            praiseButton.snp.makeConstraints { (make) in
                make.right.equalTo(commentButton.snp.left).offset(kScale(-40))
                make.size.equalTo(commentButton)
                make.centerY.equalTo(commentButton)
            }
            praiseButton.selected = info.isLike == 1
            
            shareButton = UIButton()
            shareButton.setImage(UIImage(named: "shareR"), forState: .Normal)
            contentView.addSubview(shareButton)
            shareButton.snp.makeConstraints { (make) in
                make.left.equalTo(commentButton.snp.right).offset(kScale(40))
                make.size.equalTo(commentButton)
                make.centerY.equalTo(commentButton)
            }
            
            // 线条底部布局
            let lineV = UIView()
            lineV.backgroundColor = kLineColor
            contentView.addSubview(lineV)
            lineV.snp.makeConstraints { (make) in
                make.left.equalTo(lineV.superview!).offset(kScale(15))
                make.right.equalTo(lineV.superview!).offset(kScale(-15))
                make.height.equalTo(1)
                make.top.equalTo(commentButton.snp.bottom).offset(kScale(15))
            }
            
            collectionView.snp.makeConstraints { (make) in
                make.top.equalTo(lineV.snp.bottom)
                make.left.equalTo(collectionView.superview!).offset(kScale(15))
                make.right.equalTo(collectionView.superview!).offset(kScale(-15))
                make.height.equalTo(kScale(40))
                make.bottom.lessThanOrEqualTo(collectionView.superview!).priorityLow()
            }

            commentButton.rx_tap.subscribeNext { [unowned self] in
                if self.delegate != nil {
                    self.delegate.dynamicDetailTapComment(commentButton)
                }
            }.addDisposableTo(disposeBag)
            
            praiseButton.rx_tap.subscribeNext { [unowned self] in
                if self.delegate != nil {
                    self.delegate.dynamicDetailTapPraise(praiseButton)
                }
            }.addDisposableTo(disposeBag)
            
            shareButton.rx_tap.subscribeNext { [unowned self] in
                if self.delegate != nil {
                    self.delegate.dynamicDetailTapShare(self.shareButton)
                }
            }.addDisposableTo(disposeBag)
        }
    }
    
    var userInfo: DynamicResult! {
        didSet {
            headImgView.iconURL = userInfo.photo.addImagePath(kSize(35, height: 35))
            headImgView.setVimage(Util.userType(userInfo.detailsType))
            nameLabel.text = userInfo.name
        }
    }
    
    var likeListInfo: LikeListResp! {
        didSet {
            self.likeLists = likeListInfo.lists
            collectionView.reloadData()
        }
    }
    lazy var likeLists = [LikeList]()
    weak var delegate: DynamicDetailDelegate!
    var playerView: UIImageView!
    var praiseButton: UIButton!
    var shareButton: UIButton!
    var collectionView: UICollectionView!
    var headImgView: IconHeaderView!
    var nameLabel: UILabel!
    var timeLabel: UILabel!
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
        followButton.setImage(UIImage(named: "follow11"), forState: .Normal)
        followButton.setTitleColor(kCommonColor, forState: .Normal)
        followButton.titleLabel!.font = UIFont.customFontOfSize(10)
        contentView.addSubview(followButton)
        followButton.snp.makeConstraints { (make) in
            make.right.equalTo(followButton.superview!).offset(kScale(-16))
            make.size.equalTo(kSize(50, height: 20))
            make.centerY.equalTo(headImgView)
        }

        playerView = UIImageView()
        playerView.tag = 111
        playerView.userInteractionEnabled = true
        playerView.backgroundColor = .blackColor()
        contentView.addSubview(playerView)
        playerView.snp.makeConstraints { (make) in
            make.top.equalTo(headImgView.snp.bottom).offset(kScale(14))
            make.size.equalTo(CGSize(width: ScreenWidth, height: ScreenWidth))
            make.left.equalTo(playerView.superview!)
        }
        playerButton = UIButton()
        playerButton.setImage(UIImage(named: "play"), forState: .Normal)
        playerView.addSubview(playerButton)
        playerButton.snp.makeConstraints { [unowned self](make) in
            make.centerX.centerY.equalTo(self.playerView)
            make.size.equalTo(kSize(50, height: 50))
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScale(24), height: kHeight(24))
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 6
        layout.minimumInteritemSpacing = 5
        layout.scrollDirection = .Horizontal
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.delegate = self
        collectionView.dataSource = self
        contentView.addSubview(collectionView)
        collectionView.registerClass(PraiseListCollectionViewCell.self, forCellWithReuseIdentifier: praiseListCollectionCellId)
        
        followButton.rx_tap.subscribeNext { [unowned self] in
            if self.delegate != nil {
                self.delegate.dynamicDetailTapFollow(self.followButton)
            }
        }.addDisposableTo(disposeBag)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DynamicDetailVideoCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.likeLists.count + 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(praiseListCollectionCellId, forIndexPath: indexPath) as! PraiseListCollectionViewCell
        if self.likeLists.count == indexPath.item {
            cell.header.iconURL = nil
            cell.header.setVimage(Util.userType(4))
            cell.showCountlabel(true, count: "\(self.likeLists.count)")
        } else {
            cell.info = likeLists[indexPath.item]
            cell.showCountlabel(false, count: "")
            cell.header.iconHeaderTap({ [unowned self] in
                guard let _ = self.clickHeaderIcon else { return }
                let likeData = self.likeLists[indexPath.item]
                self.clickHeaderIcon!(likeData.userId)
            })
        }
        return cell
    }
}
