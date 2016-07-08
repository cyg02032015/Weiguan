//
//  DataTableViewCell.swift
//  OutLookers
//
//  Created by C on 16/7/7.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {

    var sexLabel: UILabel!          // 性别
    var ageLabel: UILabel!          // 年龄
    var addressLabel: UILabel!      // 常住地
    var heightLabel: UILabel!       // 身高
    var weightLabel: UILabel!       // 体重
    var braLabel: UILabel!          // 胸围
    var waistlineLabel: UILabel!    // 腰围
    var hiplineLabel: UILabel!      // 臀围
    var constellatoryLabel: UILabel!// 星座
    
    let basicFont: CGFloat = 14
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        
        // 第一行
        let lineImgView1 = UIImageView(image: UIImage(named: "home_lead"))
        contentView.addSubview(lineImgView1)
        lineImgView1.snp.makeConstraints { (make) in
            make.top.equalTo(lineImgView1.superview!).offset(kScale(16))
            make.left.equalTo(lineImgView1.superview!).offset(kScale(15))
            make.size.equalTo(kSize(4, height: 15))
        }
        
        let basicDataLabel = UILabel()
        basicDataLabel.font = UIFont.customFontOfSize(16)
        contentView.addSubview(basicDataLabel)
        basicDataLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(lineImgView1)
            make.left.equalTo(lineImgView1.snp.right).offset(kScale(5))
            make.height.equalTo(kScale(16))
        }
        
        let editBtn1 = UIButton()
        editBtn1.setImage(UIImage(named: "Fill"), forState: .Normal)
        contentView.addSubview(editBtn1)
        editBtn1.snp.makeConstraints { (make) in
            make.centerY.equalTo(basicDataLabel)
            make.right.equalTo(editBtn1.superview!).offset(kScale(-15))
            make.size.equalTo(kSize(15, height: 17))
        }
        
        // 基本资料各种属性
        sexLabel = UILabel()
        sexLabel.font = UIFont.customFontOfSize(basicFont)
        contentView.addSubview(sexLabel)
        sexLabel.snp.makeConstraints { (make) in
            make.left.equalTo(lineImgView1)
            make.top.equalTo(basicDataLabel.snp.bottom).offset(kScale(9))
            make.height.equalTo(kScale(basicFont))
        }
        
        heightLabel = UILabel()
        heightLabel.font = UIFont.customFontOfSize(basicFont)
        contentView.addSubview(heightLabel)
        heightLabel.snp.makeConstraints { (make) in
            make.left.equalTo(sexLabel)
            make.top.equalTo(sexLabel.snp.bottom).offset(kScale(5))
            make.height.equalTo(kScale(basicFont))
        }
        
        waistlineLabel = UILabel()
        waistlineLabel.font = UIFont.customFontOfSize(basicFont)
        contentView.addSubview(waistlineLabel)
        waistlineLabel.snp.makeConstraints { (make) in
            make.left.equalTo(heightLabel)
            make.top.equalTo(heightLabel.snp.bottom).offset(kScale(5))
            make.height.equalTo(kScale(basicFont))
        }
        
        ageLabel = UILabel()
        ageLabel.font = UIFont.customFontOfSize(basicFont)
        contentView.addSubview(ageLabel)
        ageLabel.snp.makeConstraints { (make) in
            make.left.greaterThanOrEqualTo(sexLabel.snp.right).offset(kScale(40))
            make.centerY.equalTo(sexLabel)
            make.height.equalTo(kScale(basicFont))
        }
        
        weightLabel = UILabel()
        weightLabel.font = UIFont.customFontOfSize(basicFont)
        contentView.addSubview(weightLabel)
        weightLabel.snp.makeConstraints { (make) in
            make.left.equalTo(ageLabel)
            make.centerY.equalTo(heightLabel)
            make.height.equalTo(kScale(15))
        }
        
        hiplineLabel = UILabel()
        hiplineLabel.font = UIFont.customFontOfSize(basicFont)
        contentView.addSubview(hiplineLabel)
        hiplineLabel.snp.makeConstraints { (make) in
            make.left.equalTo(ageLabel)
            make.centerY.equalTo(waistlineLabel)
            make.height.equalTo(kScale(basicFont))
        }
        
        addressLabel = UILabel()
        addressLabel.font = UIFont.customFontOfSize(basicFont)
        contentView.addSubview(addressLabel)
        addressLabel.snp.makeConstraints { (make) in
            make.left.greaterThanOrEqualTo(ageLabel.snp.right).offset(kScale(40))
            make.centerY.equalTo(ageLabel)
            make.height.equalTo(kScale(basicFont))
        }
        
        braLabel = UILabel()
        braLabel.font = UIFont.customFontOfSize(basicFont)
        contentView.addSubview(braLabel)
        braLabel.snp.makeConstraints { (make) in
            make.left.equalTo(addressLabel)
            make.centerY.equalTo(weightLabel)
            make.height.equalTo(kScale(basicFont))
        }
        
        constellatoryLabel = UILabel()
        constellatoryLabel.font = UIFont.customFontOfSize(basicFont)
        contentView.addSubview(constellatoryLabel)
        constellatoryLabel.snp.makeConstraints { (make) in
            make.left.equalTo(addressLabel)
            make.centerY.equalTo(hiplineLabel)
            make.height.equalTo(kScale(basicFont))
        }
        
        let lineV1 = UIView()
        lineV1.backgroundColor = kLineColor
        contentView.addSubview(lineV1)
        lineV1.snp.makeConstraints { (make) in
            make.top.left.equalTo(lineV1.superview!).offset(kScale(15))
            make.right.equalTo(lineV1.superview!).offset(kScale(-15))
            make.height.equalTo(1)
        }
        
        // 第二行
        let lineImgView2 = UIImageView(image: UIImage(named: "home_lead"))
        contentView.addSubview(lineImgView2)
        lineImgView2.snp.makeConstraints { (make) in
            make.top.equalTo(lineV1.snp.bottom).offset(kScale(15))
            make.left.equalTo(lineImgView1)
            make.size.equalTo(kSize(4, height: 15))
        }
        // 个人特征
        let featureLabel = UILabel()
        featureLabel.font = UIFont.customFontOfSize(16)
        contentView.addSubview(featureLabel)
        featureLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(lineImgView2)
            make.left.equalTo(lineImgView2.snp.right).offset(kScale(5))
            make.height.equalTo(kScale(16))
        }
        
        let editBtn2 = UIButton()
        editBtn2.setImage(UIImage(named: "Fill"), forState: .Normal)
        contentView.addSubview(editBtn2)
        editBtn2.snp.makeConstraints { (make) in
            make.centerY.equalTo(featureLabel)
            make.right.equalTo(editBtn2.superview!).offset(kScale(-15))
            make.size.equalTo(kSize(15, height: 17))
        }
        
        
        
        basicDataLabel.text = "基本资料"
        sexLabel.text = "性别：女"
        ageLabel.text = "年龄：26"
        addressLabel.text = "常住地：北京市"
        heightLabel.text = "身高：178cm"
        weightLabel.text = "体重：45kg"
        braLabel.text = "胸围：82cm"
        waistlineLabel.text = "腰围：60cm"
        hiplineLabel.text = "臀围：82cm"
        constellatoryLabel.text = "星座：天蝎座"
        
        featureLabel.text = "个人特征"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
