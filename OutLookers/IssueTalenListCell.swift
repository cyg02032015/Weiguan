//
//  IssueTalenListCell.swift
//  OutLookers
//
//  Created by C on 16/8/21.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let SkillIdentifier = "skillId"
private let headerId = "headerId"

class IssueTalenListCell: UITableViewCell {

    typealias ConfigHeight = (height: CGFloat) -> Void
    typealias CategoryIds = (ids: String) -> Void
    var heightBlock: ConfigHeight!
    var categoryIdsBlock: CategoryIds!
    var info: [TalentResult]! {
        didSet {
            if info.count > 0 && collectionView != nil {
                collectionView.reloadData()
                if heightBlock != nil {
                    heightBlock(height: collectionView.collectionViewLayout.collectionViewContentSize().height)
                }
            }
        }
    }
    lazy var marks = [String]()
    var collectionView: UICollectionView!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        let layout = UICollectionViewLeftAlignedLayout()
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.scrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        contentView.addSubview(collectionView)
        collectionView.registerClass(SkillCell.self, forCellWithReuseIdentifier: SkillIdentifier)
        collectionView.registerClass(IssueTalentListHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(collectionView.superview!)
            make.bottom.equalTo(collectionView.superview!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension IssueTalenListCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateLeftAlignedLayout {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.info.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(SkillIdentifier, forIndexPath: indexPath) as! SkillCell
        cell.skill.setTitle(info[indexPath.item].categoryName, forState: .Normal)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let text = info[indexPath.item].categoryName
        let width = (text as NSString).sizeWithFonts(14).width + 24
        return CGSize(width: width, height: 24)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! SkillCell
        let id = info[indexPath.item].id
        if self.marks.contains(id) {
            self.marks.removeObject(id)
            self.marks.removeObject(id)
            cell.isSelect = false
        } else {
            self.marks.append(id)
            self.marks.append(id)
            cell.isSelect = true
        }
        
        if categoryIdsBlock != nil {
            let strs = self.marks.joinWithSeparator(",")
            categoryIdsBlock(ids: strs)
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 15, right: 15)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return kScale(10)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return kScale(10)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return kSize(contentView.gg_width, height: 46)
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let view = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: headerId, forIndexPath: indexPath) as! IssueTalentListHeader
            return view
        } else {
            return UICollectionReusableView()
        }
    }
    
}