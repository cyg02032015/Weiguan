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
        label.font = UIFont.customFontOfSize(16)
        contentView.addSubview(label)
        
        let arrow = UIImageView(image: UIImage(named: "open"))
        contentView.addSubview(arrow)
        
        tf = UITextField()
        tf.userInteractionEnabled = false
        tf.textAlignment = .Right
        tf.font = UIFont.customFontOfSize(14)
        contentView.addSubview(tf)
        
        label.snp.makeConstraints { (make) in
            make.left.equalTo(label.superview!).offset(kScale(15))
            make.centerY.equalTo(label.superview!)
            make.height.equalTo(kScale(16))
        }
        
        arrow.snp.makeConstraints { (make) in
            make.right.equalTo(arrow.superview!).offset(kScale(-15))
            make.size.equalTo(kSize(8, height: 15))
            make.centerY.equalTo(arrow.superview!)
        }
        
        tf.snp.makeConstraints { (make) in
            make.right.equalTo(arrow.snp.left).offset(kScale(-12))
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
