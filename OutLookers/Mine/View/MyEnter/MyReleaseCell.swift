//
//  MyReleaseCell.swift
//  OutLookers
//
//  Created by C on 16/7/18.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class MyReleaseCell: UITableViewCell {

    var info: FindNotice! {
        didSet {
            imgView.yy_setImageWithURL(info.picture.addImagePath(), placeholder: kPlaceholder)
            subjectLabel.text = info.theme
            if info.isRun == true {
                recruit.text = "停止招募"
                stopRecruit.hidden = true
                detailButton.snp.updateConstraints(closure: { (make) in
                    make.right.equalTo(editButton.snp.left).offset(kScale(-6))
                    make.size.equalTo(kSize(80, height: 28))
                })
            } else {
                stopRecruit.hidden = false
                recruit.text = "招募进行中"
                detailButton.snp.updateConstraints { (make) in
                    make.right.equalTo(stopRecruit.snp.left).offset(kScale(-6))
                    make.size.equalTo(kSize(80, height: 28))
                }
            }
            
            if info.num > 0 {
                enterCount.text = "报名人数：" + "\(info.num)"
            }
        }
    }
    var editBlock: ((btn: UIButton)->Void)!
    var stopBlock: ((btn: UIButton)->Void)!
    var detailBlock: ((btn: UIButton)->Void)!
    var imgView: UIImageView!
    var subjectLabel: UILabel!
    var enterCount: UILabel!    // 报名人数
    var recruit: UILabel!       // 招募机型中
    var detailButton: UIButton!
    var stopRecruit: UIButton!
    var editButton: UIButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        imgView = UIImageView()
        contentView.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.superview!).offset(kScale(16))
            make.top.equalTo(imgView.superview!).offset(kScale(15))
            make.size.equalTo(kSize(72, height: 72))
        }
        
        subjectLabel = UILabel()
        subjectLabel.font = UIFont.customNumFontOfSize(16)
        contentView.addSubview(subjectLabel)
        subjectLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.snp.right).offset(kScale(8))
            make.top.equalTo(subjectLabel.superview!).offset(kScale(20))
            make.height.equalTo(16)
        }
        
        enterCount = UILabel.createLabel(14, textColor: UIColor(hex: 0x666666))
        contentView.addSubview(enterCount)
        enterCount.snp.makeConstraints { (make) in
            make.left.equalTo(subjectLabel)
            make.top.equalTo(subjectLabel.snp.bottom).offset(kScale(10))
            make.height.equalTo(kScale(14))
        }
        
        recruit = UILabel.createLabel(14, textColor: UIColor(hex: 0x666666))
        contentView.addSubview(recruit)
        recruit.snp.makeConstraints { (make) in
            make.left.equalTo(enterCount)
            make.top.equalTo(enterCount.snp.bottom).offset(kScale(11))
            make.height.equalTo(kScale(14))
        }
        
        let lineV = UIView()
        lineV.backgroundColor = kLineColor
        contentView.addSubview(lineV)
        lineV.snp.makeConstraints { (make) in
            make.left.equalTo(lineV.superview!).offset(kScale(16))
            make.top.equalTo(recruit.snp.bottom).offset(kScale(13))
            make.right.equalTo(lineV.superview!)
            make.height.equalTo(1)
        }
        
        editButton = UIButton()
        editButton.setTitle("编辑", forState: .Normal)
        editButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        editButton.layer.borderColor = UIColor.blackColor().CGColor
        editButton.layer.borderWidth = 1
        editButton.layer.cornerRadius = kScale(4)
        editButton.titleLabel!.font = UIFont.customFontOfSize(14)
        contentView.addSubview(editButton)
        editButton.snp.makeConstraints { (make) in
            make.right.equalTo(editButton.superview!).offset(kScale(-15))
            make.top.equalTo(lineV.snp.bottom).offset(kScale(6))
            make.size.equalTo(kSize(80, height: 28))
            make.bottom.lessThanOrEqualTo(editButton.superview!).offset(kScale(-6))
        }
        
        stopRecruit = UIButton()
        stopRecruit.setTitle("停止招募", forState: .Normal)
        stopRecruit.setTitleColor(UIColor.blackColor(), forState: .Normal)
        stopRecruit.layer.borderColor = UIColor.blackColor().CGColor
        stopRecruit.layer.borderWidth = 1
        stopRecruit.layer.cornerRadius = kScale(4)
        stopRecruit.titleLabel!.font = UIFont.customFontOfSize(14)
        contentView.addSubview(stopRecruit)
        stopRecruit.snp.makeConstraints { (make) in
            make.right.equalTo(editButton.snp.left).offset(kScale(-6)).priorityMedium()
            make.centerY.equalTo(editButton)
            make.size.equalTo(editButton).priorityMedium()
        }
        
        detailButton = UIButton()
        detailButton.setTitle("查看详情", forState: .Normal)
        detailButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        detailButton.layer.borderColor = UIColor.blackColor().CGColor
        detailButton.layer.borderWidth = 1
        detailButton.layer.cornerRadius = kScale(4)
        detailButton.titleLabel!.font = UIFont.customFontOfSize(14)
        contentView.addSubview(detailButton)
        detailButton.snp.makeConstraints { (make) in
            make.right.equalTo(stopRecruit.snp.left).offset(kScale(-6)).priorityMedium()
            make.centerY.equalTo(editButton)
            make.size.equalTo(editButton).priorityMedium()
        }
        
        editButton.rx_tap.subscribeNext { [unowned self] in
            if self.editBlock != nil {
                self.editBlock(btn: self.editButton)
            }
        }.addDisposableTo(disposeBag)
        
        stopRecruit.rx_tap.subscribeNext { [unowned self] in
            if self.stopBlock != nil {
                self.stopBlock(btn: self.stopRecruit)
            }
        }.addDisposableTo(disposeBag)
        
        detailButton.rx_tap.subscribeNext { [unowned self] in
            if self.detailBlock != nil {
                self.detailBlock(btn: self.detailButton)
            }
        }.addDisposableTo(disposeBag)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
