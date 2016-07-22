//
//  InvitationTalentCell.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/22.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private extension Selector {
    static let tapPlush = #selector(InvitationTalentCell.tapPlush(_:))
    static let tapMinus = #selector(InvitationTalentCell.tapMinus(_:))
}

protocol InvitationTalentCellDelegate: class {
    func invitationTalentTapPlush(sender: UIButton, count: Int)
    func invitationTalentTapMinus(sender: UIButton, count: Int)
}

class InvitationTalentCell: UITableViewCell {

    weak var delegate: InvitationTalentCellDelegate!
    var imgView: UIImageView!
    var talentName: UILabel!
    var moneyLabel: UILabel!
    var minusButton: UIButton!
    var plushButton: UIButton!
    var countLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        imgView = UIImageView()
        contentView.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.superview!).offset(kScale(15))
            make.centerY.equalTo(imgView.superview!)
            make.size.equalTo(kSize(62, height: 62))
        }
        
        talentName = UILabel.createLabel(16)
        talentName.numberOfLines = 0
        contentView.addSubview(talentName)
        talentName.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.snp.right).offset(kScale(10))
            make.top.equalTo(talentName.superview!).offset(kScale(11))
            make.right.equalTo(talentName.superview!).offset(kScale(-15))
        }
        
        moneyLabel = UILabel.createLabel(14, textColor: UIColor(hex: 0xFF4E4E))
        contentView.addSubview(moneyLabel)
        moneyLabel.snp.makeConstraints { (make) in
            make.left.equalTo(talentName)
            make.bottom.equalTo(moneyLabel.superview!).offset(kScale(-9))
        }
        
        let container = UIView()
        container.layer.borderColor = UIColor(hex: 0xd9d9d9).CGColor
        container.layer.borderWidth = 0.5
        container.cornerRadius = kScale(3)
        contentView.addSubview(container)
        container.snp.makeConstraints { (make) in
            make.size.equalTo(kSize(82, height: 24))
            make.bottom.equalTo(container.superview!).offset(kScale(-10))
            make.right.equalTo(container.superview!).offset(kScale(-15))
        }
        
        plushButton = UIButton()
        plushButton.addTarget(self, action: .tapPlush, forControlEvents: .TouchUpInside)
        plushButton.setImage(UIImage(named: "increase"), forState: .Normal)
        plushButton.layer.borderWidth = 0.5
        plushButton.layer.borderColor = UIColor(hex: 0xd9d9d9).CGColor
        container.addSubview(plushButton)
        plushButton.snp.makeConstraints { (make) in
            make.right.top.bottom.equalTo(plushButton.superview!)
            make.width.equalTo(kScale(24))
        }
        
        minusButton = UIButton()
        minusButton.addTarget(self, action: .tapMinus, forControlEvents: .TouchUpInside)
        minusButton.setImage(UIImage(named: "Subtract"), forState: .Normal)
        minusButton.layer.borderWidth = 0.5
        minusButton.layer.borderColor = UIColor(hex: 0xd9d9d9).CGColor
        container.addSubview(minusButton)
        minusButton.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(minusButton.superview!)
            make.width.equalTo(plushButton)
        }
        
        countLabel = UILabel.createLabel(14)
        countLabel.textAlignment = .Center
        container.addSubview(countLabel)
        countLabel.snp.makeConstraints { (make) in
            make.left.equalTo(minusButton.snp.right)
            make.right.equalTo(plushButton.snp.left)
            make.top.bottom.equalTo(countLabel.superview!)
        }
        imgView.backgroundColor = UIColor.yellowColor()
        talentName.text = "才艺名称"
        moneyLabel.text = "1000元／天"
        
        
        countLabel.text = "1"
    }
    
    func tapPlush(sender: UIButton) {
        if delegate != nil {
            var count = Int(countLabel.text!)!
            if count >= 99  {
                return
            }
            count = count + 1
            countLabel.text = "\(count)"
            delegate.invitationTalentTapPlush(sender, count: count)
        }
    }
    
    func tapMinus(sender: UIButton) {
        if delegate != nil {
            var count = Int(countLabel.text!)!
            if count <= 1 {
                return
            }
            count = count - 1
            countLabel.text = "\(count)"
            delegate.invitationTalentTapMinus(sender, count: count)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
