//
//  FansAuthViewController.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/20.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let fansAuthCellId = "fansAuthCellId"
private let fansHeadViewId = "fansHeadViewId"

class FansAuthViewController: YGBaseViewController {

    lazy var fans = [FollowList]()
    lazy var selects = [String]()
    var collectionView: UICollectionView!
    var commit: UIButton!
    var fansId: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        SVToast.show()
        loadMoreData()
        collectionView.mj_footer = MJRefreshBackStateFooter(refreshingBlock: { [weak self] in
            self?.loadMoreData()
        })
    }
    
    override func loadMoreData() {
        Server.myFollow(pageNo, urlStr: API.myFollow) { (success, msg, value) in
            SVToast.dismiss()
            if success {
                guard let object = value else {return}
                for (_, obj) in object.list.enumerate() {
                    if obj.detailsType == 1 || obj.detailsType == 2 {
                        self.fans.append(obj)
                    }
                }
                self.collectionView.mj_footer.endRefreshing()
                self.collectionView.reloadData()
                self.pageNo = self.pageNo + 1
                if object.list.count < 10 {
                    self.collectionView.mj_footer.endRefreshingWithNoMoreData()
                }
            } else {
                guard let m = msg else {return}
                SVToast.showWithError(m)
            }
        }
    }
    
    func setupSubViews() {
        title = "粉丝认证"
        commit = setRightNaviItem()
        commit.setTitle("提交", forState: .Normal)
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize(width: ScreenWidth, height: kScale(60))
        layout.itemSize = CGSize(width: (ScreenWidth - 2) / 3, height: kHeight(100))
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.backgroundColor = kBackgoundColor
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.registerClass(FansAuthCell.self, forCellWithReuseIdentifier: fansAuthCellId)
        collectionView.registerClass(FansHeadReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: fansHeadViewId)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(collectionView.superview!)
        }
    }
    
    override func tapMoreButton(sender: UIButton) {
        SVToast.show()
        Server.fansAuth(fansId) { (success, msg, value) in
            SVToast.dismiss()
            if success {
                SVToast.showWithSuccess("认证成功")
                delay(1) {
                    self.navigationController?.popToRootViewControllerAnimated(true)
                }
            } else {
                guard let m = msg else {return}
                SVToast.showWithError(m)
            }
        }
    }
    
    func checkParameters() {
        if !isEmptyString(fansId) {
            commit.setTitleColor(UIColor.blackColor(), forState: .Normal)
            commit.userInteractionEnabled = true
        } else {
            commit.setTitleColor(kGrayTextColor, forState: .Normal)
            commit.userInteractionEnabled = false
        }
    }
}

extension FansAuthViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fans.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(fansAuthCellId, forIndexPath: indexPath) as! FansAuthCell
        cell.info = fans[indexPath.item]
        if selects.contains("\(fans[indexPath.item].followUserId)") {
            cell.isSelect = true
        } else {
            cell.isSelect = false
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! FansAuthCell
        let info = fans[indexPath.item]
        if cell.isSelect == true {
            cell.isSelect = !cell.isSelect
            selects.removeObject("\(info.followUserId)")
        } else {
            if selects.count >= 3 {
                LogInfo("最多选3个")
                return
            }
            cell.isSelect = true
            selects.append("\(info.followUserId)")
        }
        fansId = selects.joinWithSeparator(",")
        checkParameters()
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: fansHeadViewId, forIndexPath: indexPath) as! FansHeadReusableView
        return headerView
    }
}



