//
//  NoArrowEditCell.swift
//  OutLookers
//
//  Created by C on 16/6/18.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

protocol NoArrowEditCellDelegate:class {
    func noarrowCellReturnText(text: String?, tuple: (section: Int, row: Int))
}

class NoArrowEditCell: UITableViewCell {
    
    weak var delegate: NoArrowEditCellDelegate!
    var indexPath: NSIndexPath!
    var label: UILabel!
    var tf: UITextField!
    var labelText: String! {
        didSet {
            label.text = oldValue
        }
    }
    
    var labelHidden: Bool = false {
        didSet {
            if oldValue {
                label.hidden = true
                tf.snp.remakeConstraints{ (make) in
                    make.left.equalTo(tf.superview!).offset(kScale(15))
                    make.right.equalTo(tf.superview!).offset(kScale(-15))
                    make.centerY.equalTo(tf.superview!)
                    make.height.equalTo(kScale(35))
                }
            } else {
                label.hidden = false
            }
        }
    }
    
    var _textFieldEnable: Bool = true
    var textFieldEnable: Bool {
        get {
            return _textFieldEnable
        }
        set {
            _textFieldEnable = newValue
            if _textFieldEnable {
                tf.userInteractionEnabled = true
            } else {
                tf.userInteractionEnabled = false
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        label = UILabel()
        label.font = UIFont.customFontOfSize(16)
        contentView.addSubview(label)
        
        tf = UITextField()
        tf.textAlignment = .Right
        tf.font = UIFont.customFontOfSize(14)
        tf.delegate = self
        contentView.addSubview(tf)
        
        label.snp.makeConstraints { (make) in
            make.left.equalTo(label.superview!).offset(kScale(15))
            make.centerY.equalTo(label.superview!)
            make.height.equalTo(kScale(16))
        }
        
        tf.snp.makeConstraints { (make) in
            make.right.equalTo(tf.superview!).offset(kScale(-15))
            make.centerY.equalTo(tf.superview!)
            make.height.equalTo(kScale(35))
            make.left.equalTo(label.snp.right).offset(kScale(15))
        }
    }
    
    func setTextInCell(text: String, placeholder: String) {
        label.text = text
        tf.placeholder = placeholder
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NoArrowEditCell: UITextFieldDelegate {
    func textFieldDidEndEditing(textField: UITextField) {
        if delegate != nil {
            delegate.noarrowCellReturnText(textField.text, tuple: (indexPath.section, indexPath.row))
        }
        
    }
}