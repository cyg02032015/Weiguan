//
//  WorkDetailCell.swift
//  OutLookers
//
//  Created by C on 16/6/19.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

protocol WorkDetailCellDelegate: class {
    func workDetailCellReturnText(text: String)
}

class WorkDetailCell: UITableViewCell {

    weak var delegate: WorkDetailCellDelegate!
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
        label.font = UIFont.customFontOfSize(16)
        contentView.addSubview(label)
        
        tv = UITextView()
        tv.delegate = self
        tv.font = UIFont.customFontOfSize(14)
        contentView.addSubview(tv)
        
        placeholderLabel = UILabel()
        placeholderLabel.font = UIFont.customFontOfSize(14)
        placeholderLabel.text = "请输入工作内容"
        placeholderLabel.textColor = UIColor.grayColor()
        contentView.addSubview(placeholderLabel)
        
        label.snp.makeConstraints { (make) in
            make.left.equalTo(label.superview!).offset(kScale(15))
            make.top.equalTo(label.superview!).offset(kScale(15))
            make.height.equalTo(kScale(16))
        }
        
        tv.snp.makeConstraints { (make) in
            make.left.equalTo(tv.superview!).offset(kScale(15))
            make.right.equalTo(tv.superview!).offset(kScale(-15))
            make.top.equalTo(label.snp.bottom).offset(kScale(6))
            make.bottom.equalTo(tv.superview!).offset(kScale(-10))
        }
        
        placeholderLabel.snp.makeConstraints { (make) in
            make.right.equalTo(tv)
            make.left.equalTo(tv).offset(kScale(4))
            make.height.equalTo(kScale(14))
            make.top.equalTo(tv).offset(kScale(8))
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
    
    func textViewDidEndEditing(textView: UITextView) {
        if delegate != nil {
            delegate.workDetailCellReturnText(textView.text)
        }
    }
}