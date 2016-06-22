//
//  SkillSetCell.swift
//  OutLookers
//
//  Created by C on 16/6/21.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//  才艺作品集

import UIKit

private let kLineGrayColor = UIColor(hex: 0xE4E4E4)

private extension Selector {
    static let tapSetCover = #selector(SkillSetCell.tapSetCover(_:))
    static let tapAddVideo = #selector(SkillSetCell.tapAddVideo(_:))
}

protocol SkillSetCellDelegate: class {
    func skillSetTapSetCover(sender: UIButton)
    func skillSetTapAddVideo(sender: UIButton)
}

class SkillSetCell: UITableViewCell {

    weak var delegate: SkillSetCellDelegate!
    var collectionView: UICollectionView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        let label = UILabel()
        label.text = "才艺作品集 (选填)"
        label.font = UIFont.systemFontOfSize(16)
        contentView.addSubview(label)
        
        let line1 = UIView()
        line1.backgroundColor = kLineGrayColor
        contentView.addSubview(line1)
        
        let setCoverLabel = UILabel()
        setCoverLabel.text = "设置封面"
        setCoverLabel.font = UIFont.systemFontOfSize(16)
        contentView.addSubview(setCoverLabel)
        
        let photoButton = UIButton()
        photoButton.setImage(UIImage(named: "release_announcement_Add pictures"), forState: .Normal)
        photoButton.addTarget(self, action: .tapSetCover, forControlEvents: .TouchUpInside)
        contentView.addSubview(photoButton)
        
        let line2 = UIView()
        line2.backgroundColor = kLineGrayColor
        contentView.addSubview(line2)
        
        let addVideoLabel = UILabel()
        addVideoLabel.text = "添加视频"
        addVideoLabel.font = UIFont.systemFontOfSize(16)
        contentView.addSubview(addVideoLabel)
        
        let videoButton = UIButton()
        videoButton.setImage(UIImage(named: "release_announcement_Add video"), forState: .Normal)
        videoButton.addTarget(self, action: .tapAddVideo, forControlEvents: .TouchUpInside)
        contentView.addSubview(videoButton)
        
        let line3 = UIView()
        line3.backgroundColor = kLineGrayColor
        contentView.addSubview(line3)
        
        let addPictureLabel = UILabel()
        addPictureLabel.text = "添加图片"
        addPictureLabel.font = UIFont.systemFontOfSize(16)
        contentView.addSubview(addPictureLabel)

        let layout = UICollectionViewFlowLayout()
        let scaleSize = (ScreenWidth - 30 - 20) / 5
        layout.itemSize = CGSize(width: scaleSize, height: scaleSize)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 59, right: 15)
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.scrollEnabled = false
        contentView.addSubview(collectionView)
        collectionView.registerClass(PhotoCollectionCell.self, forCellWithReuseIdentifier: photoCollectionIdentifier)
        
        
        label.snp.makeConstraints { (make) in
            make.left.top.equalTo(label.superview!).offset(15)
            make.height.equalTo(16)
        }
        
        line1.snp.makeConstraints { (make) in
            make.top.equalTo(label.snp.bottom).offset(15)
            make.height.equalTo(1)
            make.left.equalTo(label)
            make.right.equalTo(line1.superview!)
        }
        
        setCoverLabel.snp.makeConstraints { (make) in
            make.top.equalTo(line1.snp.bottom).offset(20)
            make.left.equalTo(label)
            make.height.equalTo(16)
        }
        
        photoButton.snp.makeConstraints { (make) in
            make.top.equalTo(setCoverLabel.snp.bottom).offset(15)
            make.left.equalTo(label)
            make.size.equalTo(CGSize(width: 70, height: 70))
        }
        
        line2.snp.makeConstraints { (make) in
            make.height.equalTo(line1)
            make.left.equalTo(label)
            make.top.equalTo(photoButton.snp.bottom).offset(20)
            make.right.equalTo(line1.superview!)
        }
        
        addVideoLabel.snp.makeConstraints { (make) in
            make.height.equalTo(16)
            make.left.equalTo(label)
            make.top.equalTo(line2.snp.bottom).offset(20)
        }
        
        videoButton.snp.makeConstraints { (make) in
            make.left.equalTo(label)
            make.top.equalTo(addVideoLabel.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 70, height: 70))
        }
        
        line3.snp.makeConstraints { (make) in
            make.left.equalTo(label)
            make.top.equalTo(videoButton.snp.bottom).offset(20)
            make.height.equalTo(line1)
            make.right.equalTo(line1.superview!)
        }
        
        addPictureLabel.snp.makeConstraints { (make) in
            make.top.equalTo(line3.snp.bottom).offset(20)
            make.height.equalTo(16)
            make.left.equalTo(label)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(addPictureLabel.snp.bottom).offset(15)
            make.left.right.equalTo(collectionView.superview!)
            make.height.equalTo(80)
        }
    }
    
    func tapSetCover(sender: UIButton) {
        delegate.skillSetTapSetCover(sender)
    }
    
    func tapAddVideo(sender: UIButton) {
        delegate.skillSetTapAddVideo(sender)
    }
    
    func collectionViewSetDelegate(delegate: protocol<UICollectionViewDelegate, UICollectionViewDataSource>, indexPath: NSIndexPath) {
        collectionView.delegate = delegate
        collectionView.dataSource = delegate
        collectionView.tag = indexPath.section
        collectionView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
