//
//  WorkDetailCell.swift
//  OutLookers
//
//  Created by C on 16/6/19.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class WorkDetailCell: UITableViewCell {

    var placeholderLabel: UILabel!
    var tv: UITextView!
    var label: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        label = UILabel()
        label.text = "工作详情"
        label.font = UIFont.systemFontOfSize(16)
        contentView.addSubview(label)
        
        tv = UITextView()
        tv.delegate = self
        contentView.addSubview(tv)
        
        placeholderLabel = UILabel()
        placeholderLabel.font = UIFont.systemFontOfSize(14)
        placeholderLabel.text = "请输入工作内容"
        placeholderLabel.textColor = UIColor.grayColor()
        contentView.addSubview(placeholderLabel)
        
        label.snp.makeConstraints { (make) in
            make.left.equalTo(label.superview!).offset(15)
            make.top.equalTo(label.superview!).offset(15)
            make.height.equalTo(16)
        }
        
        tv.snp.makeConstraints { (make) in
            make.left.equalTo(tv.superview!).offset(15)
            make.right.equalTo(tv.superview!).offset(-15)
            make.top.equalTo(label.snp.bottom).offset(6)
            make.bottom.equalTo(tv.superview!).offset(-10)
        }
        
        placeholderLabel.snp.makeConstraints { (make) in
            make.right.equalTo(tv)
            make.left.equalTo(tv).offset(4)
            make.height.equalTo(14)
            make.top.equalTo(tv).offset(8)
        }
    }

    func setTextInCell(text: String, placeholder: String) {
        label.text = text
        placeholderLabel.text = placeholder
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WorkDetailCell: UITextViewDelegate {
    
    func textViewDidChange(textView: UITextView) {
        placeholderLabel.hidden = textView.text.characters.count > 0
    }
}