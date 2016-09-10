//
//  SelectPhotoCell.swift
//  OutLookers
//
//  Created by C on 16/6/19.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//  发布通告里的宣传图片

import UIKit

public let photoCollectionIdentifier = "photoCollectionId"

class SelectPhotoCell: UITableViewCell {
    var collectionView: UICollectionView!
    var label: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        label = UILabel()
        label.text = "宣传图片 (首张为封面)"
        label.font = UIFont.customFontOfSize(15)
        contentView.addSubview(label)
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (ScreenWidth - 30 - 15) / 3, height: kScale(63))
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 28, right: 15)
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.scrollEnabled = false
        contentView.addSubview(collectionView)
        collectionView.registerClass(PhotoCollectionCell.self, forCellWithReuseIdentifier: photoCollectionIdentifier)
    }
    
    override func layoutSubviews() {
        label.snp.makeConstraints { (make) in
            make.left.equalTo(label.superview!).offset(kScale(15))
            make.top.equalTo(label.superview!).offset(kScale(15))
            make.height.equalTo(kScale(15))
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(label.snp.bottom).offset(kScale(10))
            make.left.right.bottom.equalTo(collectionView.superview!)
        }
        super.layoutSubviews()
    }
    
    func collectionViewSetDelegate(delegate: protocol<UICollectionViewDelegate, UICollectionViewDataSource>, indexPath: NSIndexPath) {
        collectionView.delegate = delegate
        collectionView.dataSource = delegate
        collectionView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
