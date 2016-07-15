//
//  PersonFileHeadView.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/15.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private extension Selector {
    static let tapEditButton = #selector(PersonFileViewController.tapEditButton(_:))
}

protocol PersonFileHeadViewDelegate: class {
    func personFileTapEditButton(sender: UIButton)
}

class PersonFileHeadView: UIView {

    weak var delegate: PersonFileHeadViewDelegate!
    var section: Int = 0
    var imgView: UIImageView!
    var label: UILabel!
    var editButton: UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        setupSubViews()
    }
    
    
    func setupSubViews() {
        imgView = UIImageView()
        addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.size.equalTo(kSize(20, height: 20))
            make.centerY.equalTo(imgView.superview!)
            make.left.equalTo(imgView.superview!).offset(kScale(15))
        }
        label = UILabel.createLabel(16, textColor: UIColor(hex: 0x777777))
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.snp.right)
            make.centerY.equalTo(label.superview!)
            make.height.equalTo(kScale(16))
        }
        
        editButton = UIButton()
        editButton.setImage(UIImage(named: "Fill"), forState: .Normal)
        editButton.addTarget(self, action: .tapEditButton, forControlEvents: .TouchUpInside)
        addSubview(editButton)
        editButton.snp.makeConstraints(closure: { (make) in
            make.right.equalTo(editButton.superview!).offset(kScale(-15))
            make.centerY.equalTo(editButton.superview!)
            make.size.equalTo(kSize(15, height: 17))
        })
        
        let lineV = UIView()
        lineV.backgroundColor = kLineColor
        addSubview(lineV)
        lineV.snp.makeConstraints { (make) in
            make.left.right.equalTo(lineV.superview!)
            make.bottom.equalTo(lineV.superview!)
            make.height.equalTo(1)
        }
    }
    
    func tapEditButton(sender: UIButton) {
        sender.tag = section
        if delegate != nil {
            delegate.personFileTapEditButton(sender)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
