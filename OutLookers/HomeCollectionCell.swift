//
//  HomeCollectionCell.swift
//  OutLookers
//
//  Created by C on 16/8/14.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
private extension Selector {
    static let tapHeadImg = #selector(HomeCollectionCell.tapHeadImg)
}

protocol HeaderImageViewDelegate: class {
    func touchHeaderImageView(cell: HomeCollectionCell) -> Void
}

class HomeCollectionCell: UICollectionViewCell {
    
    var info: DynamicResult! {
        didSet {
            backImgView.yy_setImageWithURL(info.cover.addImagePath(), placeholder: kPlaceholder)
            headImgView.yy_setImageWithURL(info.photo.addImagePath(kSize(32, height: 32)), placeholder: kPlaceholder)
            nameLabel.text = info.name
            detailLabel.text = info.text
            praiseLabel.text = "\(info.likeCount)"
        }
    }
    
    weak var delegate: HeaderImageViewDelegate?
    var backImgView: UIImageView!
    var headImgView: TouchImageView!
    var nameLabel: UILabel!
    var praiseImgView: UIImageView!
    var praiseLabel: UILabel!
    var detailLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    func setupSubViews() {
        backImgView = UIImageView()
        backImgView.contentMode = .ScaleAspectFill
        backImgView.clipsToBounds = true
        contentView.addSubview(backImgView)
        backImgView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(backImgView.superview!)
            make.height.equalTo(kScale(186))
        }
        
        headImgView = TouchImageView()
        headImgView.clipsToBounds = true
        headImgView.layer.cornerRadius = kScale(32/2)
        headImgView.addTarget(self, action: .tapHeadImg)
        contentView.addSubview(headImgView)
        headImgView.snp.makeConstraints { (make) in
            make.left.equalTo(headImgView.superview!).offset(kScale(10))
            make.size.equalTo(kSize(32, height: 32))
            make.top.equalTo(backImgView.snp.bottom).offset(kScale(-10))
        }
        
        praiseLabel = UILabel.createLabel(12, textColor: kLightGrayColor)
        praiseLabel.textAlignment = .Right
        contentView.addSubview(praiseLabel)
        praiseLabel.snp.makeConstraints { (make) in
            make.right.equalTo(praiseLabel.superview!).offset(kScale(-10))
            make.top.equalTo(backImgView.snp.bottom).offset(kScale(6))
            make.height.equalTo(kScale(12))
        }
        
        praiseImgView = UIImageView()
        praiseImgView.image = UIImage(named: "like")
        contentView.addSubview(praiseImgView)
        praiseImgView.snp.makeConstraints { (make) in
            make.right.equalTo(praiseLabel.snp.left).offset(kScale(-4))
            make.size.equalTo(kSize(12, height: 12))
            make.top.equalTo(backImgView.snp.bottom).offset(kScale(4))
        }
        
        nameLabel = UILabel.createLabel(12, textColor: kGrayColor)
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(headImgView.snp.right).offset(kScale(6))
            make.top.equalTo(backImgView.snp.bottom).offset(kScale(6))
            make.height.equalTo(kScale(12))
            make.right.equalTo(praiseImgView.snp.left).offset(kScale(-5))
        }

        
        detailLabel = UILabel.createLabel(14)
        contentView.addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(detailLabel.superview!).offset(kScale(15))
            make.right.equalTo(detailLabel.superview!).offset(kScale(-5))
            make.top.equalTo(headImgView.snp.bottom).offset(kScale(8))
        }
    }
    
    func tapHeadImg() {
        delegate?.touchHeaderImageView(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
