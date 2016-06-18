//
//  NoArrowEditCell.swift
//  OutLookers
//
//  Created by C on 16/6/18.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class NoArrowEditCell: UITableViewCell {

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
                    make.left.equalTo(tf.superview!).offset(15)
                    make.right.equalTo(tf.superview!).offset(-15)
                    make.centerY.equalTo(tf.superview!)
                    make.height.equalTo(35)
                }
            } else {
                label.hidden = false
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
        contentView.addSubview(label)
        
        tf = UITextField()
        tf.textAlignment = .Right
        contentView.addSubview(tf)
        
        label.snp.makeConstraints { (make) in
            make.left.equalTo(label.superview!).offset(15)
            make.centerY.equalTo(label.superview!)
        }
        
        tf.snp.makeConstraints { (make) in
            make.right.equalTo(tf.superview!).offset(-15)
            make.centerY.equalTo(tf.superview!)
            make.height.equalTo(35)
            make.left.equalTo(label.snp.right).offset(15)
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
