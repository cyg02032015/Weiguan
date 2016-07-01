//
//  MineViewController.swift
//  OutLookers
//
//  Created by C on 16/6/15.
//  Copyright © 2016年 youngkook. All rights reserved.
//

import UIKit

class MineViewController: YGBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = UIButton()
        btn.setTitle(LocalizedString("log"), forState: .Normal)
        btn.addTarget(self, action: #selector(MineViewController.logClic(_:)), forControlEvents: .TouchUpInside)
        btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        view.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.left.right.equalTo(btn.superview!)
            make.top.equalTo(self.snp.topLayoutGuideBottom).offset(30)
            make.height.equalTo(40)
        }
    }
    
    func logClic(sender: UIButton) {
        let logVC = PersonalDataViewController()
        navigationController?.pushViewController(logVC, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
