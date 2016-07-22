//
//  InvitationHeadCell.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/22.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class InvitationHeadCell: UITableViewCell {

    var promoter: IconHeaderView!
    var promoterLabel: UILabel!
    var invited: IconHeaderView!
    var invitedLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        let backImgView = UIImageView(image: UIImage(named: "Rectangle 249"))
        contentView.addSubview(backImgView)
        backImgView.snp.makeConstraints { (make) in
            make.top.equalTo(backImgView.superview!).offset(kScale(45))
            make.left.right.equalTo(backImgView.superview!)
            make.height.equalTo(kScale(5))
        }
        
        let imgView = UIImageView(image: UIImage(named: "invitation11"))
        contentView.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.top.equalTo(imgView.superview!).offset(kScale(35))
            make.centerX.equalTo(imgView.superview!)
            make.size.equalTo(kSize(23, height: 31))
        }
        
        promoter = IconHeaderView()
        promoter.customCornerRadius = kScale(60/2)
        contentView.addSubview(promoter)
        promoter.snp.makeConstraints { (make) in
            make.right.equalTo(imgView.snp.left).offset(kScale(-57))
            make.size.equalTo(kSize(60, height: 60))
            make.top.equalTo(promoter.superview!).offset(kScale(15))
        }
        
        promoterLabel = UILabel.createLabel(14)
        promoterLabel.textAlignment = .Center
        contentView.addSubview(promoterLabel)
        promoterLabel.snp.makeConstraints { (make) in
            make.top.equalTo(promoter.snp.bottom).offset(kScale(8))
            make.centerX.equalTo(promoter)
        }
        
        invited = IconHeaderView()
        invited.customCornerRadius = kScale(60/2)
        contentView.addSubview(invited)
        invited.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.snp.right).offset(kScale(55))
            make.top.equalTo(promoter)
            make.size.equalTo(promoter)
        }
        
        invitedLabel = UILabel.createLabel(14)
        invitedLabel.textAlignment = .Center
        contentView.addSubview(invitedLabel)
        invitedLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(invited)
            make.top.equalTo(invited.snp.bottom).offset(kScale(8))
        }
        
        promoterLabel.text = "发起人"
        invitedLabel.text = "邀约人"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
