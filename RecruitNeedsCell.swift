//
//  RecruitNeesCell.swift
//  OutLookers
//
//  Created by C on 16/6/18.
//  Copyright © 2016年 weiguanonline. All rights reserved.
// 招募需求

import UIKit

private extension Selector {
    static let tapAdd = #selector(RecruitNeedsCell.tapAdd(_:))
}

protocol RecruitNeedsCellDelegate: class {
    func recruitNeedsAddRecruite(sender: UIButton)
}

class RecruitNeedsCell: UITableViewCell {

    weak var delegate: RecruitNeedsCellDelegate!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        
        let recruitLabel = UILabel()
        recruitLabel.text = "招募需求"
        recruitLabel.font = UIFont.systemFontOfSize(16)
        contentView.addSubview(recruitLabel)
        
        
        let addButton = UIButton()
        addButton.setImage(UIImage(named: "release_announcement_addto"), forState: .Normal)
        addButton.addTarget(self, action: .tapAdd, forControlEvents: .TouchUpInside)
        contentView.addSubview(addButton)
        
        let recruitButton = UIButton()
        recruitButton.layer.cornerRadius = 20
        recruitButton.layer.borderColor = UIColor.blackColor().CGColor
        recruitButton.layer.borderWidth = 1
        recruitButton.setTitle("唱歌表演-6人-1000元", forState: .Normal)
        recruitButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        contentView.addSubview(recruitButton)
        
        recruitLabel.snp.makeConstraints { (make) in
            make.left.equalTo(recruitLabel.superview!).offset(15)
            make.top.equalTo(recruitLabel.superview!).offset(12)
            make.height.equalTo(16)
        }
        
        addButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 60, height: 30))
            make.top.equalTo(recruitLabel.snp.bottom).offset(8)
            make.left.equalTo(recruitLabel)
        }
    }
    
    func tapAdd(sender: UIButton) {
        delegate.recruitNeedsAddRecruite(sender)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
