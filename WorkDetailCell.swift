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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        let label = UILabel()
        label.text = "工作详情"
        label.font = UIFont.systemFontOfSize(15)
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
            make.height.equalTo(15)
        }
        
        tv.snp.makeConstraints { (make) in
            make.left.equalTo(tv.superview!).offset(15)
            make.right.equalTo(tv.superview!).offset(-15)
            make.top.equalTo(label.snp.bottom).offset(15)
            make.bottom.equalTo(tv.superview!).offset(-10)
        }
        
        placeholderLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(tv)
            make.height.equalTo(14)
            make.top.equalTo(tv)
        }
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