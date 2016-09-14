//
//  PhotoCollectionCell.swift
//  OutLookers
//
//  Created by Youngkook on 16/6/21.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//  发布通告里的collectionViewCell

import UIKit

class PhotoCollectionCell: UICollectionViewCell {
    
    var info: List! {
        didSet {
            imgView.yy_setImageWithURL(info.url.addImagePath(kSize(imgView.gg_width, height: imgView.gg_height)), placeholder: kPlaceholder)
            if info.type == 0 {
                imgVideoCover.hidden = true
            } else {
                imgVideoCover.hidden = false
            }
        }
    }
    
    var settingView: UIView!
    var imgView: UIImageView!
    var img: UIImage? {
        didSet {
            imgView.image = img
        }
    }
    
    var imgVideoCover: UIImageView!
    var imgCoverSize: CGSize! {
        didSet {
            guard let cover = imgVideoCover else {return}
            cover.snp.updateConstraints { (make) in
                make.size.equalTo(imgCoverSize)
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    
    func setupSubViews() {
        contentView.userInteractionEnabled = true
        imgView = UIImageView()
        imgView.userInteractionEnabled = true
        imgView.clipsToBounds = true
        imgView.contentMode = .ScaleAspectFill
        contentView.addSubview(imgView)
        
        imgView.snp.makeConstraints { (make) in
            make.edges.equalTo(imgView.superview!)
        }
        
        imgVideoCover = UIImageView(image: UIImage(named: "play"))
        imgVideoCover.hidden = true
        imgVideoCover.userInteractionEnabled = true
        imgView.addSubview(imgVideoCover)
        imgVideoCover.snp.makeConstraints { (make) in
            make.centerY.equalTo(imgVideoCover.superview!)
            make.centerX.equalTo(imgVideoCover.superview!)
            make.size.equalTo(kSize(30, height: 30))
        }
        
        settingView = UIView()
        settingView.hidden = true
        settingView.backgroundColor = UIColor(r: 254, g: 78, b: 78, a: 0.7)
        imgView.addSubview(settingView)
        
        let smlImg = UIImageView(image: UIImage(named: "Set cover"))
        settingView.addSubview(smlImg)
        
        let label = UILabel()
        label.textAlignment = .Center
        label.font = UIFont.customFontOfSize(12)
        label.text = "设置封面";
        label.textColor = UIColor.whiteColor()
        settingView.addSubview(label)
        
        settingView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(settingView.superview!);
            make.height.equalTo(kScale(20))
        }
        
        smlImg.snp.makeConstraints { (make) in
            make.size.equalTo(kSize(20, height: 12.4))
            make.left.equalTo(smlImg.superview!).offset(kScale(6))
            make.centerY.equalTo(smlImg.superview!)
        }
        
        label.snp.makeConstraints { (make) in
            make.left.equalTo(smlImg.snp.right).offset(kScale(3))
            make.centerY.equalTo(label.superview!)
            make.height.equalTo(kScale(12))
        }
        layoutIfNeeded()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
