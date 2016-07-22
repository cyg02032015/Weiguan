//
//  InvitationAddCell.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/22.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private extension Selector {
    static let tapAddButton = #selector(InvitationAddCell.tapAddButton(_:))
}

protocol InvitationAddCellDelegate: class {
    func invitationTapAddButton(sender: UIButton)
}

class InvitationAddCell: UITableViewCell {
    weak var delegate: InvitationAddCellDelegate!
    var addButton: UIButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        addButton = UIButton()
        addButton.addTarget(self, action: .tapAddButton, forControlEvents: .TouchUpInside)
        addButton.setImage(UIImage(named: "increase"), forState: .Normal)
        addButton.setTitleColor(UIColor(hex: 0xc0c0c0), forState: .Normal)
        addButton.titleLabel!.font = UIFont.customFontOfSize(16)
        contentView.addSubview(addButton)
        addButton.snp.makeConstraints { (make) in
            make.top.equalTo(kScale(10))
            make.left.equalTo(addButton.superview!).offset(kScale(15))
            make.right.equalTo(addButton.superview!).offset(kScale(-15))
            make.height.equalTo(kScale(40))
        }
        layoutIfNeeded()
        addButton.dottedLine(cornerRadios: kScale(5))
    }
    
    func tapAddButton(sender: UIButton) {
        if delegate != nil {
            delegate.invitationTapAddButton(sender)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}