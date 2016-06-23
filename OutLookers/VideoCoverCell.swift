//
//  VideoCoverCell.swift
//  OutLookers
//
//  Created by Youngkook on 16/6/23.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private extension Selector {
    static let tapImgView = #selector(VideoCoverCell.tapImgView(_:))
}

protocol VideoCoverCellDelegate: class {
    func videoCoverImageViewTap(sender: UITapGestureRecognizer)
}

class VideoCoverCell: UITableViewCell {
    
    var imgView: UIImageView!
    weak var delegate: VideoCoverCellDelegate!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        imgView = UIImageView()
        imgView.backgroundColor = UIColor.blackColor()
        imgView.userInteractionEnabled = true
        contentView.addSubview(imgView);
        
        let tap = UITapGestureRecognizer(target: self, action: .tapImgView)
        imgView.addGestureRecognizer(tap)
        
        let v = UIView()
        v.backgroundColor = UIColor(hex: 0xB3FE4E4E)
        imgView.addSubview(v)
        
        let smlImg = UIImageView(image: UIImage(named: "Set cover"))
        v.addSubview(smlImg)
        
        let label = UILabel()
        label.textAlignment = .Center
        label.font = UIFont.systemFontOfSize(12)
        label.text = "设置封面";
        label.textColor = UIColor.whiteColor()
        v.addSubview(label)
        
        let lineV = UIView()
        lineV.backgroundColor = UIColor(hex: 0xE4E4E4)
        contentView.addSubview(lineV)
        
        imgView.snp.makeConstraints { (make) in
            make.top.equalTo(16)
            make.centerX.equalTo(imgView.superview!);
            make.size.equalTo(CGSize(width: 82, height: 82))
        }
        
        v.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(v.superview!);
            make.height.equalTo(20)
        }
        
        smlImg.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 20, height: 12.4))
            make.left.equalTo(smlImg.superview!).offset(6)
            make.centerY.equalTo(smlImg.superview!)
        }
        
        label.snp.makeConstraints { (make) in
            make.left.equalTo(smlImg.snp.right).offset(3)
            make.centerY.equalTo(label.superview!)
            make.height.equalTo(12)
        }
        
        lineV.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(lineV.superview!)
            make.height.equalTo(1)
        }
    }
    
    func tapImgView(sender: UITapGestureRecognizer) {
        delegate.videoCoverImageViewTap(sender)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
