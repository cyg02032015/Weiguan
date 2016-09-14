//
//  ShareCell.swift
//  OutLookers
//
//  Created by Youngkook on 16/6/24.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

let shareCollectionIdentifier = "shareCollectionId"

protocol ShareCellDelegate: class {
    func shareCellReturnsShareTitle(text: String, selected: Bool)
}

class ShareCell: UITableViewCell {
    lazy var shareButton = UIButton()
    var collectionView: UICollectionView!
    var isFirst: Bool = true
    var tuple = ([UIImage](), [UIImage](), [String]()) {
        didSet {
            if isFirst {
                isFirst = false
                collectionView.reloadData()
//                collectionView(collectionView, didSelectItemAtIndexPath: NSIndexPath(forItem: 0, inSection: 0))

            }
        }
    }
    weak var delegate: ShareCellDelegate!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        let label = UILabel()
        label.text = "同步到:"
        label.font = UIFont.customFontOfSize(16)
        contentView.addSubview(label)
        
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = kSize(30, height: 38)
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.scrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        contentView.addSubview(collectionView)
        collectionView.registerClass(ShareCollectionCell.self, forCellWithReuseIdentifier: shareCollectionIdentifier)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(kScale(15))
            make.top.equalTo(kScale(28))
            make.height.equalTo(kScale(16))
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.left.equalTo(label.snp.right).offset(kScale(2))
            make.top.bottom.right.equalTo(collectionView.superview!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension ShareCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tuple.0.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(shareCollectionIdentifier, forIndexPath: indexPath) as! ShareCollectionCell
        cell.setDataWithShare(tuple.0[indexPath.item], unSelectImage: tuple.1[indexPath.item], title: tuple.2[indexPath.item])
        if indexPath.item == 0 {
            cell.shareButton.selected = true
            shareButton = cell.shareButton
            guard let title = cell.label.text else {fatalError("获取分享按钮失败")}
            delegate.shareCellReturnsShareTitle(title, selected: true)
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! ShareCollectionCell
        guard let title = cell.label.text else { LogError("获取分享按钮title nil") ; return }
        if shareButton != cell.shareButton {
            shareButton.selected = false
            shareButton = cell.shareButton
            cell.shareButton.selected = true
            delegate.shareCellReturnsShareTitle(title, selected: true)
        } else {
            if shareButton.selected {
                cell.shareButton.selected = false
                delegate.shareCellReturnsShareTitle(title, selected: false)
            } else {
                cell.shareButton.selected = true
                shareButton = cell.shareButton
                delegate.shareCellReturnsShareTitle(title, selected: true)
            }
        }
    }
}
