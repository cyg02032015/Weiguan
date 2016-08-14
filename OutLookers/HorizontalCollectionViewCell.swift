//
//  HorizontalCollectionViewCell.swift
//  OutLookers
//
//  Created by C on 16/8/14.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let recommendHotmanTableViewCellIdentifier = "recommendHotmanTableViewCellId"

class HorizontalCollectionViewCell: UICollectionViewCell {
    
    var hotmanList: [HotmanList]! {
        didSet {
            LogDebug(hotmanList)
            if collectionView != nil {
                collectionView.reloadData()
            }
        }
    }
    var collectionView: UICollectionView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    func setupSubViews() {
        hotmanList = [HotmanList]()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = kSize(150, height: 195)
        layout.scrollDirection = .Horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 15, right: 15)
        layout.minimumLineSpacing = kScale(5)
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        contentView.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.registerClass(RecommendHotmanCollectionCell.self, forCellWithReuseIdentifier: recommendHotmanCollectionCellIdentifier)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(collectionView.superview!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HorizontalCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hotmanList.count > 8 ? 8 : hotmanList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(recommendHotmanCollectionCellIdentifier, forIndexPath: indexPath) as! RecommendHotmanCollectionCell
        cell.info = hotmanList[indexPath.item]
        return cell
    }
}
