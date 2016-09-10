//
//  RecommendHotmanTableViewCell.swift
//  OutLookers
//
//  Created by C on 16/7/3.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

public let recommendHotmanCollectionCellIdentifier = "recommendHotmanCollectionCellId"

class RecommendHotmanTableViewCell: UITableViewCell {

    var collectionView: UICollectionView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        layout.itemSize = kSize(150, height: 198)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 15, right: 15)
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.registerClass(RecommendHotmanCollectionCell.self, forCellWithReuseIdentifier: recommendHotmanCollectionCellIdentifier)
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(collectionView.superview!)
        }
    }
    
    func collectionViewSetDelegate(delegate: protocol<UICollectionViewDelegate, UICollectionViewDataSource>, indexPath: NSIndexPath) -> UICollectionView {
        collectionView.delegate = delegate
        collectionView.dataSource = delegate
        collectionView.reloadData()
        return collectionView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
