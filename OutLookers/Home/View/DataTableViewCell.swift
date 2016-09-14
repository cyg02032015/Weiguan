//
//  DataTableViewCell.swift
//  OutLookers
//
//  Created by C on 16/7/7.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//  若用户没有编辑则显示框架，数字显示0

import UIKit

class DataTableViewCell: UITableViewCell {

    var req: PersonFilesReq? {
        didSet {
            guard let _ = req else { return }
            if req!.sex == 0 {
                sexLabel.text = "性别: " + "未知"
            }else if req!.sex == 1 {
                sexLabel.text = "性别: " + "男"
            }else {
                sexLabel.text = "性别：" + "女"
            }
            ageLabel.text = "年龄：" + CPDateUtil.stringToDate(req!.birthday).ageWithDateOfBirth()
            addressLabel.text = "常住地：" + req!.province + req!.city
            heightLabel.text = "身高：" + req!.height
            weightLabel.text = "体重：" + req!.weight
            braLabel.text = "胸围：" + req!.bust
            waistlineLabel.text = "腰围：" + req!.waist
            hiplineLabel.text = "臀围：" + req!.hipline
            constellatoryLabel.text = "星座：" + req!.constellation
            style.text = "风格特征："
            appearance.text = "外貌特征: "
            shape.text = "体型特征："
            charm.text = "魅力部位："
            
            if req!.array.count > 0 {
                setText(req!.array[0])
            }
            if req!.array.count > 1 {
                setText(req!.array[1])
            }
            if req!.array.count > 2 {
                setText(req!.array[2])
            }
            if req!.array.count > 3 {
                setText(req!.array[3])
            }
            
            experence.text = req!.experience
            
        }
    }
    var sexLabel: UILabel!          // 性别
    var ageLabel: UILabel!          // 年龄
    var addressLabel: UILabel!      // 常住地
    var heightLabel: UILabel!       // 身高
    var weightLabel: UILabel!       // 体重
    var braLabel: UILabel!          // 胸围
    var waistlineLabel: UILabel!    // 腰围
    var hiplineLabel: UILabel!      // 臀围
    var constellatoryLabel: UILabel!// 星座
    var style: UILabel!             // 风格
    var appearance: UILabel!        // 外貌
    var shape: UILabel!             // 体型
    var charm: UILabel!             // 魅力
    var experence: UILabel!         // 通告经验
    
    let basicFont: CGFloat = 14
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    private func setText(text: String) {
        if text.hasPrefix("风格特征") {
            style.text = text
        }else if text.hasPrefix("外貌特征") {
            appearance.text = text
        }else if text.hasPrefix("体型特征") {
            shape.text = text
        }else if text.hasPrefix("魅力部位") {
            charm.text = text
        }
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
        
        let basicDataLabel = UILabel.createLabel(16)
        contentView.addSubview(basicDataLabel)
        basicDataLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(lineImgView1)
            make.left.equalTo(lineImgView1.snp.right).offset(kScale(5))
            make.height.equalTo(kScale(16))
        }
        
//        let editBtn1 = UIButton()
//        editBtn1.setImage(UIImage(named: "Fill"), forState: .Normal)
//        contentView.addSubview(editBtn1)
//        editBtn1.snp.makeConstraints { (make) in
//            make.centerY.equalTo(basicDataLabel)
//            make.right.equalTo(editBtn1.superview!).offset(kScale(-15))
//            make.size.equalTo(kSize(15, height: 17))
//        }
        
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
            make.top.equalTo(waistlineLabel.snp.bottom).offset(kScale(15))
            make.left.equalTo(lineV1.superview!).offset(kScale(15))
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
        let featureLabel = UILabel.createLabel(16)
        contentView.addSubview(featureLabel)
        featureLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(lineImgView2)
            make.left.equalTo(lineImgView2.snp.right).offset(kScale(5))
            make.height.equalTo(kScale(16))
        }
        
//        let editBtn2 = UIButton()
//        editBtn2.setImage(UIImage(named: "Fill"), forState: .Normal)
//        contentView.addSubview(editBtn2)
//        editBtn2.snp.makeConstraints { (make) in
//            make.centerY.equalTo(featureLabel)
//            make.right.equalTo(editBtn2.superview!).offset(kScale(-15))
//            make.size.equalTo(kSize(15, height: 17))
//        }
        
        style = UILabel.createLabel(14)
        contentView.addSubview(style)
        style.snp.makeConstraints { (make) in
            make.left.equalTo(lineImgView2)
            make.top.equalTo(featureLabel.snp.bottom).offset(kScale(10))
            make.height.equalTo(kScale(16))
            make.right.equalTo(style.superview!).offset(kScale(-15))
        }
        
        appearance = UILabel.createLabel(14)
        contentView.addSubview(appearance)
        appearance.snp.makeConstraints { (make) in
            make.left.equalTo(style)
            make.top.equalTo(style.snp.bottom).offset(kScale(6))
            make.height.equalTo(style)
            make.right.equalTo(style)
        }
        
        shape = UILabel.createLabel(14)
        contentView.addSubview(shape)
        shape.snp.makeConstraints { (make) in
            make.left.equalTo(appearance)
            make.top.equalTo(appearance.snp.bottom).offset(kScale(6))
            make.height.equalTo(appearance)
            make.right.equalTo(appearance)
        }
        
        charm = UILabel.createLabel(14)
        contentView.addSubview(charm)
        charm.snp.makeConstraints { (make) in
            make.left.equalTo(shape)
            make.top.equalTo(shape.snp.bottom).offset(kScale(6))
            make.height.equalTo(shape)
            make.right.equalTo(shape)
        }
        
        let lineV2 = UIView()
        lineV2.backgroundColor = kLineColor
        contentView.addSubview(lineV2)
        lineV2.snp.makeConstraints { (make) in
            make.top.equalTo(charm.snp.bottom).offset(kScale(15))
            make.left.equalTo(lineV2.superview!).offset(kScale(15))
            make.right.equalTo(lineV2.superview!).offset(kScale(-15))
            make.height.equalTo(1)
        }
        
        // 第三行
        let lineImgView3 = UIImageView(image: UIImage(named: "home_lead"))
        contentView.addSubview(lineImgView3)
        lineImgView3.snp.makeConstraints { (make) in
            make.top.equalTo(lineV2.snp.bottom).offset(kScale(15))
            make.left.equalTo(lineImgView1)
            make.size.equalTo(kSize(4, height: 15))
        }
        
        // 通告经验
        let experenceLabel = UILabel.createLabel(16)
        contentView.addSubview(experenceLabel)
        experenceLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(lineImgView3)
            make.left.equalTo(lineImgView3.snp.right).offset(kScale(5))
            make.height.equalTo(kScale(16))
        }
        
//        let editBtn3 = UIButton()
//        editBtn3.setImage(UIImage(named: "Fill"), forState: .Normal)
//        contentView.addSubview(editBtn3)
//        editBtn3.snp.makeConstraints { (make) in
//            make.centerY.equalTo(experenceLabel)
//            make.right.equalTo(editBtn3.superview!).offset(kScale(-15))
//            make.size.equalTo(kSize(15, height: 17))
//        }
        
        experence = UILabel.createLabel(14)
        contentView.addSubview(experence)
        experence.snp.makeConstraints { (make) in
            make.top.equalTo(experenceLabel.snp.bottom).offset(kScale(9))
            make.left.equalTo(lineImgView3)
            make.height.equalTo(kScale(14))
            make.right.equalTo(experence.superview!).offset(kScale(-15))
        }
        
        basicDataLabel.text = "基本资料"
        sexLabel.text = "性别: "
        ageLabel.text = "年龄: "
        addressLabel.text = "常住地 :"
        heightLabel.text = "身高: "
        weightLabel.text = "体重: "
        braLabel.text = "胸围: "
        waistlineLabel.text = "腰围: "
        hiplineLabel.text = "臀围："
        constellatoryLabel.text = "星座："
        
        featureLabel.text = "个人特征"
        style.text = "风格特征: "
        appearance.text = "外貌特征: "
        shape.text = "体型特征: "
        charm.text = "魅力部位: "
        experenceLabel.text = "才艺经历"
        experence.text = ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
