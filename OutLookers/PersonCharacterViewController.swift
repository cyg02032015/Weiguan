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
    var result = [PersonCharaterModel]()
    init(pid: Int, id: Int, name: String, result: [PersonCharaterModel] = []) {
        self.pid = pid
        self.id = id
        self.name = name
        self.result = result
    }
}

extension PersonCharaterModel: Equatable {}

func ==(lhs: PersonCharaterModel, rhs: PersonCharaterModel) -> Bool {
    return lhs.pid == rhs.pid && lhs.id == rhs.id && lhs.name == rhs.name && lhs.result == lhs.result
}

protocol PersonCharacterDelegate: class {
    func characterSendValue(obj: [String:[PersonCharaterModel]])
}

class PersonCharacterViewController: YGBaseViewController {
    
    weak var delegate: PersonCharacterDelegate!
    typealias TapItemClosure = (text: String) -> Void
    var tapItem: TapItemClosure!
    var collectionView: UICollectionView!
    lazy var imgStrings = ["help", "teach ", "accompany"]
    lazy var optionTitles = ["（可多选）", "（可多选）", "", "（可多选）", "", ""]
    lazy var rowArray = [PersonCharaterModel]()
    lazy var selectStyles = [PersonCharaterModel]()
    lazy var selectLooks = [PersonCharaterModel]()
    lazy var selectShape = [PersonCharaterModel]()
    lazy var selectCharm = [PersonCharaterModel]()
    lazy var shapeButton = UIButton()
    var save: UIButton!
    var selectParam: [String: [PersonCharaterModel]]! {
        get {
            return [
            "1": selectStyles,
            "2": selectLooks,
            "3": selectShape,
            "4": selectCharm
            ]
        }
        set {
            selectStyles = newValue["1"]!
            selectLooks = newValue["2"]!
            selectShape = newValue["3"]!
            selectCharm = newValue["4"]!
            [
                "1": selectStyles,
                "2": selectLooks,
                "3": selectShape,
                "4": selectCharm
            ]
        }
    }
    
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
        loadData()
    }
    
    func loadData() {
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
        save = setRightNaviItem()
        save.setTitle("保存", forState: .Normal)
        save.userInteractionEnabled = true
        save.setTitleColor(UIColor.blackColor(), forState: .Normal)
        save.rx_tap.subscribeNext { [unowned self] in
            if self.delegate != nil {
                self.delegate.characterSendValue(self.selectParam)
            }
            self.navigationController?.popViewControllerAnimated(true)
        }.addDisposableTo(disposeBag)
        
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
        return rowArray[section].result.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(SkillIdentifier, forIndexPath: indexPath) as! SkillCell
        var sectionModel = rowArray[indexPath.section]
        let rowModel = sectionModel.result[indexPath.item]
        let id = "\(sectionModel.id)"
        cell.skill.setTitle(rowModel.name, forState: .Normal)
        cell.row = indexPath.item
        cell.section == indexPath.section
        
        if let styles = selectParam[id] where id == "1" {
            if styles.contains(rowModel) {
                cell.isSelect = true
            } else {
                cell.isSelect = false
            }
        } else if let looks = selectParam[id] where id == "2" {
            if looks.contains(rowModel) {
                cell.isSelect = true
            } else {
                cell.isSelect = false
            }
        } else if let shapes = selectParam[id] where id == "3" {
            if shapes.contains(rowModel) {
                cell.isSelect = true
            } else {
                cell.isSelect = false
            }
        } else {
            if selectParam[id]!.contains(rowModel) {
                cell.isSelect = true
            } else {
                cell.isSelect = false
            }
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! SkillCell
        var section = rowArray[indexPath.section]
        let id = "\(section.id)"
        let info = section.result[indexPath.row]
        if var styles = selectParam[id] where id == "1" {
            if cell.isSelect == true {
                cell.isSelect = !cell.isSelect
                styles.removeObject(info)
                selectParam[id] = styles
            } else {
                if styles.count >= 3 {
                    return
                }
                cell.isSelect = true
                styles.append(info)
                selectParam[id] = styles
            }
        } else if var looks = selectParam[id] where id == "2" {
            if cell.isSelect == true {
                cell.isSelect = !cell.isSelect
                looks.removeObject(info)
                selectParam[id] = looks
            } else {
                if looks.count >= 3 {
                    return
                }
                cell.isSelect = true
                looks.append(info)
                selectParam[id] = looks
            }
        } else if var shapes = selectParam[id] where id == "3" {
            shapeButton.selected = false
            shapeButton.backgroundColor = kLightGrayColor
            shapeButton = cell.skill
            cell.skill.selected = true
            cell.skill.backgroundColor = kCommonColor
            shapes.removeAll()
            shapes.append(info)
            selectParam[id] = shapes
        } else if var charms = selectParam[id] where id == "4" {
            if cell.isSelect == true {
                cell.isSelect = !cell.isSelect
                charms.removeObject(info)
                selectParam[id] = charms
            } else {
                if charms.count >= 3 {
                    return
                }
                cell.isSelect = true
                charms.append(info)
                selectParam[id] = charms
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: personCharacterHeadViewId, forIndexPath: indexPath) as! PersonCharacterHeadView
        headerView.title.text = rowArray[indexPath.section].name
        headerView.option.text = optionTitles[indexPath.section]
        return headerView
    }
}


