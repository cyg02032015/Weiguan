//
//  MyTalentCell.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/18.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private extension Selector {
    static let tapDelete = #selector(MyTalentCell.tapDelete(_:))
    static let tapEdit = #selector(MyTalentCell.tapEdit(_:))
    static let tapDetail = #selector(MyTalentCell.tapDetail(_:))
}

class MyTalentCell: UITableViewCell {

    var info: Result! {
        didSet {
            nameLabel.text = info.name
            moneyLabel.text = "\(info.price)" + Util.unit(info.unit)
            desc.text = info.details
            collectionView.reloadData()
        }
    }
    
    typealias DeleteClosure = (sender: UIButton) -> Void
    typealias EditClosure = (sender: UIButton) -> Void
    typealias DetailClosure = (sender: UIButton) -> Void
    private var deleteClosure: DeleteClosure!
    private var editClosure: EditClosure!
    private var detailClosure: DetailClosure!
    var nameLabel: UILabel!
    var moneyLabel: UILabel!
    var desc: UILabel!
    var collectionView: UICollectionView!
    var detailButton: UIButton!
    var editButton: UIButton!
    var deleteButton: UIButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        moneyLabel = UILabel.createLabel(16, textColor: UIColor(hex: 0x666666))
        moneyLabel.textAlignment = .Right
        contentView.addSubview(moneyLabel)
        moneyLabel.snp.makeConstraints { (make) in
            make.right.equalTo(moneyLabel.superview!).offset(kScale(-15))
            make.top.equalTo(moneyLabel.superview!).offset(kScale(13))
            make.height.equalTo(kScale(16))
        }
        
        nameLabel = UILabel()
        nameLabel.font = UIFont.customNumFontOfSize(16)
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.superview!).offset(kScale(16))
            make.centerY.equalTo(moneyLabel)
            make.height.equalTo(moneyLabel)
            make.right.equalTo(moneyLabel.snp.left).offset(kScale(-15))
        }
        
        let lineV1 = UIView()
        lineV1.backgroundColor = kLineColor
        contentView.addSubview(lineV1)
        lineV1.snp.makeConstraints { (make) in
            make.left.equalTo(lineV1.superview!).offset(kScale(15))
            make.right.equalTo(lineV1.superview!).offset(kScale(-15))
            make.top.equalTo(nameLabel.snp.bottom).offset(kScale(13))
            make.height.equalTo(1)
        }
        
        desc = UILabel.createLabel(14, textColor: UIColor(hex: 0x666666))
        desc.numberOfLines = 3
        contentView.addSubview(desc)
        desc.snp.makeConstraints { (make) in
            make.left.equalTo(desc.superview!).offset(kScale(15))
            make.right.equalTo(desc.superview!).offset(kScale(-15))
            make.top.equalTo(lineV1.snp.bottom).offset(kScale(14))
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (ScreenWidth - 15 - 40) / 4, height: (ScreenWidth - 15 - 40) / 4)
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.scrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.userInteractionEnabled = false   // 屏蔽掉collectionview与用户交互
        contentView.addSubview(collectionView)
        collectionView.registerClass(PhotoCollectionCell.self, forCellWithReuseIdentifier: releasePictureCollectionCellIdentifier)
        collectionView.snp.makeConstraints { (make) in
            make.left.right.equalTo(collectionView.superview!)
            make.top.equalTo(desc.snp.bottom).offset(kScale(20))
            make.height.equalTo((ScreenWidth - 15 - 40) / 4)
        }

        let lineV2 = UIView()
        lineV2.backgroundColor = kLineColor
        contentView.addSubview(lineV2)
        lineV2.snp.makeConstraints { (make) in
            make.left.equalTo(lineV1.superview!).offset(kScale(15))
            make.right.equalTo(lineV1.superview!).offset(kScale(-15))
            make.top.equalTo(collectionView.snp.bottom).offset(kScale(20))
            make.height.equalTo(1)
        }
        
        deleteButton = UIButton()
        deleteButton.setTitle("删除", forState: .Normal)
        deleteButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        deleteButton.addTarget(self, action: .tapDelete, forControlEvents: .TouchUpInside)
        deleteButton.layer.borderColor = UIColor.blackColor().CGColor
        deleteButton.layer.borderWidth = 1
        deleteButton.layer.cornerRadius = kScale(4)
        deleteButton.titleLabel!.font = UIFont.customFontOfSize(14)
        contentView.addSubview(deleteButton)
        deleteButton.snp.makeConstraints { (make) in
            make.right.equalTo(deleteButton.superview!).offset(kScale(-15))
            make.top.equalTo(lineV2.snp.bottom).offset(kScale(6))
            make.size.equalTo(kSize(80, height: 28))
            make.bottom.lessThanOrEqualTo(deleteButton.superview!).offset(kScale(-6))
        }
        
        editButton = UIButton()
        editButton.setTitle("编辑", forState: .Normal)
        editButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        editButton.addTarget(self, action: .tapEdit, forControlEvents: .TouchUpInside)
        editButton.layer.borderColor = UIColor.blackColor().CGColor
        editButton.layer.borderWidth = 1
        editButton.layer.cornerRadius = kScale(4)
        editButton.titleLabel!.font = UIFont.customFontOfSize(14)
        contentView.addSubview(editButton)
        editButton.snp.makeConstraints { (make) in
            make.right.equalTo(deleteButton.snp.left).offset(kScale(-6))
            make.centerY.equalTo(deleteButton)
            make.size.equalTo(deleteButton)
        }
        
        detailButton = UIButton()
        detailButton.setTitle("查看详情", forState: .Normal)
        detailButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        detailButton.addTarget(self, action: .tapDetail, forControlEvents: .TouchUpInside)
        detailButton.layer.borderColor = UIColor.blackColor().CGColor
        detailButton.layer.borderWidth = 1
        detailButton.layer.cornerRadius = kScale(4)
        detailButton.titleLabel!.font = UIFont.customFontOfSize(14)
        contentView.addSubview(detailButton)
        detailButton.snp.makeConstraints { (make) in
            make.right.equalTo(editButton.snp.left).offset(kScale(-6))
            make.centerY.equalTo(deleteButton)
            make.size.equalTo(deleteButton)
        }
    }
    
    func tapDelete(sender: UIButton) {
        if deleteClosure != nil {
            deleteClosure(sender: sender)
        }
    }
    
    func tapEdit(sender: UIButton) {
        if editClosure != nil {
            editClosure(sender: sender)
        }
    }
    
    func tapDetail(sender: UIButton) {
        if detailClosure != nil {
            detailClosure(sender: sender)
        }
    }
    
    func deleteBlock(closure: DeleteClosure) {
        deleteClosure = closure
    }
    
    func editBlock(closure: EditClosure) {
        editClosure = closure
    }
    
    func detailBlock(closure: DetailClosure) {
        detailClosure = closure
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyTalentCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return info.list.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(releasePictureCollectionCellIdentifier, forIndexPath: indexPath) as! PhotoCollectionCell
        cell.backgroundColor = UIColor.grayColor()
        cell.info = info.list[indexPath.item]
        return cell
    }
}
