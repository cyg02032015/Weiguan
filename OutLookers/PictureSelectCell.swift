//
//  PickerSelectCell.swift
//  OutLookers
//
//  Created by Youngkook on 16/6/23.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

public let releasePictureCollectionCellIdentifier = "releasePictureCollectionCellIdentifier"

class PictureSelectCell: UITableViewCell {

    var collectionView: UICollectionView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (ScreenWidth - 30 - 15) / 4, height: (ScreenWidth - 30 - 15) / 4)
        layout.minimumLineSpacing = 6
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 22, right: 15)
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.scrollEnabled = false
        contentView.addSubview(collectionView)
        collectionView.registerClass(PhotoCollectionCell.self, forCellWithReuseIdentifier: releasePictureCollectionCellIdentifier)
        
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(collectionView.superview!)
        }
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
