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
        debugPrint("add = \(recruit.count)")
        for (index,r) in recruit.enumerate() {
            let button = UIButton()
            let title = "\(r.skill)-\(r.service == nil ? "1" : r.service)人-\(r.skillPrice)元"
            let size = (title as NSString).sizeWithFonts(16)
            button.setTitle(title, forState: .Normal)
            button.setTitleColor(kGrayColor, forState: .Normal)
            button.titleLabel?.font = UIFont.systemFontOfSize(16)
            button.layer.cornerRadius = 15
            button.layer.borderColor = kGrayColor.CGColor
            button.layer.borderWidth = 1
            contentView.addSubview(button)
            debugPrint("index = \(index)")
            
            button.snp.makeConstraints(closure: { (make) in
                make.top.equalTo(last == nil ? recruitLabel.snp.bottom : last!.snp.bottom).offset(last == nil ? 15 : 8)
                make.size.equalTo(CGSize(width: size.width + 10, height: 30))
                make.left.equalTo(15)
            })
            last = button
            if index == recruit.count - 1 {
                addButton.snp.updateConstraints(closure: { (make) in
                    make.top.greaterThanOrEqualTo(last!.snp.bottom).offset(8).priorityHigh()
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
        recruitLabel.font = UIFont.systemFontOfSize(16)
        contentView.addSubview(recruitLabel)
        
        
        addButton = UIButton()
        addButton.setImage(UIImage(named: "release_announcement_addto"), forState: .Normal)
        addButton.addTarget(self, action: .tapAdd, forControlEvents: .TouchUpInside)
        contentView.addSubview(addButton)
        
        recruitLabel.snp.makeConstraints { (make) in
            make.left.equalTo(recruitLabel.superview!).offset(15)
            make.top.equalTo(recruitLabel.superview!).offset(12)
            make.height.equalTo(16)
        }
        
        addButton.snp.makeConstraints(closure: { (make) in
            make.size.equalTo(CGSize(width: 60, height: 30))
            make.top.equalTo(recruitLabel.snp.bottom).offset(15).priorityLow()
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
