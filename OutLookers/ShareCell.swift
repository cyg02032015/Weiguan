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
    func shareCellReturnsMarks(marks: [String])
}

class ShareCell: UITableViewCell {

    var collectionView: UICollectionView!
    var tuple = ([UIImage](), [UIImage](), [String]()) {
        didSet {
            collectionView.reloadData()
        }
    }
    weak var delegate: ShareCellDelegate!
    lazy var marks = [String]()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        let label = UILabel()
        label.text = "同步到:"
        label.font = UIFont.systemFontOfSize(16)
        contentView.addSubview(label)
        
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 30, height: 38)
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
            make.left.equalTo(15)
            make.top.equalTo(28)
            make.height.equalTo(16)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.left.equalTo(label.snp.right).offset(2)
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
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! ShareCollectionCell
        guard let title = cell.label.text else { fatalError("share button title is nil") }
        if cell.shareButton.selected {
            cell.shareButton.selected = false
            for (i, obj) in marks.enumerate() {
                if obj == title {
                    marks.removeAtIndex(i)
                }
            }
        } else {
            cell.shareButton.selected = true
            marks.append(title)
        }
        delegate.shareCellReturnsMarks(marks)
    }
}
