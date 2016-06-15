//
//  HomeViewController.swift
//  OutLookers
//
//  Created by C on 16/6/15.
//  Copyright © 2016年 youngkook. All rights reserved.
//

import UIKit

class HomeViewController: YGBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint("woca")
        print("nima")
        Server.post("", parameters: ["":""]) { 
            print("xi")
            debugPrint("bar")
        }
    }
}