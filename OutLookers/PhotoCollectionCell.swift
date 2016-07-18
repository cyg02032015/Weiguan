//
//  PhotoCollectionCell.swift
//  OutLookers
//
//  Created by Youngkook on 16/6/21.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//  发布通告里的collectionViewCell

import UIKit

class PhotoCollectionCell: UICollectionViewCell {
    
    var imgView: UIImageView!
    var img: UIImage? {
        didSet {
            imgView.image = img
        }
    }
    
    var imgVideoCover: UIImageView!
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
        
        imgVideoCover = UIImageView(image: UIImage(named: "skill-1"))
        imgVideoCover.hidden = true
        imgVideoCover.userInteractionEnabled = true
        imgView.addSubview(imgVideoCover)
        imgVideoCover.snp.makeConstraints { (make) in
            make.centerY.equalTo(imgVideoCover.superview!)
            make.centerX.equalTo(imgVideoCover.superview!)
            make.size.equalTo(kSize(30, height: 30))
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
