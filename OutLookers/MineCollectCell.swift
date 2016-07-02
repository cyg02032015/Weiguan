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
        let lineV = UIView()
        lineV.backgroundColor = kLineColor
        contentView.addSubview(lineV)
        lineV.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(lineV.superview!)
            make.height.equalTo(0.5)
        }
        let lineBottom = UIView()
        lineBottom.backgroundColor = kLineColor
        contentView.addSubview(lineBottom)
        lineBottom.snp.makeConstraints { (make) in
            make.bottom.equalTo(lineBottom.superview!)
            make.height.equalTo(0.5)
            make.left.right.equalTo(lineBottom.superview!)
        }
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (ScreenWidth - 2) / 4, height: kHeight(103))
        layout.minimumLineSpacing = 0.25
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.backgroundColor = kLineColor
        collectionView.scrollEnabled = false
        contentView.addSubview(collectionView)
        collectionView.registerClass(MineCollectionCell.self, forCellWithReuseIdentifier: mineCollectionCellIdentifier)
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(lineV.snp.bottom)
            make.left.right.equalTo(collectionView.superview!)
            make.bottom.equalTo(lineBottom.snp.top)
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
