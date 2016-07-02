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

class HomeViewController: YGBaseViewController {
    var tableView: UITableView!
    var infos = [BannerInfo]()
    var urls = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        Server.getFindNoticeList { (success, msg, value) in
            if success == true {
                LogInfo(value)
            } else {
                LogWarn(msg)
            }
        }
        
        setupSubViews()
    }
    
    func setupSubViews() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.registerClass(FollowPeopleCell.self, forCellReuseIdentifier: followCellIdentifier)
        tableView.separatorStyle = .None
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
        
        let banner = SDCycleScrollView(frame: CGRect(origin: CGPointZero, size: CGSize(width: ScreenWidth, height: kHeight(210))), delegate: self, placeholderImage: UIImage(named: ""))
        
        tableView.tableHeaderView = banner
    }
}

extension HomeViewController: SDCycleScrollViewDelegate {
    
}

extension HomeViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier(<#identifier#>, forIndexPath: indexPath) as! <#cell#>
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
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
//        Alamofire.request(.GET, "http://demosjz.ethank.com.cn/api/ad/get_ad_list").responseJSON { (response) in
//            switch response.result {
//            case .Success(let value):
//                let json = JSON(value)
//                let data = json["data"].arrayObject
//                data?.forEach({ (json) in
//                    let item = BannerInfo(json: JSON(json))
//                    self.urls.append(item.cover!)
//                })
//                self.bannerView.dataArray = self.urls
//            case .Failure(let error):
//                LogError(error)
//            }
//        }