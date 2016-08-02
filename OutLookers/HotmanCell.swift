//
//  HotmanCell.swift
//  OutLookers
//
//  Created by C on 16/7/15.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class HotmanCell: UITableViewCell {

    var info: FindeHotman! {
        didSet {
            imgView.yy_setImageWithURL(info.headImgUrl.addImagePath(CGSize(width: imgView.gg_width, height: imgView.gg_height)), placeholder: kPlaceholder)
            nameLabel.text = info.nickname
            jobLabel.text = "没有字段"
            picCount.text = "0"
            videoCount.text = "0"
        }
    }
    
    var imgView: UIImageView!
    var nameLabel: UILabel!
    var jobLabel: UILabel!
    var picCount: UILabel!
    var videoCount: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        imgView = UIImageView()
        contentView.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.edges.equalTo(imgView.superview!)
        }
        
        nameLabel = UILabel.createLabel(16, textColor: UIColor.whiteColor())
        nameLabel.textAlignment = .Center
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(nameLabel.superview!)
            make.top.equalTo(nameLabel.superview!).offset(kScale(324))
            make.height.equalTo(kScale(16))
        }
        
        jobLabel = UILabel.createLabel(14, textColor: UIColor.whiteColor())
        jobLabel.textAlignment = .Center
        contentView.addSubview(jobLabel)
        jobLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(jobLabel.superview!)
            make.top.equalTo(nameLabel.snp.bottom).offset(kScale(6))
            make.height.equalTo(kScale(14))
        }
        
        let view = UIView()
        view.layer.cornerRadius = kScale(2)
        view.backgroundColor = UIColor(r: 0, g: 0, b: 0, a: 0.5)
        contentView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.right.equalTo(view.superview!).offset(kScale(-10))
            make.size.equalTo(kSize(59, height: 22))
            make.top.equalTo(view.superview!).offset(kScale(10))
        }
        
        let pic = UIImageView(image: UIImage(named: "picture1"))
        view.addSubview(pic)
        pic.snp.makeConstraints { (make) in
            make.right.equalTo(pic.superview!).offset(kScale(-6))
            make.size.equalTo(kSize(10, height: 10))
            make.centerY.equalTo(pic.superview!)
        }
        
        picCount = UILabel.createLabel(12, textColor: UIColor.whiteColor())
        view.addSubview(picCount)
        picCount.snp.makeConstraints { (make) in
            make.right.equalTo(pic.snp.left).offset(kScale(-3))
            make.height.equalTo(kScale(14))
            make.centerY.equalTo(pic)
        }
        
        let video = UIImageView(image: UIImage(named: "video1"))
        view.addSubview(video)
        video.snp.makeConstraints { (make) in
            make.right.equalTo(picCount.snp.left).offset(kScale(-8))
            make.centerY.equalTo(pic)
            make.size.equalTo(kSize(10, height: 10))
        }
        
        videoCount = UILabel.createLabel(12, textColor: UIColor.whiteColor())
        view.addSubview(videoCount)
        videoCount.snp.makeConstraints { (make) in
            make.right.equalTo(video.snp.left).offset(kScale(-3))
            make.centerY.equalTo(pic)
            make.height.equalTo(picCount)
        }
        layoutIfNeeded()
//        picCount.text = "9"
//        videoCount.text = "9"
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
