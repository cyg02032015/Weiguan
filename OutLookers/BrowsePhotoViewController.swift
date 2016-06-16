//
//  BrowsePhotoViewController.swift
//  OutLookers
//
//  Created by C on 16/6/16.
//  Copyright © 2016年 youngkook. All rights reserved.
//

import UIKit
import SnapKit

class BrowsePhotoViewController: YGBaseViewController {
    
    var photos = [UIImage]()
    
    var countLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }
    
    func setupSubViews() {
        let scrollView = UIScrollView()
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.delegate = self;
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.topLayoutGuideBottom)
            make.left.right.equalTo(scrollView.superview!)
            make.bottom.equalTo(scrollView.superview!)
        }
        var lastImgView: UIImageView?
        for i in 0..<photos.count {
            let imgView = UIImageView(image: photos[i])
            scrollView.addSubview(imgView)
            imgView.snp.makeConstraints { make in
                make.top.equalTo(imgView.superview!).offset(-NaviHeight)
                make.left.equalTo(lastImgView == nil ? imgView.superview! : lastImgView!.snp.right)
                make.width.equalTo(ScreenWidth)
                if i == photos.count - 1 {
                    make.right.equalTo(imgView.superview!)
                }
            }
            lastImgView = imgView
        }
        
        countLabel = UILabel()
        countLabel.backgroundColor = UIColor.blackColor()
        countLabel.textColor = UIColor.whiteColor()
        countLabel.text = "1/\(photos.count)"
        countLabel.textAlignment = .Center
        view.addSubview(countLabel)
        countLabel.snp.makeConstraints { make in
            make.left.right.equalTo(countLabel.superview!)
            make.height.equalTo(40)
            make.bottom.equalTo(countLabel.superview!).offset(-80)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension BrowsePhotoViewController: UIScrollViewDelegate {
    // scrollview 减速停止
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        countLabel.text = "\(Int(scrollView.contentOffset.x/ScreenWidth) + 1)/\(photos.count)"
    }
}
