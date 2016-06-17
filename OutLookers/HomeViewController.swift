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
        automaticallyAdjustsScrollViewInsets = false
        bannerView = YKBannerView()
        bannerView.placeHolderImage = UIImage(named: "ip5_1")
        view.addSubview(bannerView)
        
        bannerView.snp.makeConstraints { (make) in
            make.left.right.equalTo(bannerView.superview!)
            make.top.equalTo(self.snp.topLayoutGuideBottom)
            make.height.equalTo(250)
        }
        bannerView.startTapActionClosure { (index) in
            print(index)
        }
        
        
        Alamofire.request(.GET, "http://demosjz.ethank.com.cn/api/ad/get_ad_list").responseJSON { (response) in
            switch response.result {
            case .Success(let value):
                let json = JSON(value)
                print(value)
                let data = json["data"].arrayObject
                data?.forEach({ (json) in
                    let item = BannerInfo(json: JSON(json))
                    self.urls.append(item.cover!)
                })
                
                self.bannerView.dataArray = self.urls
                
            case .Failure(let error):
                print(error)
            }
        }
        
        
        
        
        let button = UIButton()
        button.addTarget(self, action: #selector(HomeViewController.buttonTapped), forControlEvents: .TouchUpInside)
        button.setTitle("跳转", forState: .Normal)
        button.backgroundColor = UIColor.redColor()
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.left.right.equalTo(button.superview!)
            make.centerY.equalTo(button.superview!).offset(100)
            make.height.equalTo(30)
        }
        
    }
    
    
    func buttonTapped() {
        let browse = BrowsePhotoViewController()
        browse.photos.append(UIImage(named: "2.0闪屏")!)
        browse.photos.append(UIImage(named: "2.0闪屏")!)
        browse.photos.append(UIImage(named: "ip5_1")!)
        browse.photos.append(UIImage(named: "ip5_1")!)
        browse.photos.append(UIImage(named: "ip5_1")!)
        navigationController?.pushViewController(browse, animated: true)
    }
}

struct BannerInfo {
    var cover: String?
    var identifier: String?
    var url: String?
    
    init (json: JSON) {
        print("json \(json)")
        self.cover = json["cover"].string
        self.identifier = json["id"].string
        self.url = json["url"].string
    }
}