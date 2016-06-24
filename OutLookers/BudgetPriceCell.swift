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
}

class BudgetPriceCell: UITableViewCell {

    var label: UILabel!
    var tf: UITextField!
    var button: BudgetButton!
    weak var delegate: BudgetPriceCellDelegate!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        label = UILabel()
        label.font = UIFont.systemFontOfSize(16)
        contentView.addSubview(label)
        
        tf = UITextField()
        tf.font = UIFont.systemFontOfSize(14)
        tf.textAlignment = .Right
        contentView.addSubview(tf)
        
        button = BudgetButton()
        button.titleLabel?.font = UIFont.systemFontOfSize(14)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -18)
        button.setTitleColor(UIColor(hex: 0x777777), forState: .Normal)
        button.setTitleColor(UIColor.blackColor(), forState: .Selected)
        button.addTarget(self, action: .tapBudget, forControlEvents: .TouchUpInside)
        contentView.addSubview(button)
        
        label.snp.makeConstraints { (make) in
            make.left.equalTo(label.superview!).offset(15)
            make.centerY.equalTo(label.superview!)
            make.height.equalTo(16)
        }
        
        button.snp.makeConstraints { (make) in
            make.right.equalTo(button.superview!).offset(-15)
            make.centerY.equalTo(button.superview!)
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
        
        tf.snp.makeConstraints { (make) in
            make.centerY.equalTo(tf.superview!)
            make.right.equalTo(button.snp.left)
            make.left.equalTo(label.snp.right).offset(20)
            make.height.equalTo(30)
        }
    }
    
    func tapBudget(sender: UIButton) {
        tf.resignFirstResponder()
        delegate.budgetPriceButtonTap(sender)
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

class BudgetButton: UIButton {
    override var highlighted: Bool { set {} get { return false}
    }
}
