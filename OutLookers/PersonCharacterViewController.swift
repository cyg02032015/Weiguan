//
//  SelectSkillViewController.swift
//  OutLookers
//
//  Created by C on 16/6/19.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let SkillIdentifier = "skillId"
private let personCharacterHeadViewId = "personCharacterHeadViewId"

struct PersonCharaterModel {
    var pid: Int!
    var id: Int!
    var name: String!
    lazy var result = [PersonCharaterModel]()
    init(pid: Int, id: Int, name: String, result: [PersonCharaterModel] = []) {
        self.pid = pid
        self.id = id
        self.name = name
        self.result = result
    }
}

class PersonCharacterViewController: YGBaseViewController {
    
    
    typealias TapItemClosure = (text: String) -> Void
    var tapItem: TapItemClosure!
    var collectionView: UICollectionView!
    lazy var imgStrings = ["help", "teach ", "accompany"]
//    lazy var sectionModel = [PersonCharaterModel]()
    lazy var optionTitles = ["（可多选）", "（可多选）", "", "（可多选）", "", ""]
    lazy var dataSources = [PersonCharacter]()
    lazy var rowArray = [PersonCharaterModel]()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "选择才艺类型"
        
        setupSubViews()
        Server.getPersonCharacter { (success, msg, value) in
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
    
    func setupSubViews() {
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize(width: ScreenWidth, height: kHeight(60))
        layout.itemSize = CGSize(width: (ScreenWidth - 30 - 45) / 4, height: kScale(24))
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 15, right: 15)
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.contentInset = UIEdgeInsets(top: kScale(-10), left: 0, bottom: 0, right: 0)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.registerClass(SkillCell.self, forCellWithReuseIdentifier: SkillIdentifier)
        collectionView.registerClass(PersonCharacterHeadView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: personCharacterHeadViewId)
        
        collectionView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(collectionView.superview!)
        }
    }
    
    func tapItemInCollection(closure: TapItemClosure) {
        self.tapItem = closure
    }
}

extension PersonCharacterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return rowArray.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var sectionModel = rowArray[section]
        if section == 0 && sectionModel.result[0].pid == 1 {
            return sectionModel.result.count
        } else if section == 1 && sectionModel.result[1].pid == 2 {
            return sectionModel.result.count
        } else if section == 2 && sectionModel.result[2].pid == 3 {
            return sectionModel.result.count
        } else {
            return sectionModel.result.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(SkillIdentifier, forIndexPath: indexPath) as! SkillCell
        var sectionModel = rowArray[indexPath.section]
        if indexPath.section == 0 {
            cell.skill.setTitle(sectionModel.result[indexPath.item].name, forState: .Normal)
        } else if indexPath.section == 1 {
            cell.skill.setTitle(sectionModel.result[indexPath.item].name, forState: .Normal)
        } else if indexPath.section == 2 {
            cell.skill.setTitle(sectionModel.result[indexPath.item].name, forState: .Normal)
        } else {
            cell.skill.setTitle(sectionModel.result[indexPath.item].name, forState: .Normal)
        }
        cell.row = indexPath.item
        cell.section == indexPath.section
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! SkillCell
        cell.skill.backgroundColor = kCommonColor
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: personCharacterHeadViewId, forIndexPath: indexPath) as! PersonCharacterHeadView
        headerView.title.text = rowArray[indexPath.section].name
        headerView.option.text = optionTitles[indexPath.section]
        return headerView
    }
}


