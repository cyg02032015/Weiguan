//
//  Register3ViewController.swift
//  OutLookers
//
//  Created by C on 16/8/5.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class Register3ViewController: YGBaseViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }
    
    func setupSubViews() {
        title = "完善资料（3/3）"
        let imgView = TouchImageView()
        imgView.layer.cornerRadius = kScale(72/2)
        imgView.clipsToBounds = true
        view.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.centerX.equalTo(imgView.superview!)
            make.top.equalTo(self.snp.topLayoutGuideBottom).offset(kScale(30))
            make.size.equalTo(kSize(72, height: 72))
        }
        
        
    }

}
