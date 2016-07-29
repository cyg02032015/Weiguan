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

enum SelectSkillType: Int {
    case Back = 0, Tovc, View
}

class SelectSkillViewController: YGBaseViewController {

    
    typealias TapItemClosure = (item: PersonCharaterModel) -> Void
    var tapItem: TapItemClosure!
    var collectionView: UICollectionView!
    var type: SelectSkillType!
    lazy var imgStrings = ["help", "teach ", "accompany", "", ""]
    lazy var rowArray = [PersonCharaterModel]()
    lazy var selects = [Int]()
    lazy var skillButton = UIButton()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if type == SelectSkillType.Tovc {
             navigationController?.setNavigationBarHidden(false, animated: animated)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "选择才艺类型"
        setupSubViews()
        loadTalentType()
    }
    
    func setupSubViews() {
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize(width: ScreenWidth, height: kHeight(50))
        layout.itemSize = CGSize(width: (ScreenWidth - 30 - 24) / 4, height: kScale(24))
        layout.minimumLineSpacing = 11
        layout.minimumInteritemSpacing = 0
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
    
    func loadTalentType() {
        Server.releaseTalentSelectType { (success, msg, value) in
            if success {
                guard let data = value else { return }
                var pid1 = [PersonCharaterModel]()
                var pid2 = [PersonCharaterModel]()
                var pid3 = [PersonCharaterModel]()
                var pid4 = [PersonCharaterModel]()
                for character in data {
                    if character.pid == 1 {
                        pid1.append(PersonCharaterModel(pid: character.pid, id: character.id, name: character.name))
                    } else if character.pid == 2 {
                        pid2.append(PersonCharaterModel(pid: character.pid, id: character.id, name: character.name))
                    } else if character.pid == 3 {
                        pid3.append(PersonCharaterModel(pid: character.pid, id: character.id, name: character.name))
                    } else if character.pid == 4 {
                        pid4.append(PersonCharaterModel(pid: character.pid, id: character.id, name: character.name))
                    }
                }
                for character in data {
                    if character.id == 1 {
                        self.rowArray.append(PersonCharaterModel(pid: character.pid, id: character.id, name: character.name, result: pid1))
                    } else if character.id == 2 {
                        self.rowArray.append(PersonCharaterModel(pid: character.pid, id: character.id, name: character.name, result: pid2))
                    } else if character.id == 3 {
                        self.rowArray.append(PersonCharaterModel(pid: character.pid, id: character.id, name: character.name, result: pid3))
                    } else if character.id == 4 {
                        self.rowArray.append(PersonCharaterModel(pid: character.pid, id: character.id, name: character.name, result: pid4))
                    }
                }
                self.collectionView.reloadData()
            } else {
                LogError(msg!)
            }

        }
    }
    
    func tapItemInCollection(closure: TapItemClosure) {
        self.tapItem = closure
    }
}

extension SelectSkillViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return rowArray.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rowArray[section].result.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(SkillIdentifier, forIndexPath: indexPath) as! SkillCell
        let item = rowArray[indexPath.section].result[indexPath.row]
        cell.skill.setTitle(item.name, forState: .Normal)
        if self.selects.contains(item.id) {
            cell.skill.selected = true
            cell.skill.backgroundColor = kCommonColor
            self.skillButton = cell.skill
        } else {
            cell.skill.selected = false
            cell.skill.backgroundColor = kButtonGrayColor
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! SkillCell
        let item = rowArray[indexPath.section].result[indexPath.item]
        skillButton.selected = false
        skillButton.backgroundColor = kButtonGrayColor
        skillButton = cell.skill
        skillButton.selected = true
        skillButton.backgroundColor = kCommonColor
        selects.removeAll()
        selects.append(item.id)
        if type == SelectSkillType.Back {
            if tapItem != nil {
                self.tapItem(item: item)
            }
            delay (0.3) {
                self.navigationController?.popViewControllerAnimated(true)
            }
        } else if type == SelectSkillType.Tovc {
            let vc = EditSkillViewController()
            vc.skillType = item
            navigationController?.pushViewController(vc, animated: true)
        } else {
            
        }
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: SkillHeaderIdentifier, forIndexPath: indexPath) as! SkillHeaderReusableView
        headerView.imgView.image = UIImage(named: imgStrings[indexPath.section])
        headerView.label.text = rowArray[indexPath.section].name
        return headerView
    }
}


