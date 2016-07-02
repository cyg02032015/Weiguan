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
    
    var bannerView: YKBannerView!
    var infos = [BannerInfo]()
    var urls = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = UIButton(frame: CGRect(x: view.center.x, y: 80, width: 50, height: 30))
        btn.setTitle(LocalizedString("log"), forState: .Normal)
        btn.addTarget(self, action: #selector(HomeViewController.logClick(_:)), forControlEvents: .TouchUpInside)
        btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        view.addSubview(btn)

//        automaticallyAdjustsScrollViewInsets = false // 防止banner偏移64
//        bannerView = YKBannerView()
//        bannerView.placeHolderImage = UIImage(named: "ip5_1")
//        view.addSubview(bannerView)
//        bannerView.snp.makeConstraints { (make) in
//            make.left.right.equalTo(bannerView.superview!)
//            make.top.equalTo(self.snp.topLayoutGuideBottom)
//            make.height.equalTo(kSizeScale(250))
//        }
//        bannerView.startTapActionClosure { (index) in
//            print(index)
//        }
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
    }
    
    func logClick(sender: UIButton) {
        let logVC = FollowPeopleViewController()
        navigationController?.pushViewController(logVC, animated: true)
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