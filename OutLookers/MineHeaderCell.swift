//
//  PersonalHeaderCell.swift
//  OutLookers
//
//  Created by C on 16/7/1.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private extension Selector {
    static let tapEditData = #selector(MineHeaderCell.tapEditData)
    static let tapFriends = #selector(MineHeaderCell.tapFriends)
    static let tapFollows = #selector(MineHeaderCell.tapFollows)
    static let tapFans = #selector(MineHeaderCell.tapFans)
}

class MineHeaderCell: UITableViewCell {

    typealias EditDataClosure = () -> ()
    typealias TapFriendClosure = () -> ()
    typealias TapFollowClosure = () -> ()
    typealias TapFanClosure = () -> ()
    var editClosure: EditDataClosure!
    var friendClosure: TapFriendClosure!
    var followClosure: TapFollowClosure!
    var fanClosure: TapFanClosure!
    
    var header: IconHeaderView!
    var name: UILabel!
    var _dynamic: UILabel!
    var follow: UILabel!
    var fans: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        // 头像部分
        header = IconHeaderView()
        header.iconPlaceholder = kHeadPlaceholder
        header.customCornerRadius = kScale(59/2)
        contentView.addSubview(header)
        
        name = UILabel()
        name.font = UIFont.customFontOfSize(16)
        name.text = "小包子"
        contentView.addSubview(name)
        
        let editDataContainer = UIView()
        editDataContainer.layer.cornerRadius = kScale(25/2)
        editDataContainer.layer.borderColor = kGrayColor.CGColor
        editDataContainer.layer.borderWidth = 1
        contentView.addSubview(editDataContainer)
        
        let tap = UITapGestureRecognizer(target: self, action: .tapEditData)
        editDataContainer.addGestureRecognizer(tap)
        
        let penImgView = UIImageView(image: UIImage(named: "Edit"))
        editDataContainer.addSubview(penImgView)
        
        let editDataLabel = UILabel()
        editDataLabel.font = UIFont.customFontOfSize(12)
        editDataLabel.textColor = kGrayColor
        editDataLabel.text = "编辑资料"
        editDataContainer.addSubview(editDataLabel)
        
        let lineV = UIView()
        lineV.backgroundColor = kLineColor
        contentView.addSubview(lineV)
        
        header.snp.makeConstraints { (make) in
            make.top.left.equalTo(header.superview!).offset(kScale(15))
            make.size.equalTo(kSize(59, height: 59))
        }
        
        name.snp.makeConstraints { (make) in
            make.left.equalTo(header.snp.right).offset(kScale(11))
            make.centerY.equalTo(header)
        }
        
        editDataContainer.snp.makeConstraints { (make) in
            make.right.equalTo(editDataContainer.superview!).offset(kScale(-20))
            make.centerY.equalTo(header)
            make.size.equalTo(kSize(90, height: 25))
        }
        
        editDataLabel.snp.makeConstraints { (make) in
            make.left.equalTo(editDataLabel.superview!).offset(kScale(14))
            make.centerY.equalTo(editDataLabel.superview!)
        }
        
        penImgView.snp.makeConstraints { (make) in
            make.size.equalTo(kSize(11, height: 11))
            make.centerY.equalTo(penImgView.superview!)
            make.left.equalTo(editDataLabel.snp.right).offset(kScale(5))
        }
        
        lineV.snp.makeConstraints { (make) in
            make.top.equalTo(header.snp.bottom).offset(kScale(20))
            make.left.right.equalTo(lineV.superview!)
            make.height.equalTo(1)
        }
        
        // tool
        let toolContainer = UIView()
        contentView.addSubview(toolContainer)
        
        toolContainer.snp.makeConstraints { (make) in
            make.top.equalTo(lineV.snp.bottom)
            make.left.right.equalTo(toolContainer.superview!)
            make.bottom.equalTo(toolContainer.superview!)
        }
        
        // 好友
        let dynamicContainer = UIView()
        toolContainer.addSubview(dynamicContainer)
        
        let tapFriend = UITapGestureRecognizer(target: self, action: .tapFriends)
        dynamicContainer.addGestureRecognizer(tapFriend)
        
        _dynamic = UILabel()
        _dynamic.text = "123"
        _dynamic.textAlignment = .Center
        _dynamic.font = UIFont.customFontOfSize(16)
        dynamicContainer.addSubview(_dynamic)
        
        let dynamicLabel = UILabel()
        dynamicLabel.text = "动态"
        dynamicLabel.font = UIFont.customFontOfSize(12)
        dynamicLabel.textAlignment = .Center
        dynamicLabel.textColor = UIColor(hex: 0x999999)
        dynamicContainer.addSubview(dynamicLabel)
        
        dynamicContainer.snp.makeConstraints { (make) in
            make.top.equalTo(toolContainer)
            make.left.equalTo(dynamicContainer.superview!)
            make.width.equalTo(dynamicContainer.superview!).multipliedBy(1.0/3.0)
            make.height.equalTo(toolContainer)
        }
        
        _dynamic.snp.makeConstraints { (make) in
            make.left.right.equalTo(_dynamic.superview!)
            make.top.equalTo(_dynamic.superview!).offset(kScale(8))
            make.height.equalTo(kScale(19))
        }
        
        dynamicLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(dynamicLabel.superview!)
            make.top.equalTo(_dynamic.snp.bottom)
            make.height.equalTo(kScale(12))
        }
        
        let verticalLine1 = UIView()
        verticalLine1.backgroundColor = kLineColor
        toolContainer.addSubview(verticalLine1)
        
        verticalLine1.snp.makeConstraints { (make) in
            make.left.equalTo(dynamicContainer.snp.right)
            make.size.equalTo(CGSize(width: 1, height: 24))
            make.centerY.equalTo(verticalLine1.superview!)
        }
        
        // 关注
        let followContainer = UIView()
        toolContainer.addSubview(followContainer)
        
        let tapFollow = UITapGestureRecognizer(target: self, action: .tapFollows)
        followContainer.addGestureRecognizer(tapFollow)
        
        follow = UILabel()
        follow.text = "248"
        follow.textAlignment = .Center
        follow.font = UIFont.customFontOfSize(16)
        followContainer.addSubview(follow)
        
        let followLabel = UILabel()
        followLabel.text = "关注"
        followLabel.font = UIFont.customFontOfSize(12)
        followLabel.textAlignment = .Center
        followLabel.textColor = UIColor(hex: 0x999999)
        followContainer.addSubview(followLabel)
        
        followContainer.snp.makeConstraints { (make) in
            make.top.equalTo(toolContainer)
            make.left.equalTo(dynamicContainer.snp.right)
            make.width.equalTo(dynamicContainer)
            make.height.equalTo(toolContainer)
        }
        
        follow.snp.makeConstraints { (make) in
            make.left.right.equalTo(follow.superview!)
            make.top.equalTo(follow.superview!).offset(kScale(8))
            make.height.equalTo(kScale(19))
        }
        
        followLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(followLabel.superview!)
            make.top.equalTo(follow.snp.bottom)
            make.height.equalTo(kScale(12))
        }
        
        let verticalLine2 = UIView()
        verticalLine2.backgroundColor = kLineColor
        toolContainer.addSubview(verticalLine2)
        
        verticalLine2.snp.makeConstraints { (make) in
            make.left.equalTo(followContainer.snp.right)
            make.size.equalTo(CGSize(width: 1, height: 24))
            make.centerY.equalTo(verticalLine2.superview!)
        }
        
        // 粉丝
        let fansContainer = UIView()
        toolContainer.addSubview(fansContainer)
        
        let tapFan = UITapGestureRecognizer(target: self, action: .tapFans)
        fansContainer.addGestureRecognizer(tapFan)
        
        fans = UILabel()
        fans.text = "1278"
        fans.textAlignment = .Center
        fans.font = UIFont.customFontOfSize(16)
        fansContainer.addSubview(fans)
        
        let fansLabel = UILabel()
        fansLabel.text = "粉丝"
        fansLabel.font = UIFont.customFontOfSize(12)
        fansLabel.textAlignment = .Center
        fansLabel.textColor = UIColor(hex: 0x999999)
        fansContainer.addSubview(fansLabel)
        
        fansContainer.snp.makeConstraints { (make) in
            make.top.equalTo(toolContainer)
            make.left.equalTo(followContainer.snp.right)
            make.width.equalTo(followContainer)
            make.height.equalTo(toolContainer)
        }
        
        fans.snp.makeConstraints { (make) in
            make.left.right.equalTo(fans.superview!)
            make.top.equalTo(fans.superview!).offset(kScale(8))
            make.height.equalTo(kScale(19))
        }
        
        fansLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(fansLabel.superview!)
            make.top.equalTo(fans.snp.bottom)
            make.height.equalTo(kScale(12))
        }
    }
    
    func tapEditData() {
        if self.editClosure != nil {
            self.editClosure()
        }
    }
    
    func tapFriends() {
        if self.friendClosure != nil {
            self.friendClosure()
        }
    }
    
    func tapFollows() {
        if self.followClosure != nil {
            self.followClosure()
        }
    }
    
    func tapFans() {
        if self.fanClosure != nil {
            self.fanClosure()
        }
    }
    
    func tapEditDataClosure(closure: EditDataClosure) {
        self.editClosure = closure
    }
    
    func tapFriendsClosure(closure: TapFriendClosure) {
        self.friendClosure  = closure
    }
    
    func tapFollowClosure(closure: TapFollowClosure) {
        self.followClosure = closure
    }
    
    func tapFanClosure(closure: TapFanClosure) {
        self.fanClosure = closure
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
