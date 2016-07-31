//
//  FeedbackView.swift
//  OutLookers
//
//  Created by C on 16/7/31.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private extension Selector {
    static let textFieldEdit = #selector(FeedbackCell.textFieldEditChanged(_:))
}

protocol FeedBackCellDelegate: class {
    func feedBackCellReturnTextViewText(text: String)
    func feedBackCellReturnTextFieldText(text: String)
}

class FeedbackCell: UITableViewCell {
    
    weak var delegate: FeedBackCellDelegate!
    var placeholderLabel: UILabel!
    var textView: UITextView!
    var textField: UITextField!
    
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
        placeholderLabel.numberOfLines = 0
        placeholderLabel.font = UIFont.customFontOfSize(14)
        placeholderLabel.text = "欢迎反馈任何意见和问题，您的反馈也是我们产品进步的动力哦！"
        placeholderLabel.textColor = UIColor.grayColor()
        contentView.addSubview(placeholderLabel)
        
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(textView.superview!).offset(kScale(5))
            make.left.equalTo(textView.superview!).offset(kScale(11))
            make.right.equalTo(textView.superview!).offset(kScale(-15))
            make.height.equalTo(kScale(176))
        }
        
        placeholderLabel.snp.makeConstraints { (make) in
            make.right.equalTo(placeholderLabel.superview!).offset(kScale(-24))
            make.left.equalTo(placeholderLabel.superview!).offset(kScale(15))
            make.top.equalTo(placeholderLabel.superview!).offset(kScale(11))
        }
        
        let lineV = UIView()
        lineV.backgroundColor = kLineColor
        contentView.addSubview(lineV)
        lineV.snp.makeConstraints { (make) in
            make.left.right.equalTo(lineV.superview!)
            make.top.equalTo(textView.snp.bottom)
            make.height.equalTo(0.5)
        }
        
        textField = UITextField()
        textField.font = UIFont.customFontOfSize(14)
        textField.addTarget(self, action: .textFieldEdit, forControlEvents: .EditingChanged)
        textField.placeholder = "您的联系方式（QQ/微信号/手机号）"
        contentView.addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.left.equalTo(textField.superview!).offset(kScale(15))
            make.right.equalTo(textField.superview!).offset(kScale(-15))
            make.top.equalTo(lineV.snp.bottom).offset(kScale(10))
            make.bottom.equalTo(textField.superview!).offset(kScale(-10))
        }
    }
    
    func textFieldEditChanged(textField: UITextField) {
        if delegate != nil {
            delegate.feedBackCellReturnTextFieldText(textField.text ?? "")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension FeedbackCell: UITextViewDelegate {
    
    func textViewDidChange(textView: UITextView) {
        placeholderLabel.hidden = textView.text.characters.count > 0
        if delegate != nil {
            delegate.feedBackCellReturnTextViewText(textView.text)
        }
    }
}