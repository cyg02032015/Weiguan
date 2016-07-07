//
//  TalentTableViewCell.swift
//  OutLookers
//
//  Created by C on 16/7/6.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class TalentTableViewCell: UITableViewCell {

    var talentLabel: UILabel!       //  时装模特
    var moneyDayLabel: UILabel!     //  1000/天
    var introLabel: UILabel!        //  才艺介绍
    var detailsLabel: UILabel!      //  3行字
    var collectionView: UICollectionView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        talentLabel = UILabel()
        talentLabel.font = UIFont.customFontOfSize(16)
        contentView.addSubview(talentLabel)
        talentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(talentLabel.superview!).offset(kScale(18))
            make.left.equalTo(talentLabel.superview!).offset(kScale(15))
            make.height.equalTo(kScale(16))
        }
        
        moneyDayLabel = UILabel()
        moneyDayLabel.font = UIFont.customFontOfSize(16)
        moneyDayLabel.textColor = UIColor(hex: 0x3b3b3b)
        moneyDayLabel.textAlignment = .Right
        contentView.addSubview(moneyDayLabel)
        moneyDayLabel.snp.makeConstraints { (make) in
            make.right.equalTo(moneyDayLabel.superview!).offset(kScale(-51))
            make.centerY.equalTo(talentLabel)
            make.height.equalTo(kScale(16))
        }
        
        let lineV = UIView()
        lineV.backgroundColor = kLineColor
        contentView.addSubview(lineV)
        lineV.snp.makeConstraints { (make) in
            make.left.equalTo(lineV.superview!).offset(kScale(15))
            make.right.equalTo(lineV.superview!).offset(kScale(-15))
            make.top.equalTo(talentLabel.snp.bottom).offset(kScale(15))
            make.height.equalTo(1)
        }
        
        let blueView = UIView()
        blueView.backgroundColor = kCommonColor
        contentView.addSubview(blueView)
        blueView.snp.makeConstraints { (make) in
            make.left.equalTo(blueView.superview!).offset(kScale(16))
            make.top.equalTo(talentLabel.snp.bottom).offset(kScale(14))
            make.size.equalTo(kSize(62, height: 2))
        }
        
        introLabel = UILabel()
        introLabel.font = UIFont.customFontOfSize(14)
        contentView.addSubview(introLabel)
        introLabel.snp.makeConstraints { (make) in
            make.top.equalTo(lineV.snp.bottom).offset(kScale(19))
            make.left.equalTo(talentLabel)
            make.height.equalTo(kScale(14))
        }
        
        detailsLabel = UILabel()
        detailsLabel.font = UIFont.customFontOfSize(13)
        detailsLabel.numberOfLines = 3
        contentView.addSubview(detailsLabel)
        //  行间距有可能要设置
        detailsLabel.snp.makeConstraints { (make) in
            make.left.equalTo(introLabel)
            make.top.equalTo(introLabel.snp.bottom).offset(kScale(11))
            make.right.equalTo(detailsLabel.superview!).offset(kScale(-15))
        }
        
        let lineV2 = UIView()
        lineV2.backgroundColor = kLineColor
        contentView.addSubview(lineV2)
        lineV2.snp.makeConstraints { (make) in
            make.left.right.equalTo(lineV)
            make.height.equalTo(lineV)
            make.top.equalTo(detailsLabel.snp.bottom).offset(kScale(20))
        }
        
        let worksLabel = UILabel()
        worksLabel.font = UIFont.customFontOfSize(14)
        contentView.addSubview(worksLabel)
        worksLabel.snp.makeConstraints { (make) in
            make.left.equalTo(lineV2)
            make.top.equalTo(lineV2.snp.bottom).offset(15)
            make.height.equalTo(kScale(14))
        }
        
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: (ScreenWidth - 30 - 15) / 4, height: (ScreenWidth - 30 - 15) / 4)
//        layout.minimumLineSpacing = 6
//        layout.minimumInteritemSpacing = 5
//        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 22, right: 15)
//        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
//        collectionView.backgroundColor = UIColor.whiteColor()
//        collectionView.scrollEnabled = false
//        contentView.addSubview(collectionView)
//        collectionView.registerClass(PhotoCollectionCell.self, forCellWithReuseIdentifier: releasePictureCollectionCellIdentifier)
//        
//        collectionView.snp.makeConstraints { (make) in
//            make.edges.equalTo(collectionView.superview!)
//        }

        
        talentLabel.text = "时装模特"
        moneyDayLabel.text = "1000/天"
        introLabel.text = "才艺介绍"
        detailsLabel.text = "才艺介绍才艺介绍才艺介绍才艺介绍才艺介绍才艺介绍才艺介绍才艺介绍才艺介绍才艺介绍才艺介绍才艺介绍才艺介绍才艺介绍才艺介绍"
        worksLabel.text = "才艺作品集"
        
        
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
