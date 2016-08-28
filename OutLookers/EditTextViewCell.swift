//
//  EditTextViewCell.swift
//  OutLookers
//
//  Created by Youngkook on 16/6/23.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

protocol EditTextViewCellDelegate: class {
    func textViewCellReturnText(text: String)
}

class EditTextViewCell: UITableViewCell {

    weak var delegate: EditTextViewCellDelegate!
    var textView: UITextView!
    var placeholderLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        textView = UITextView()
        textView.delegate = self
        textView.font = UIFont.customFontOfSize(14)
        contentView.addSubview(textView)
        
        placeholderLabel = UILabel()
        placeholderLabel.font = UIFont.customFontOfSize(16)
        placeholderLabel.text = "写点什么吧..."
        placeholderLabel.textColor = UIColor.grayColor()
        contentView.addSubview(placeholderLabel)
        
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(textView.superview!).offset(kScale(8))
            make.left.equalTo(textView.superview!).offset(kScale(11))
            make.right.equalTo(textView.superview!).offset(kScale(-15))
            make.bottom.equalTo(textView.superview!).offset(-15)
        }
        
        placeholderLabel.snp.makeConstraints { (make) in
            make.right.equalTo(placeholderLabel.superview!).offset(kScale(-15))
            make.left.equalTo(placeholderLabel.superview!).offset(kScale(15))
            make.height.equalTo(kScale(16))
            make.top.equalTo(placeholderLabel.superview!).offset(kScale(15))
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EditTextViewCell: UITextViewDelegate {
    func textViewDidChange(textView: UITextView) {
        placeholderLabel.hidden = textView.text.characters.count > 0
        if delegate != nil {
            delegate.textViewCellReturnText(textView.text)
        }
    }
}
