//
//  HomeViewController.swift
//  OutLookers
//
//  Created by C on 16/6/15.
//  Copyright © 2016年 youngkook. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

private let recommendHotmanTableViewCellIdentifier = "recommendHotmanTableViewCellId"
private let homeCellId = "homeCellId"
private let headerId = "headerId"
private let circleId = "circelId"
private let horizontalId = "horizontalId"

class HomeViewController: YGBaseViewController {
    var collectionView: UICollectionView!
    lazy var banners = [BannerList]()
    var urls = [String]()
    var statusView: UIView!
    lazy var hotmanList = [HotmanList]()
    var recommendObj: DynamicListResp!
    lazy var recommends = [DynamicResult]()
    var banner: SDCycleScrollView!
    
    var timeStr: String!

    override func viewWillAppear(animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageNo = 0
        NSNotificationCenter.defaultCenter().rx_notification(kRecieveGlobleDefineNotification)
        .subscribeNext { [unowned self](notification) in
            // MARK: banner
            Server.banner { (success, msg, value) in
                if success {
                    guard let list = value else {return}
                    var imgUrls = [String]()
                    for item in list {
                        imgUrls.append(item.picture)
                    }
                    self.banners = value!
                    if self.banner != nil {
                        self.banner.imageURLStringsGroup = imgUrls
                    }
                } else {
                    guard let m = msg else {return}
                    SVToast.showWithError(m)
                }
            }
            

            self.timeStr = NSDate().stringFromNowDate()
            Server.dynamicList(self.pageNo,user: UserSingleton.sharedInstance.userId,state: 1, isPerson: false, isHome:
            true, isSquare: false, timeStr: self.timeStr) { (success, msg, value) in
                if success {
                    Server.homeRecommendHotman { (success, msg, value) in
                        SVToast.dismiss()
                        if success {
                            guard let list = value else { return }
                            self.hotmanList = list
                            self.collectionView.reloadData()
                        } else {
                            LogError(msg)
                        }
                    }
                    guard let object = value else { return }
                    self.recommendObj = object
                    self.recommends.appendContentsOf(object.list)
                    self.collectionView.reloadData()
                    self.pageNo = self.pageNo + 1
                } else {
                    SVToast.dismiss()
                    guard let m = msg else {return}
                    SVToast.showWithError(m)
                }
            }
        }.addDisposableTo(disposeBag)
        
        setupSubViews()
        
        collectionView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        collectionView.mj_header = MJRefreshStateHeader(refreshingBlock: { [weak self] in
            self?.loadNewData()
        })
        collectionView.mj_footer = MJRefreshBackStateFooter(refreshingBlock: { [weak self] in
            self?.loadMoreData()
        })
    }
    
    func loadNewData() {
        self.pageNo = 0
        self.timeStr = NSDate().stringFromNowDate()
        Server.dynamicList(self.pageNo, user: UserSingleton.sharedInstance.userId ,state: 1, isPerson: false, isHome: true, isSquare: false, timeStr: timeStr) { (success, msg, value) in
            if success {
                guard let object = value else { return }
                self.recommendObj = object
                self.recommends.removeAll()
                self.recommends.appendContentsOf(object.list)
                self.collectionView.reloadData()
                if object.list.count <= 0 {
                    self.collectionView.mj_footer.endRefreshingWithNoMoreData()
                }
                self.collectionView.mj_header.endRefreshing()
            } else {
                self.collectionView.mj_header.endRefreshing()
                guard let m = msg else {return}
                SVToast.showWithError(m)
            }
        }

    }
    
    override func loadMoreData() {
        Server.dynamicList(pageNo,user: UserSingleton.sharedInstance.userId ,state: 1, isPerson: false, isHome: true, isSquare: false, timeStr: self.timeStr) { (success, msg, value) in
            self.collectionView.mj_footer.endRefreshing()
            if success {
                guard let object = value else { return }
                if object.list.count <= 0 {
                    self.collectionView.mj_footer.endRefreshingWithNoMoreData()
                    return
                }
                self.recommendObj = object
                self.recommends.appendContentsOf(object.list)
                self.collectionView.reloadData()
                self.pageNo = self.pageNo + 1
            } else {
                guard let m = msg else {return}
                SVToast.showWithError(m)
            }
        }
    }
    
    func setupSubViews() {
        automaticallyAdjustsScrollViewInsets =  false
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.registerClass(HorizontalCollectionViewCell.self, forCellWithReuseIdentifier: horizontalId)
        collectionView.registerClass(HomeCollectionCell.self, forCellWithReuseIdentifier: homeCellId)
        collectionView.registerClass(RecommendHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView.registerClass(CircleHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: circleId)
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(collectionView.superview!)
            make.top.equalTo(collectionView.superview!).offset(-20)
        }
        statusView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 20))
        statusView.backgroundColor = UIColor(r: 255, g: 255, b: 255, a: 0.0)
        view.addSubview(statusView)
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .Portrait
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        } else if section == 1 {
            return 1
        } else {
            return recommends.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            return UICollectionViewCell()
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(horizontalId, forIndexPath: indexPath) as! HorizontalCollectionViewCell
            cell.hotmanList = hotmanList
            cell.collectionViewDidSelectedItem = { [weak self](view, idPath) in
                let vc = PHViewController()
                vc.user = self?.hotmanList[idPath.item].userId
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(homeCellId, forIndexPath: indexPath) as! HomeCollectionCell
                cell.info = recommends[indexPath.item]
            cell.delegate = self
            return cell
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 2 {
            let obj = recommends[indexPath.item]
            let vc = DynamicDetailViewController()
            let cell = collectionView.cellForItemAtIndexPath(indexPath) as! HomeCollectionCell
            vc.shareImage = cell.backImgView.image
            vc.dynamicObj = obj
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
//        if section == 2 {
//            return UIEdgeInsets(top: 0, left: 0, bottom: TabbarHeight, right: 0)
//        } else {
            return UIEdgeInsetsZero
//        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: ScreenWidth, height: ScreenWidth * 2 / 3)
        } else {
            return CGSize(width: ScreenWidth, height: kHeight(43))
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSizeZero
        }
        if indexPath.section == 1 {
            return CGSize(width: ScreenWidth, height: kHeight(213))
        } else {
            return CGSize(width: (ScreenWidth - 3) / 2, height: kHeight(240))
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else if section == 1 {
            return 0
        } else {
            return kHeight(15)
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            let header = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: circleId, forIndexPath: indexPath) as! CircleHeaderView
            self.banner = header.banner
            header.banner.delegate = self
            return header
        } else {
            let header = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: headerId, forIndexPath: indexPath) as! RecommendHeaderView
            
            if indexPath.section == 1 {
                header.label.text = "红人推荐"
            } else {
                header.label.text = "热门推荐"
            }
            return header
        }
    }
}



extension HomeViewController {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY > 100 {
            statusView.backgroundColor = UIColor(r: 255, g: 255, b: 255, a: offsetY/100)
        } else {
            statusView.backgroundColor = UIColor(r: 255, g: 255, b: 255, a: offsetY/100)
        }
    }
}

extension HomeViewController: HeaderImageViewDelegate {
    func touchHeaderImageView(cell: HomeCollectionCell) {
        let indexPath = self.collectionView.indexPathForCell(cell)!
        let obj = recommends[indexPath.item]
        let vc = PHViewController()
        vc.user = "\(obj.userId)"
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: SDCycleScrollViewDelegate {
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didSelectItemAtIndex index: Int) {
        LogInfo(index)
    }
}

