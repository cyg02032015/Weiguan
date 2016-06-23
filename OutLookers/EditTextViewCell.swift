//
//  EditTextViewCell.swift
//  OutLookers
//
//  Created by Youngkook on 16/6/23.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class EditTextViewCell: UITableViewCell {

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
        contentView.addSubview(textView)
        
        placeholderLabel = UILabel()
        placeholderLabel.font = UIFont.systemFontOfSize(16)
        placeholderLabel.text = "写点什么吧..."
        placeholderLabel.textColor = UIColor.grayColor()
        contentView.addSubview(placeholderLabel)
        
        textView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 8, left: 11, bottom: 15, right: 15))
        }
        
        placeholderLabel.snp.makeConstraints { (make) in
            make.right.equalTo(placeholderLabel.superview!).offset(15)
            make.left.equalTo(placeholderLabel.superview!).offset(15)
            make.height.equalTo(16)
            make.top.equalTo(placeholderLabel.superview!).offset(15)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EditTextViewCell: UITextViewDelegate {
    func textViewDidChange(textView: UITextView) {
        placeholderLabel.hidden = textView.text.characters.count > 0
    }
}
