//
//  InvitedTableViewCell.swift
//  OutLookers
//
//  Created by C on 16/8/28.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class InvitedTableViewCell: UITableViewCell {

    var concerned: Int! {
        didSet {
            if let _ = info {
                follow.hidden = "\(info!.userId)" == UserSingleton.sharedInstance.userId
            }
            if !follow.hidden {
                follow.hidden = concerned == 1
            }
        }
    }
    var nameLabel: UILabel!
    var follow: UIButton!
    var subject: UILabel!
    var container: UIView!
    var time: UILabel!
    var local: UILabel!
    var time1: UILabel!
    var lastLabel: UILabel!
    
    var info: FindNoticeDetailResp? {
        didSet {
            guard let _ = info else { return }
            if "\(info!.userId)" == UserSingleton.sharedInstance.userId {
                follow.hidden = true
            }
            subject.text = info!.theme
            let start = CPDateUtil.dateToString(CPDateUtil.stringToDate(info!.startTime), dateFormat: "yyyy-MM-dd") ?? ""
            let end = CPDateUtil.dateToString(CPDateUtil.stringToDate(info!.endTime), dateFormat: "yyyy-MM-dd") ?? ""
            time.text = start + " 至 " + end
            local.text = info!.province + info!.city + info!.adds
            time1.text = CPDateUtil.dateToString(CPDateUtil.stringToDate(info!.register), dateFormat: "yyyy-MM-dd") ?? ""
            
            for (idx, obj) in info!.recruitmentList.enumerate() {
                let label = UILabel.createLabel(14)
                label.text = obj.categoryName + "(\(obj.number)人、\(obj.price)元\(Util.unit("\(obj.unit)")))"
                container.addSubview(label)
                label.snp.makeConstraints(closure: { (make) in
                    make.top.equalTo(lastLabel == nil ? label.superview! : lastLabel.snp.bottom).offset(idx == 0 ? 0 : kScale(10))
                    make.left.equalTo(label.superview!)
                    make.height.equalTo(kScale(14))
                })
                lastLabel = label
            }
            container.snp.updateConstraints { (make) in
                make.bottom.greaterThanOrEqualTo(lastLabel.snp.bottom).priorityLow()
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        
        
        follow = UIButton()
        follow.setImage(UIImage(named: "follow11"), forState: .Normal)
        contentView.addSubview(follow)
        follow.snp.makeConstraints { (make) in
            make.right.equalTo(follow.superview!).offset(kScale(-15))
            make.top.equalTo(follow.superview!).offset(kScale(10))
            make.size.equalTo(kSize(60, height: 24))
        }
        
        nameLabel = UILabel.createLabel(16)
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(55)
            make.centerY.equalTo(follow)
            make.height.equalTo(kScale(16))
        }
        
        let line1 = UIView()
        line1.backgroundColor = kLineColor
        contentView.addSubview(line1)
        line1.snp.makeConstraints { (make) in
            make.left.equalTo(line1.superview!).offset(kScale(15))
            make.right.equalTo(line1.superview!).offset(kScale(-15))
            make.height.equalTo(1)
            make.top.equalTo(nameLabel.snp.bottom).offset(kScale(17))
        }
        
        subject = UILabel()
        subject.font = UIFont.customNumFontOfSize(22)
        subject.numberOfLines = 0
        contentView.addSubview(subject)
        subject.snp.makeConstraints { (make) in
            make.left.equalTo(line1)
            make.top.equalTo(line1.snp.bottom).offset(kScale(15))
            make.right.equalTo(line1)
        }
        
        container = UIView()
        contentView.addSubview(container)
        container.snp.makeConstraints { (make) in
            make.left.equalTo(line1)
            make.right.equalTo(line1)
            make.top.equalTo(subject.snp.bottom).offset(kScale(10))
        }
        
        let line2 = UIView()
        line2.backgroundColor = kLineColor
        contentView.addSubview(line2)
        line2.snp.makeConstraints { (make) in
            make.left.right.equalTo(line1)
            make.top.equalTo(container.snp.bottom).offset(20)
            make.height.equalTo(1)
        }
        
        let timeImg = UIImageView(image: UIImage(named: "Page 1"))
        contentView.addSubview(timeImg)
        timeImg.snp.makeConstraints { (make) in
            make.left.equalTo(line2)
            make.top.equalTo(line2.snp.bottom).offset(kScale(16))
            make.size.equalTo(kSize(15, height: 15))
        }
        
        time = UILabel.createLabel(14)
        contentView.addSubview(time)
        time.snp.makeConstraints { (make) in
            make.left.equalTo(timeImg.snp.right).offset(kScale(4))
            make.centerY.equalTo(timeImg)
            make.right.equalTo(line2)
            make.height.equalTo(kScale(14))
        }
        
        let line3 = UIView()
        line3.backgroundColor = kLineColor
        contentView.addSubview(line3)
        line3.snp.makeConstraints { (make) in
            make.left.right.equalTo(line2)
            make.top.equalTo(timeImg.snp.bottom).offset(kScale(15))
            make.height.equalTo(1)
        }
        
        let localImg = UIImageView(image: UIImage(named: "Group 4"))
        contentView.addSubview(localImg)
        localImg.snp.makeConstraints { (make) in
            make.left.equalTo(line3)
            make.top.equalTo(line3.snp.bottom).offset(kScale(15))
            make.size.equalTo(kSize(14, height: 14))
        }
        
        local = UILabel.createLabel(14)
        contentView.addSubview(local)
        local.snp.makeConstraints { (make) in
            make.left.equalTo(localImg.snp.right).offset(kScale(5))
            make.centerY.equalTo(localImg)
            make.height.equalTo(kScale(14))
            make.right.equalTo(line3)
        }
        
        let line4 = UIView()
        line4.backgroundColor = kLineColor
        contentView.addSubview(line4)
        line4.snp.makeConstraints { (make) in
            make.left.right.equalTo(line3)
            make.height.equalTo(line3)
            make.top.equalTo(localImg.snp.bottom).offset(kScale(15))
        }
        
        let timeImg1 = UIImageView(image: UIImage(named: "Group 5"))
        contentView.addSubview(timeImg1)
        timeImg1.snp.makeConstraints { (make) in
            make.top.equalTo(line4.snp.bottom).offset(kScale(15))
            make.size.equalTo(kSize(15, height: 15))
            make.left.equalTo(line4)
        }
        
        time1 = UILabel.createLabel(14)
        contentView.addSubview(time1)
        time1.snp.makeConstraints { (make) in
            make.left.equalTo(timeImg1.snp.right).offset(kScale(4))
            make.centerY.equalTo(timeImg1)
            make.height.equalTo(kScale(14))
            make.right.equalTo(line4)
            make.bottom.lessThanOrEqualTo(time1.superview!).offset(kScale(-15))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
