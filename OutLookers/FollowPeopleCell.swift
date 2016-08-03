//
//  FollowPeopleCell.swift
//  OutLookers
//
//  Created by C on 16/6/30.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//
/*
 性别区别他、她；
 若没有则显示TA;
 */
//点击头像跳转至ta的个人主页；
import UIKit

class FollowPeopleCell: UITableViewCell {

    var info: FollowList! {
        didSet {
            header.iconURL = info.photo
            header.setVimage(Util.userType(info.detailsType))
            nameLabel.text = info.name
            
            if info.fan == 0 { // 非互相关注
                if showType == .Follow {
                    followButton.hidden = true
                } else {
                    followButton.hidden = false
                }
                followButton.selected = false
                followButton.snp.updateConstraints(closure: { (make) in
                    make.size.equalTo(kSize(60, height: 24))
                })
            } else {
                followButton.hidden = false
                followButton.selected = true
                followButton.snp.updateConstraints(closure: { (make) in
                    make.size.equalTo(kSize(87, height: 24))
                })
            }
            
            
        }
    }
    var showType: ShowType!
    var header: IconHeaderView!
    var nameLabel: UILabel!
    var followButton: UIButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        
        header = IconHeaderView()
        header.layer.cornerRadius = kScale(50/2)
        header.clipsToBounds = true
        contentView.addSubview(header)
        header.snp.makeConstraints { (make) in
            make.left.equalTo(header.superview!).offset(kScale(15))
            make.centerY.equalTo(header.superview!)
            make.size.equalTo(kSize(50, height: 50))
        }
        
        followButton = UIButton()
        followButton.setImage(UIImage(named: "follow11"), forState: .Normal)
        followButton.setImage(UIImage(named: "mutualFollow"), forState: .Selected)
        contentView.addSubview(followButton)
        followButton.snp.makeConstraints { (make) in
            make.right.equalTo(followButton.superview!).offset(kScale(-15))
            make.centerY.equalTo(followButton.superview!)
            make.size.equalTo(kSize(60, height: 24)).priorityLow()
        }
        
        nameLabel = UILabel()
        nameLabel.font = UIFont.customFontOfSize(16)
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(header.snp.right).offset(kScale(15))
            make.centerY.equalTo(nameLabel.superview!)
            make.right.equalTo(followButton.snp.left).offset(kScale(-15))
        }
        
        followButton.rx_tap.subscribeNext {
            LogInfo("关注点击")
        }.addDisposableTo(disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
