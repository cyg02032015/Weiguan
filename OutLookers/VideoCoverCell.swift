//
//  VideoCoverCell.swift
//  OutLookers
//
//  Created by Youngkook on 16/6/23.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private extension Selector {
    static let tapImgView = #selector(VideoCoverCell.tapImgView)
    static let tapSettingCover = #selector(VideoCoverCell.tapSettingCover)
}

protocol VideoCoverCellDelegate: class {
    func videoCoverImageViewTap()
    func videoCoverTapSettingCover()
}

class VideoCoverCell: UITableViewCell {
    
    var imgView: TouchImageView!
    weak var delegate: VideoCoverCellDelegate!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        imgView = TouchImageView()
        imgView.backgroundColor = UIColor.blackColor()
        imgView.addTarget(self, action: .tapImgView)
        contentView.addSubview(imgView);
        
        let v = TouchView()
        v.backgroundColor = UIColor(r: 254, g: 78, b: 78, a: 0.7)
        v.addTarget(self, action: .tapSettingCover)
        imgView.addSubview(v)
        
        let smlImg = UIImageView(image: UIImage(named: "Set cover"))
        v.addSubview(smlImg)
        
        let label = UILabel()
        label.textAlignment = .Center
        label.font = UIFont.customFontOfSize(12)
        label.text = "设置封面";
        label.textColor = UIColor.whiteColor()
        v.addSubview(label)
        
        let lineV = UIView()
        lineV.backgroundColor = UIColor(hex: 0xE4E4E4)
        contentView.addSubview(lineV)
        
        imgView.snp.makeConstraints { (make) in
            make.top.equalTo(kScale(16))
            make.centerX.equalTo(imgView.superview!);
            make.size.equalTo(kSize(82, height: 82))
        }
        
        v.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(v.superview!);
            make.height.equalTo(kScale(20))
        }
        
        smlImg.snp.makeConstraints { (make) in
            make.size.equalTo(kSize(20, height: 12.4))
            make.left.equalTo(smlImg.superview!).offset(kScale(6))
            make.centerY.equalTo(smlImg.superview!)
        }
        
        label.snp.makeConstraints { (make) in
            make.left.equalTo(smlImg.snp.right).offset(kScale(3))
            make.centerY.equalTo(label.superview!)
            make.height.equalTo(kScale(12))
        }
        
        lineV.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(lineV.superview!)
            make.height.equalTo(1)
        }
    }
    
    func tapImgView() {
        if delegate != nil {
            delegate.videoCoverImageViewTap()
        }
    }
    
    func tapSettingCover() {
        if delegate != nil {
            delegate.videoCoverTapSettingCover()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
