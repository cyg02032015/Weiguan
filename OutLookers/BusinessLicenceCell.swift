//
//  BusinessLicenceCell.swift
//  OutLookers
//
//  Created by C on 16/7/17.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private extension Selector {
    static let tapImgButton = #selector(BusinessLicenceCell.tapImgButton)
}

protocol BusinessLicenceCellDelegate: class {
    func businessLicenceTapImgButton(sender: TouchImageView, desc: UILabel)
}

class BusinessLicenceCell: UITableViewCell {

    var delegate: BusinessLicenceCellDelegate!
    var desc: UILabel!
    var imgView: TouchImageView!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        backgroundColor = kBackgoundColor
        let label = UILabel.createLabel(14, textColor: UIColor(hex: 0x666666))
        label.text = "上传营业执照"
        contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(label.superview!).offset(kScale(15))
            make.top.equalTo(label.superview!).offset(kScale(20))
            make.height.equalTo(kScale(14))
        }
        
        imgView = TouchImageView()
        imgView.backgroundColor = UIColor(hex: 0xe8e8e8)
        imgView.addTarget(self, action: .tapImgButton)
        imgView.contentMode = .ScaleAspectFit
        contentView.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.superview!).offset(kScale(44))
            make.right.equalTo(imgView.superview!).offset(kScale(-44))
            make.top.equalTo(label.snp.bottom).offset(kScale(20))
            make.height.equalTo(kScale(162))
        }
        
        desc = UILabel.createLabel(14, textColor: UIColor(hex: 0xc0c0c0))
        desc.textAlignment = .Center
        desc.numberOfLines = 2
        desc.text = "点击上传营业执照 大小不超过5M"
        imgView.addSubview(desc)
        desc.snp.makeConstraints { (make) in
            make.centerX.equalTo(desc.superview!)
            make.centerY.equalTo(desc.superview!)
            make.size.equalTo(kSize(112, height: 45))
        }
    }
    
    func tapImgButton() {
        if delegate != nil {
            delegate.businessLicenceTapImgButton(imgView, desc: desc)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
