//
//  FansAuthViewController.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/20.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let fansAuthCellId = "fansAuthCellId"
private let fansHeadViewId = "fansHeadViewId"

class FansAuthViewController: YGBaseViewController {

    var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }
    
    func setupSubViews() {
        title = "粉丝认证"
        let commitButton = Util.createReleaseButton("提交")
        view.addSubview(commitButton)
        commitButton.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(commitButton.superview!)
            make.height.equalTo(kScale(44))
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize(width: ScreenWidth, height: kScale(60))
        layout.itemSize = CGSize(width: (ScreenWidth - 2) / 3, height: kHeight(100))
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.backgroundColor = kBackgoundColor
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.registerClass(FansAuthCell.self, forCellWithReuseIdentifier: fansAuthCellId)
        collectionView.registerClass(FansHeadReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: fansHeadViewId)
        collectionView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(collectionView.superview!)
            make.bottom.equalTo(commitButton.snp.top)
        }
    }
}

extension FansAuthViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(fansAuthCellId, forIndexPath: indexPath) as! FansAuthCell
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! FansAuthCell
        if cell.isSelect == true {
            cell.isSelect = !cell.isSelect
        } else {
            cell.isSelect = true
        }
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: fansHeadViewId, forIndexPath: indexPath) as! FansHeadReusableView
        return headerView
    }
}



