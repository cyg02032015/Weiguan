//
//  BudgetPriceCell.swift
//  OutLookers
//
//  Created by C on 16/6/24.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private extension Selector {
    static let tapBudget = #selector(BudgetPriceCell.tapBudget(_:))
}

protocol BudgetPriceCellDelegate: class {
    func budgetPriceButtonTap(sender: UIButton)
    func textFieldReturnText(text: String)
}

class BudgetPriceCell: UITableViewCell {

    var label: UILabel!
    var tf: UITextField!
    var button: UIButton!
    weak var delegate: BudgetPriceCellDelegate!
    
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
        tf.delegate = self
        tf.font = UIFont.customFontOfSize(14)
        tf.textAlignment = .Right
        contentView.addSubview(tf)
        
        button = UIButton()
        button.titleLabel?.font = UIFont.customFontOfSize(14)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -18)
        button.setTitleColor(UIColor(hex: 0x777777), forState: .Normal)
        button.setTitleColor(UIColor.blackColor(), forState: .Selected)
        button.addTarget(self, action: .tapBudget, forControlEvents: .TouchUpInside)
        contentView.addSubview(button)
        
        label.snp.makeConstraints { (make) in
            make.left.equalTo(label.superview!).offset(kScale(15))
            make.centerY.equalTo(label.superview!)
            make.height.equalTo(kScale(16))
        }
        
        button.snp.makeConstraints { (make) in
            make.right.equalTo(button.superview!).offset(kScale(-15))
            make.centerY.equalTo(button.superview!)
            make.size.equalTo(kSize(50, height: 30))
        }
        
        tf.snp.makeConstraints { (make) in
            make.centerY.equalTo(tf.superview!)
            make.right.equalTo(button.snp.left)
            make.left.equalTo(label.snp.right).offset(kScale(20))
            make.height.equalTo(kScale(30))
        }
    }
    
    func tapBudget(sender: UIButton) {
        tf.resignFirstResponder()
        if delegate != nil {
            delegate.budgetPriceButtonTap(sender)
        }
    }
    
    func setTextInCell(text: String, placeholder: String, buttonText: String) {
        label.text = text
        tf.placeholder = placeholder
        button.setTitle(buttonText, forState: .Normal)
    }
    
    func setButtonText(buttonText: String) {
        button.setTitle(buttonText, forState: .Selected)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BudgetPriceCell: UITextFieldDelegate {
    func textFieldDidEndEditing(textField: UITextField) {
        if delegate != nil {
            delegate.textFieldReturnText(textField.text ?? "")
        }
    }
}
