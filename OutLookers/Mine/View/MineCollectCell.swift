//
//  MineCollectCell.swift
//  OutLookers
//
//  Created by C on 16/7/2.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

let mineCollectionCellIdentifier = "mineCollectionId"

class MineCollectCell: UITableViewCell {

    var collectionView: UICollectionView!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        
        setupSubViews()
    }
    
    func setupSubViews() {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: ScreenWidth / 4, height: kHeight(104))
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.scrollEnabled = false
        contentView.addSubview(collectionView)
        collectionView.registerClass(MineCollectionCell.self, forCellWithReuseIdentifier: mineCollectionCellIdentifier)
        
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
