//
//  YGShare.swift
//  OutLookers
//
//  Created by C on 16/8/6.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let shareVcellId = "shareVcellId"

private extension Selector {
    static let tapView = #selector(YGShare.tapView(_:))
    static let tapCancel = #selector(YGShare.tapCancel(_:))
}

class YGShare: UIView {

    var container: UIView!
    var cancel: UIButton!
    var collectionView: UICollectionView!
    var imgs = [UIImage]()
    var titles = [String]()
    var containerHeight: CGFloat = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, imgs: [UIImage], titles: [String]) {
        self.init(frame: frame)
        self.imgs = imgs
        self.titles = titles
        setupSubViews()
    }
    
    func setupSubViews() {
        
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        let tap = UITapGestureRecognizer(target: self, action: .tapView)
        addGestureRecognizer(tap)
        
        if titles.count <= 4 {
            containerHeight = kScale(168)
        } else {
            containerHeight = kScale(250)
        }
        
        container = UIView()
        container.backgroundColor = UIColor.whiteColor()
        addSubview(container)
        
        container.snp.makeConstraints { (make) in
            make.height.equalTo(containerHeight)
            make.left.right.equalTo(container.superview!)
            make.bottom.equalTo(container.superview!).offset(containerHeight).priorityLow()
        }
        
        cancel = UIButton()
        cancel.setTitle("取消", forState: .Normal)
        cancel.setTitleColor(UIColor.blackColor(), forState: .Normal)
        cancel.layer.cornerRadius = kScale(4)
        cancel.backgroundColor = kBackgoundColor
        cancel.addTarget(self, action: .tapCancel, forControlEvents: .TouchUpInside)
        container.addSubview(cancel)
        
        cancel.snp.makeConstraints { (make) in
            make.left.equalTo(cancel.superview!).offset(kScale(15))
            make.right.equalTo(cancel.superview!).offset(kScale(-15))
            make.height.equalTo(kScale(40))
            make.bottom.equalTo(cancel.superview!).offset(kScale(-13))
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (ScreenWidth - 78 - kScale(38) * 3) / 4, height: kScale(67))
        layout.sectionInset = UIEdgeInsets(top: 28, left: 38, bottom: 20, right: 38)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = kScale(38)
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        container.addSubview(collectionView)
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.registerClass(ShareVCell.self, forCellWithReuseIdentifier: shareVcellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(collectionView.superview!)
            make.bottom.equalTo(cancel.snp.top)
        }
    }
    
    func animation() {
        guard let view = UIApplication.sharedApplication().keyWindow else {
            LogError("keyWindow is nil")
            return
        }
        view.addSubview(self)
        
        self.snp.makeConstraints { (make) in
            make.edges.equalTo(self.superview!)
        }
        
        delay(0.05) { 
            self.container.snp.updateConstraints { (make) in
                make.bottom.equalTo(self.container.superview!)
            }
            self.setNeedsUpdateConstraints()
            self.updateConstraints()
            UIView.animateWithDuration(0.3) {
                self.layoutIfNeeded()
                self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
            }
        }
        
    }
    
    func tapCancel(sender: UIButton) {
        if self.superview == nil {
            LogError("picker does not superview")
            return
        }
        container.snp.updateConstraints { (make) in
            make.bottom.equalTo(container.superview!).offset(containerHeight)
        }
        setNeedsUpdateConstraints()
        updateConstraints()
        UIView.animateWithDuration(0.3, animations: {
            self.layoutIfNeeded()
            self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        }) { (isCompleted) in
            self.removeFromSuperview()
        }
    }
    
    func tapSure(sender: UIButton) {
        if self.superview == nil {
            LogError("picker does not superview")
            return
        }
        container.snp.updateConstraints { (make) in
            make.bottom.equalTo(container.superview!).offset(containerHeight)
        }

        setNeedsUpdateConstraints()
        updateConstraints()
        UIView.animateWithDuration(0.3, animations: {
            self.layoutIfNeeded()
            self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        }) { (isCompleted) in
            self.removeFromSuperview()
        }
    }
    
    func tapView(sender: UITapGestureRecognizer) {
        if self.superview == nil {
            LogError("picker does not superview")
            return
        }
        container.snp.updateConstraints { (make) in
            make.bottom.equalTo(container.superview!).offset(containerHeight)
        }
        setNeedsUpdateConstraints()
        updateConstraints()
        UIView.animateWithDuration(0.3, animations: {
            self.layoutIfNeeded()
            self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        }) { (isCompleted) in
            self.removeFromSuperview()
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension YGShare: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.titles.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(shareVcellId, forIndexPath: indexPath) as! ShareVCell
        cell.shareButton.setImage(self.imgs[indexPath.item], forState: .Normal)
        cell.label.text = self.titles[indexPath.item]
        return cell
    }
}

class ShareVCell: UICollectionViewCell {
    
    var shareButton: UIButton!
    var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    func setDataWithShare(selectImage: UIImage, unSelectImage: UIImage, title: String) {
        shareButton.setImage(selectImage, forState: .Normal)
        label.text = title
    }
    
    func setupSubViews() {
        shareButton = UIButton()
        shareButton.userInteractionEnabled = false
        contentView.addSubview(shareButton)
        
        label = UILabel()
        label.textAlignment = .Center
        label.font = UIFont.customFontOfSize(10)
        label.textColor = UIColor(hex: 0x777777)
        contentView.addSubview(label)
        
        shareButton.snp.makeConstraints { (make) in
            make.top.equalTo(shareButton.superview!)
            make.centerX.equalTo(shareButton.superview!)
            make.size.equalTo(kSize(50, height: 50))
        }
        
        label.snp.makeConstraints { (make) in
            make.left.right.equalTo(label.superview!)
            make.top.equalTo(shareButton.snp.bottom).offset(kScale(7))
            make.height.equalTo(kScale(10))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
