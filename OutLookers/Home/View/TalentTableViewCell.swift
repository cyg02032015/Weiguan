//
//  TalentTableViewCell.swift
//  OutLookers
//
//  Created by C on 16/7/6.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

public let talentWorksCollectionCellIdentifier = "talentWorksCollectionCellId"

class TalentTableViewCell: UITableViewCell {

    typealias DetailClosure = (sender: UIButton) -> Void
    typealias ShareClosure = (sender: UIButton) -> Void
    
    var info: Result! {
        didSet {
            talentLabel.text = info.name
            moneyDayLabel.text = "\(info.price)\(Util.unit(info.unit))"
            detailsLabel.text = info.details
            collectionView.reloadData()
        }
    }
    private var detailClosure: DetailClosure!
    private var shareClosure: ShareClosure!
    lazy var works = [String]()
    var talentLabel: UILabel!       //  时装模特
    var moneyDayLabel: UILabel!     //  1000/天
    var detailsLabel: UILabel!      //  3行字
    var collectionView: UICollectionView!
    var seeDetail: UIButton!        //  查看详情
    var share: UIButton!            //  分享
    
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
        
        let introLabel = UILabel()
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
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = kSize(320, height: 324)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .Horizontal
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        contentView.addSubview(collectionView)
        collectionView.registerClass(PhotoCollectionCell.self, forCellWithReuseIdentifier: talentWorksCollectionCellIdentifier)
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(worksLabel.snp.bottom).offset(kScale(15))
            make.left.right.equalTo(collectionView.superview!)
            make.height.equalTo(kScale(324))
        }

        seeDetail = UIButton()
        seeDetail.layer.cornerRadius = kScale(24/2)
        seeDetail.layer.borderColor = UIColor(hex: 0x666666).CGColor
        seeDetail.layer.borderWidth = 1
        seeDetail.setTitle("查看详情", forState: .Normal)
        seeDetail.setTitleColor(UIColor(hex: 0x666666), forState: .Normal)
        seeDetail.titleLabel?.font = UIFont.customFontOfSize(14)
        contentView.addSubview(seeDetail)
        seeDetail.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom).offset(kScale(20))
            make.size.equalTo(kSize(80, height: 24))
            make.centerX.equalTo(seeDetail.superview!).offset(kScale(-50))
            make.bottom.lessThanOrEqualTo(seeDetail.superview!).offset(kScale(-20))
        }
        
        share = UIButton()
        share.layer.cornerRadius = kScale(24/2)
        share.layer.borderColor = UIColor(hex: 0x666666).CGColor
        share.layer.borderWidth = 1
        share.setTitle("分享", forState: .Normal)
        share.setTitleColor(UIColor(hex: 0x666666), forState: .Normal)
        share.titleLabel?.font = UIFont.customFontOfSize(14)
        contentView.addSubview(share)
        share.snp.makeConstraints { (make) in
            make.centerY.equalTo(seeDetail)
            make.size.equalTo(seeDetail)
            make.left.equalTo(seeDetail.snp.right).offset(kScale(20))
        }
        introLabel.text = "才艺介绍"
        worksLabel.text = "才艺作品集"
        
        seeDetail.rx_tap.subscribeNext {
            if self.detailClosure != nil {
                self.detailClosure(sender: self.seeDetail)
            }
        }.addDisposableTo(disposeBag)
        
        share.rx_tap.subscribeNext {
            if self.shareClosure != nil {
                self.shareClosure(sender: self.share)
            }
        }.addDisposableTo(disposeBag)
    }
    
    func detailBlock(closure: DetailClosure) {
        detailClosure = closure
    }
    
    func shareBlock(closure: ShareClosure) {
        shareClosure = closure
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension TalentTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return info.list.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(talentWorksCollectionCellIdentifier, forIndexPath: indexPath) as! PhotoCollectionCell
        cell.imgCoverSize = kSize(73, height: 73)
        cell.info = info.list[indexPath.item]
        return cell
    }
}