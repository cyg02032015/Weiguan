//
//  RecruitNeesCell.swift
//  OutLookers
//
//  Created by C on 16/6/18.
//  Copyright © 2016年 weiguanonline. All rights reserved.
// 招募需求

import UIKit
import SnapKit

private extension Selector {
    static let tapAdd = #selector(RecruitNeedsCell.tapAdd(_:))
}

@objc protocol RecruitNeedsCellDelegate: class {
    optional func recruitNeedsAddRecruite(sender: UIButton)
}

class RecruitNeedsCell: UITableViewCell {

    weak var delegate: RecruitNeedsCellDelegate!
    var recruitLabel: UILabel!
    var addButton: UIButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func addRecuitNeedsButton(recruit: [Recruit]) {
        var last: UIButton?
        if recruit.count <= 0 {
            return
        }
        for (index,r) in recruit.enumerate() {
            var price: String!
            if let p = r.budgetPrice where r.budgetPrice?.characters.count > 0 {
                price = "\(p)元"
            } else {
                price = "价格待定"
            }
            let button = UIButton()
            let title = "\(r.skill)-\(r.recruitCount)人-\(price)"
            let size = (title as NSString).sizeWithFonts(16)
            button.setTitle(title, forState: .Normal)
            button.setTitleColor(kGrayColor, forState: .Normal)
            button.titleLabel?.font = UIFont.customFontOfSize(16)
            button.layer.cornerRadius = kScale(15)
            button.layer.borderColor = kGrayColor.CGColor
            button.layer.borderWidth = 1
            contentView.addSubview(button)
            
            button.snp.makeConstraints(closure: { (make) in
                make.top.equalTo(last == nil ? recruitLabel.snp.bottom : last!.snp.bottom).offset(last == nil ? kScale(15) : kScale(8))
                make.size.equalTo(kSize(size.width + 15, height: 30))
                make.left.equalTo(kScale(15))
            })
            last = button
            if index == recruit.count - 1 {
                addButton.snp.updateConstraints(closure: { (make) in
                    make.top.greaterThanOrEqualTo(last!.snp.bottom).offset(kScale(8)).priorityHigh()
                })
                setNeedsUpdateConstraints()
                updateConstraints()
                UIView.animateWithDuration(0.1, animations: {
                    self.layoutIfNeeded()
                })
            }
        }
    }
    
    override class func requiresConstraintBasedLayout() -> Bool {
        return true
    }
    
    func setupSubViews() {
        
        recruitLabel = UILabel()
        recruitLabel.text = "招募需求"
        recruitLabel.font = UIFont.customFontOfSize(16)
        contentView.addSubview(recruitLabel)
        
        
        addButton = UIButton()
        addButton.setImage(UIImage(named: "release_announcement_addto"), forState: .Normal)
        addButton.addTarget(self, action: .tapAdd, forControlEvents: .TouchUpInside)
        contentView.addSubview(addButton)
        
        recruitLabel.snp.makeConstraints { (make) in
            make.left.equalTo(recruitLabel.superview!).offset(kScale(15))
            make.top.equalTo(recruitLabel.superview!).offset(kScale(12))
            make.height.equalTo(kScale(16))
        }
        
        addButton.snp.makeConstraints(closure: { (make) in
            make.size.equalTo(kSize(60, height: 30))
            make.top.equalTo(recruitLabel.snp.bottom).offset(kScale(15)).priorityLow()
            make.left.equalTo(recruitLabel)
        })
    }
    func tapAdd(sender: UIButton) {
        delegate.recruitNeedsAddRecruite!(sender)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
