//
//  BWHTableViewCell.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/15.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class BWHTableViewCell: UITableViewCell {

    var label: UILabel!
    var bTF: UITextField!   // 胸
    var wTF: UITextField!   // 腰
    var hTF: UITextField!   // 臀
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        label = UILabel.createLabel(16, textColor: UIColor(hex: 0x777777))
        label.text = "三围"
        contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(label.superview!).offset(kScale(15))
            make.centerY.equalTo(label.superview!)
            make.height.equalTo(kScale(16))
        }
        
        let arrow = UIImageView(image: UIImage(named: "open"))
        contentView.addSubview(arrow)
        arrow.snp.makeConstraints { (make) in
            make.right.equalTo(arrow.superview!).offset(kScale(-15))
            make.size.equalTo(kSize(8, height: 15))
            make.centerY.equalTo(arrow.superview!)
        }
        
        hTF = UITextField()
        hTF.delegate = self
        hTF.borderStyle = .Line
        hTF.font = UIFont.customFontOfSize(14)
        hTF.textAlignment = .Center
        contentView.addSubview(hTF)
        hTF.snp.makeConstraints { (make) in
            make.size.equalTo(kSize(35, height: 30))
            make.right.equalTo(arrow.snp.left).offset(kScale(-20))
            make.centerY.equalTo(arrow)
        }
        
        let hTFLabel = UILabel.createLabel(14)
        hTFLabel.text = "臀"
        contentView.addSubview(hTFLabel)
        hTFLabel.snp.makeConstraints { (make) in
            make.right.equalTo(hTF.snp.left).offset(kScale(-10))
            make.centerY.equalTo(arrow)
            make.height.equalTo(kScale(14))
        }
        
        wTF = UITextField()
        wTF.delegate = self
        wTF.borderStyle = .Line
        wTF.font = UIFont.customFontOfSize(14)
        wTF.textAlignment = .Center
        contentView.addSubview(wTF)
        wTF.snp.makeConstraints { (make) in
            make.size.equalTo(hTF)
            make.right.equalTo(hTFLabel.snp.left).offset(kScale(-18))
            make.centerY.equalTo(arrow)
        }
        
        let wTFLabel = UILabel.createLabel(14)
        wTFLabel.text = "腰"
        contentView.addSubview(wTFLabel)
        wTFLabel.snp.makeConstraints { (make) in
            make.right.equalTo(wTF.snp.left).offset(kScale(-10))
            make.centerY.equalTo(arrow)
            make.height.equalTo(kScale(14))
        }
        
        bTF = UITextField()
        bTF.delegate = self
        bTF.borderStyle = .Line
        bTF.font = UIFont.customFontOfSize(14)
        bTF.textAlignment = .Center
        contentView.addSubview(bTF)
        bTF.snp.makeConstraints { (make) in
            make.size.equalTo(hTF)
            make.right.equalTo(wTFLabel.snp.left).offset(kScale(-18))
            make.centerY.equalTo(arrow)
        }
        
        let bTFLabel = UILabel.createLabel(14)
        bTFLabel.text = "胸"
        contentView.addSubview(bTFLabel)
        bTFLabel.snp.makeConstraints { (make) in
            make.right.equalTo(bTF.snp.left).offset(kScale(-10))
            make.centerY.equalTo(arrow)
            make.height.equalTo(kScale(14))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension BWHTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(textField: UITextField) {
        
    }
}
