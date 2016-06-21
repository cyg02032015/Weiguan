//
//  PhotoCollectionCell.swift
//  OutLookers
//
//  Created by Youngkook on 16/6/21.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private extension Selector {
    static let tapImageView = #selector(PhotoCollectionCell.tapImageView(_:))
}

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
        imgView = UIImageView()
        imgView.userInteractionEnabled = true
        imgView.contentMode = .ScaleAspectFill
        contentView.addSubview(imgView)
        
        let tap = UITapGestureRecognizer(target: self, action: .tapImageView)
        imgView.addGestureRecognizer(tap)
        
        imgView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(imgView.superview!)
        }
    }
    
    func tapImageView(sender: UITapGestureRecognizer) {
        delegate.photoCellTapImage(sender)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
