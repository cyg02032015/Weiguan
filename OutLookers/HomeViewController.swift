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

private extension Selector {
    static let loadRecommendHotmanData = #selector(HomeViewController.loadRecommendHotmanData)
}

class HomeViewController: YGBaseViewController {
    var tableView: UITableView!
    var infos = [BannerInfo]()
    var urls = [String]()
    var statusView: UIView!
    lazy var hotmanList = [HotmanList]()
    var recommendObj: DynamicListResp!
    lazy var recommends = [DynamicResult]()
    var collectionView: UICollectionView!
    var log: YGLogView!

    override func viewWillAppear(animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        log = YGLogView(frame: CGRectZero)
        log.tapLogViewClosure { (type) in
            switch type {
            case .Wechat:
                let vc = LogViewController()
                self.navigationController?.pushViewController(vc, animated: true)
                LogInfo("微信登录")
            case .QQ: LogInfo("QQ登录")
            case .Weibo: LogInfo("微博登录")
            case .Phone: LogInfo("手机登录")
            case .Iagree: LogInfo("同意协议")
            case .Register: LogInfo("注册")
            }
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: .loadRecommendHotmanData, name: kRecieveGlobleDefineNotification, object: nil)
        setupSubViews()
        tableView.mj_footer = MJRefreshBackStateFooter(refreshingBlock: { 
            self.loadMoreData()
        })
    }
    
    override func loadMoreData() {
        
        Server.dynamicList(pageNo, state: 2, isPerson: false, isHome: true, isSquare: false) { (success, msg, value) in
            self.tableView.mj_footer.endRefreshing()
            if success {
                guard let object = value else { return }
                if object.list.count <= 0 {
                    self.tableView.mj_footer.endRefreshingWithNoMoreData()
                    return
                }
                self.recommendObj = object
                self.recommends.appendContentsOf(object.list)
                self.tableView.reloadData()
                self.pageNo = self.pageNo + 1
            } else {
                guard let m = msg else {return}
                SVToast.showWithError(m)
            }
        }
    }
    
    func loadRecommendHotmanData() {
        Server.dynamicList(pageNo, state: 2, isPerson: false, isHome: true, isSquare: false) { (success, msg, value) in
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
                self.tableView.reloadData()
                self.pageNo = self.pageNo + 1
            } else {
                SVToast.dismiss()
                guard let m = msg else {return}
                SVToast.showWithError(m)
            }
        }
    }
    
    func setupSubViews() {
//        self.automaticallyAdjustsScrollViewInsets = false // the behavior of the UICollectionViewFlowLayout is not defined because: fix
        tableView = UITableView(frame: CGRectZero, style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = kBackgoundColor
        tableView.estimatedRowHeight = kHeight(500)
        view.addSubview(tableView)
        tableView.registerClass(RecommendHotmanTableViewCell.self, forCellReuseIdentifier: recommendHotmanTableViewCellIdentifier)
        tableView.registerClass(HomeCell.self, forCellReuseIdentifier: homeCellId)
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(tableView.superview!)
            make.top.equalTo(tableView.superview!).offset(-20)
        }
        
        // 轮播图
        let banner = SDCycleScrollView(frame: CGRect(origin: CGPointZero, size: CGSize(width: ScreenWidth, height: kHeight(210))), delegate: self, placeholderImage: UIImage(named: ""))
        banner.pageDotImage = UIImage(named: "home_point_normal")
        banner.currentPageDotImage = UIImage(named: "home_point_chosen")
        banner.pageControlDotSize = kSize(6, height: 6)
        banner.pageControlAliment = SDCycleScrollViewPageContolAlimentRight
        tableView.tableHeaderView = banner
        Alamofire.request(.GET, "http://demosjz.ethank.com.cn/api/ad/get_ad_list").responseJSON { (response) in
            switch response.result {
            case .Success(let value):
                let json = JSON(value)
                let data = json["data"].arrayObject
                data?.forEach({ (json) in
                    let item = BannerInfo(json: JSON(json))
                    self.urls.append(item.cover!)
                })
                banner.imageURLStringsGroup = self.urls
            case .Failure(let error):
                LogError(error)
            }
        }
        
        
        statusView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 20))
        statusView.backgroundColor = UIColor(r: 255, g: 255, b: 255, a: 0.0)
        view.addSubview(statusView)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

extension HomeViewController: SDCycleScrollViewDelegate {
    
}

// MARK: - UITableViewDelegate,UITableViewDataSource
extension HomeViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return recommends.count + 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(recommendHotmanTableViewCellIdentifier, forIndexPath: indexPath) as! RecommendHotmanTableViewCell
            if collectionView == nil {
                self.collectionView = cell.collectionViewSetDelegate(self, indexPath: indexPath)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(homeCellId, forIndexPath: indexPath) as! HomeCell
            cell.info = recommends[indexPath.section - 1]
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let obj = recommends[indexPath.section - 1]
        let vc = DynamicDetailViewController()
        vc.dynamicObj = obj
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 1
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return kHeight(213)
        } else {
            return UITableViewAutomaticDimension
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let header = RecommendHeaderView(frame: CGRect(origin: CGPointZero, size: CGSize(width: ScreenWidth, height: kHeight(43))))
            return header
        } else {
            let view = UIView()
            view.backgroundColor = kBackgoundColor
            return view
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return kHeight(43)
        } else {
            return kHeight(10)
        }
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
//        return hotmanList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(recommendHotmanCollectionCellIdentifier, forIndexPath: indexPath) as! RecommendHotmanCollectionCell
//        cell.info = hotmanList[indexPath.item]
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.item == 0 {
            let phvc = PHViewController()
            self.navigationController?.pushViewController(phvc, animated: true)
        } else if indexPath.item == 1 {
            let vc = OrganizationViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
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

struct BannerInfo {
    var cover: String?
    var identifier: String?
    var url: String?
    
    init (json: JSON) {
        self.cover = json["cover"].string
        self.identifier = json["id"].string
        self.url = json["url"].string
    }
}
