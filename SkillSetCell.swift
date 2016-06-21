//
//  SkillSetCell.swift
//  OutLookers
//
//  Created by C on 16/6/21.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//  才艺作品集

import UIKit

private let kLineGrayColor = UIColor(hex: 0xE4E4E4)

class SkillSetCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        let label = UILabel()
        label.text = "才艺作品集 (选填)"
        label.font = UIFont.systemFontOfSize(16)
        contentView.addSubview(label)
        
        let line1 = UIView()
        line1.backgroundColor = kLineGrayColor
        contentView.addSubview(line1)
        
        let setCoverLabel = UILabel()
        setCoverLabel.text = "设置封面"
        setCoverLabel.font = UIFont.systemFontOfSize(16)
        contentView.addSubview(setCoverLabel)
        
        let photoButton = UIButton()
        photoButton.setImage(UIImage(named: "release_announcement_Add pictures"), forState: .Normal)
        contentView.addSubview(photoButton)
        
        let line2 = UIView()
        line2.backgroundColor = kLineGrayColor
        contentView.addSubview(line2)
        
        let addVideoLabel = UILabel()
        addVideoLabel.text = "添加视频"
        addVideoLabel.font = UIFont.systemFontOfSize(16)
        contentView.addSubview(addVideoLabel)
        
        let videoButton = UIButton()
        videoButton.setImage(UIImage(named: "release_announcement_Add video"), forState: .Normal)
        contentView.addSubview(videoButton)
        
        let line3 = UIView()
        line3.backgroundColor = kLineGrayColor
        contentView.addSubview(line3)
        
        let addPictureLabel = UILabel()
        addPictureLabel.text = "添加图片"
        addPictureLabel.font = UIFont.systemFontOfSize(16)
        contentView.addSubview(addPictureLabel)

        label.snp.makeConstraints { (make) in
            make.left.top.equalTo(label.superview!).offset(15)
            make.height.equalTo(16)
        }
        
        line1.snp.makeConstraints { (make) in
            make.top.equalTo(label.snp.bottom).offset(15)
            make.height.equalTo(1)
            make.left.equalTo(label)
            make.right.equalTo(line1.superview!)
        }
        
        setCoverLabel.snp.makeConstraints { (make) in
            make.top.equalTo(line1.snp.bottom).offset(20)
            make.left.equalTo(label)
            make.height.equalTo(16)
        }
        
        photoButton.snp.makeConstraints { (make) in
            make.top.equalTo(setCoverLabel.snp.bottom).offset(15)
            make.left.equalTo(label)
            make.size.equalTo(CGSize(width: 70, height: 70))
        }
        
        line2.snp.makeConstraints { (make) in
            make.height.equalTo(line1)
            make.left.equalTo(label)
            make.top.equalTo(photoButton.snp.bottom).offset(20)
            make.right.equalTo(line1.superview!)
        }
        
        addVideoLabel.snp.makeConstraints { (make) in
            make.height.equalTo(16)
            make.left.equalTo(label)
            make.top.equalTo(line2.snp.bottom).offset(20)
        }
        
        videoButton.snp.makeConstraints { (make) in
            make.left.equalTo(label)
            make.top.equalTo(addVideoLabel.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 70, height: 70))
        }
        
        line3.snp.makeConstraints { (make) in
            make.left.equalTo(label)
            make.top.equalTo(videoButton.snp.bottom).offset(20)
            make.height.equalTo(line1)
            make.right.equalTo(line1.superview!)
        }
        
        addPictureLabel.snp.makeConstraints { (make) in
            make.top.equalTo(line3.snp.bottom).offset(20)
            make.height.equalTo(16)
            make.left.equalTo(label)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
