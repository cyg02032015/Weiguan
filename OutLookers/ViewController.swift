//
//  ViewController.swift
//  OutLookers
//
//  Created by Youngkook on 16/6/15.
//  Copyright © 2016年 youngkook. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "\n\n     asdfafsadfaf".noWhiteSpace().noChangeLine()
        view.addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.left.right.equalTo(label.superview!)
            make.centerY.equalTo(label.superview!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

