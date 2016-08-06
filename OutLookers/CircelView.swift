//
//  CircelView.swift
//  OutLookers
//
//  Created by C on 16/7/15.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class CircelView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, imgName: String, title: String) {
        self.init(frame: frame)
        let imgView = UIImageView(image: UIImage(named: imgName))
        addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(imgView.superview!)
            make.height.equalTo(kScale(72))
        }
        
        let label = UILabel.createLabel(14, textColor: UIColor(hex: 0x666666))
        label.textAlignment = .Center
        label.text = title
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(imgView.snp.bottom).offset(kScale(10))
            make.left.right.equalTo(label.superview!)
            make.height.equalTo(kScale(14))
        }
    }
    
    convenience init(logCircleframe: CGRect, imgname: String, title: String) {
        self.init(frame: logCircleframe)
        let imgView = UIImageView(image: UIImage(named: imgname))
        imgView.layer.cornerRadius = kScale(50/2)
        addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(imgView.superview!)
            make.height.equalTo(kScale(50))
        }
        
        let label = UILabel.createLabel(12)
        label.textAlignment = .Center
        label.text = title
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(imgView.snp.bottom).offset(kScale(12))
            make.left.right.equalTo(label.superview!)
            make.height.equalTo(kScale(12))
        }
    }
    
    convenience init(sharedFrame: CGRect, img: UIImage, title: String) {
        self.init(frame: sharedFrame)
        let imgView = UIImageView(image: img)
        imgView.layer.cornerRadius = kScale(50/2)
        addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(imgView.superview!)
            make.height.equalTo(kScale(50))
        }
        
        let label = UILabel.createLabel(10)
        label.textAlignment = .Center
        label.text = title
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(imgView.snp.bottom).offset(kScale(7))
            make.left.right.equalTo(label.superview!)
            make.height.equalTo(kScale(10))
        }
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
