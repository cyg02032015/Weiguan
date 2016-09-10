//
//  PhoneBindCell.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/14.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private extension Selector {
    static let tapBindButton = #selector(PhoneBindCell.tapBindButton(_:))
}

protocol PhoneBindCellDelegate: class {
    func phoneBindTapBind(sender: UIButton)
}

class PhoneBindCell: UITableViewCell {

    weak var delegate: PhoneBindCellDelegate!
    var label: UILabel!
    var tf: UITextField!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        label = UILabel.createLabel(16, textColor: UIColor(hex: 0x777777))
        contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(label.superview!).offset(kScale(15))
            make.centerY.equalTo(label.superview!)
            make.height.equalTo(kScale(16))
        }
        
        let bindButton = UIButton()
        bindButton.layer.cornerRadius = kScale(18/2)
        bindButton.layer.borderWidth = 1
        bindButton.layer.borderColor = kCommonColor.CGColor
        bindButton.setTitle("绑定", forState: .Normal)
        bindButton.setTitleColor(kCommonColor, forState: .Normal)
        bindButton.titleLabel!.font = UIFont.customFontOfSize(12)
        bindButton.addTarget(self, action: .tapBindButton, forControlEvents: .TouchUpInside)
        contentView.addSubview(bindButton)
        bindButton.snp.makeConstraints { (make) in
            make.right.equalTo(bindButton.superview!).offset(kScale(-15))
            make.centerY.equalTo(bindButton.superview!)
            make.size.equalTo(kSize(48, height: 18))
        }
        
        tf = UITextField()
        tf.userInteractionEnabled = false
        tf.textAlignment = .Right
        tf.font = UIFont.customFontOfSize(16)
        contentView.addSubview(tf)
        tf.snp.makeConstraints { (make) in
            make.right.equalTo(bindButton.snp.left).offset(kScale(-10))
            make.centerY.equalTo(tf.superview!)
            make.height.equalTo(kScale(35))
            make.left.equalTo(label.snp.right).offset(kScale(15))
        }
    }
    
    func setTextInCell(text: String, placeholder: String) {
        label.text = text
        tf.placeholder = placeholder
    }
    
    func tapBindButton(sender: UIButton) {
        if delegate != nil {
            delegate.phoneBindTapBind(sender)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
