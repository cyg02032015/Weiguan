//
//  SelectSkillViewController.swift
//  OutLookers
//
//  Created by C on 16/6/19.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let SkillIdentifier = "skillId"
private let SkillHeaderIdentifier = "skillHeaderId"

class SelectSkillViewController: YGBaseViewController {

    
    typealias TapItemClosure = (text: String) -> Void
    var tapItem: TapItemClosure!
    var collectionView: UICollectionView!
    
    lazy var imgStrings = ["help", "teach ", "accompany"]
    lazy var titleStrings = ["帮帮我", "教教我", "陪陪我"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "选择才艺类型"
        setupSubViews()
    }
    
    func setupSubViews() {
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize(width: ScreenWidth, height: 50)
        layout.itemSize = CGSize(width: 80, height: 24)
        layout.minimumLineSpacing = 11
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 50, right: 15)
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.registerClass(SkillCell.self, forCellWithReuseIdentifier: SkillIdentifier)
        collectionView.registerClass(SkillHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: SkillHeaderIdentifier)
        
        collectionView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(collectionView.superview!)
        }
    }
    
    func tapItemInCollection(closure: TapItemClosure) {
        self.tapItem = closure
    }
}

extension SelectSkillViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(SkillIdentifier, forIndexPath: indexPath) as! SkillCell
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! SkillCell
        cell.skill.backgroundColor = kRedColor
        if tapItem != nil {
            guard let t = cell.skill.titleLabel?.text else { fatalError("text nil") }
            self.tapItem(text: t)
        }
        delay (0.3) {
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: SkillHeaderIdentifier, forIndexPath: indexPath) as! SkillHeaderReusableView
        headerView.imgView.image = UIImage(named: imgStrings[indexPath.section])
        headerView.label.text = titleStrings[indexPath.section]
        return headerView
    }
}

