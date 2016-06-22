//
//  PhotoCollectionCell.swift
//  OutLookers
//
//  Created by Youngkook on 16/6/21.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//  发布通告里的collectionViewCell

import UIKit


protocol PhotoCollectionCellDelegate: class {
    func photoCellTapImage(sender: UITapGestureRecognizer)
}

class PhotoCollectionCell: UICollectionViewCell {
    
    var imgView: UIImageView!
    weak var delegate: PhotoCollectionCellDelegate!
    var img: UIImage? {
        didSet {
            imgView.image = img
        }
    }
    
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
            make.left.right.top.bottom.equalTo(imgView.superview!)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
