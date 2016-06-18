//
//  ArrowEditCell.swift
//  OutLookers
//
//  Created by C on 16/6/18.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class ArrowEditCell: UITableViewCell {

    var label: UILabel!
    var tf: UITextField!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        label = UILabel()
        contentView.addSubview(label)
        
        let arrow = UIImageView(image: UIImage(named: "mine_arrow_icon"))
        contentView.addSubview(arrow)
        
        tf = UITextField()
        tf.userInteractionEnabled = false
        tf.textAlignment = .Right
        contentView.addSubview(tf)
        
        label.snp.makeConstraints { (make) in
            make.left.equalTo(label.superview!).offset(15)
            make.centerY.equalTo(label.superview!)
        }
        
        arrow.snp.makeConstraints { (make) in
            make.right.equalTo(arrow.superview!).offset(-13)
            make.size.equalTo(CGSize(width: 6, height: 11))
            make.centerY.equalTo(arrow.superview!)
        }
        
        tf.snp.makeConstraints { (make) in
            make.right.equalTo(arrow.snp.left).offset(-10)
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
