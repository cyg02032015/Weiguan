//
//  AccountCell.swift
//  OutLookers
//
//  Created by C on 16/7/31.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private extension Selector {
    static let tapBind = #selector(AccountCell.tapBind(_:))
}

class AccountCell: UITableViewCell {

    var imgView: UIImageView!
    var label: UILabel!
    var rightLabel: UILabel!
    var bindButton: UIButton!
    var indexPath: NSIndexPath!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        imgView = UIImageView()
        imgView.contentMode = .ScaleAspectFit
        contentView.addSubview(imgView)
        
        imgView.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.superview!).offset(kScale(16))
            make.centerY.equalTo(imgView.superview!)
            make.size.equalTo(kSize(30, height: 30))
        }
        
        label = UILabel()
        label.font = UIFont.customFontOfSize(14)
        contentView.addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.snp.right).offset(kScale(5))
            make.centerY.equalTo(imgView)
        }
        
        let arrow = UIImageView(image: UIImage(named: "open"))
        contentView.addSubview(arrow)
        
        arrow.snp.makeConstraints { (make) in
            make.right.equalTo(arrow.superview!).offset(kScale(-15))
            make.size.equalTo(kSize(14, height: 14))
            make.centerY.equalTo(imgView)
        }
        
        bindButton = UIButton()
        bindButton.layer.cornerRadius = kScale(4)
        bindButton.backgroundColor = kCommonColor
        bindButton.setTitle("绑定", forState: .Normal)
        bindButton.addTarget(self, action: .tapBind, forControlEvents: .TouchUpInside)
        bindButton.titleLabel!.font = UIFont.customFontOfSize(12)
        contentView.addSubview(bindButton)
        bindButton.snp.makeConstraints { (make) in
            make.right.equalTo(arrow.snp.left).offset(kScale(-11))
            make.centerY.equalTo(arrow)
            make.size.equalTo(kSize(60, height: 24))
        }
        
        rightLabel = UILabel.createLabel(14, textColor: kGrayTextColor)
        rightLabel.hidden = true
        rightLabel.textAlignment = .Right
        contentView.addSubview(rightLabel)
        rightLabel.snp.makeConstraints { (make) in
            make.right.equalTo(arrow.snp.left).offset(kScale(-11))
            make.centerY.equalTo(arrow)
            make.left.equalTo(label.snp.right).offset(kScale(15))
        }
    }
    
    func tapBind(sender: UIButton) {
        
    }
    
    func setImgAndText(imgName: String, text: String) {
        imgView.image = UIImage(named: imgName)
        label.text = text
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
