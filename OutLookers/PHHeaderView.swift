//
//  PHHeaderView.swift
//  OutLookers
//
//  Created by C on 16/7/4.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private extension Selector {
    static let tapFans = #selector(PHHeaderView.fansLabelClick)
    static let tapFollow = #selector(PHHeaderView.followLabelClick)
}

class PHHeaderView: UIView {

    var personalData: IsAuthData! {
        didSet {
            headImgView.yy_setImageWithURL(personalData.headImgUrl.addImagePath(CGSize(width: kScale(80), height: kScale(80))), placeholder: kHeadPlaceholder)
            secondLabel.text = personalData.introduction
            switch personalData.type {
                case 1:
                    firstLabel.text = "纯氧认证：" + personalData.name
                    vImageView.image = UIImage.init(named: "red")
                case 2:
                    firstLabel.text = "纯氧认证：" + personalData.name + " 官方机构"
                    vImageView.image = UIImage.init(named: "blue")
                case 3:
                    firstLabel.text = "纯氧认证：" + personalData.name
                    vImageView.image = UIImage.init(named: "Green")
                default:
                    break
            }
        }
    }
    
    var countObj: GetContent! {
        didSet {
            follow.text = "\(countObj.follow) 关注"
            fans.text = "\(countObj.fan) 粉丝"
        }
    }
    var backImgView: UIImageView!
    var headImgView: UIImageView!
    var follow: TouchLabel!
    var fans: TouchLabel!
    var firstLabel: UILabel!
    var secondLabel: UILabel!
    var vImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    func setupSubViews() {
        backImgView = UIImageView()
        backImgView.userInteractionEnabled = true
        addSubview(backImgView)
        backImgView.snp.makeConstraints { (make) in
            make.edges.equalTo(backImgView.superview!)
        }
//        let blurEffect = UIBlurEffect.init(style: .ExtraLight)
//        let effectView = UIVisualEffectView.init(effect: blurEffect)
//        effectView.alpha = 0.8
//        backImgView.addSubview(effectView)
//        effectView.snp.makeConstraints { (make) in
//            make.edges.equalTo(effectView.superview!)
//        }
        headImgView = UIImageView()
        headImgView.layer.cornerRadius = kScale(80/2)
        headImgView.layer.borderWidth = 2
        headImgView.layer.borderColor = UIColor.lightGrayColor().CGColor
        headImgView.clipsToBounds = true
        headImgView.image = kHeadPlaceholder
        backImgView.addSubview(headImgView)
        _ = headImgView.rx_observe(UIImage.self, "image").subscribeNext { [weak self](image) in
            self?.backImgView.image = image?.boxblurImageWithBlur(0.3)
        }
        headImgView.snp.makeConstraints { (make) in
            make.top.equalTo(headImgView.superview!).offset(kScale(101))
            make.centerX.equalTo(headImgView.superview!)
            make.size.equalTo(kSize(80, height: 80))
        }
        
        let lineV = UIView()
        lineV.backgroundColor = UIColor.whiteColor()
        backImgView.addSubview(lineV)
        lineV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 2, height: 15))
            make.top.equalTo(headImgView.snp.bottom).offset(kScale(13))
            make.centerX.equalTo(lineV.superview!)
        }
        
        follow = TouchLabel()
        follow.font = UIFont.customNumFontOfSize(16)
        follow.textColor = UIColor.whiteColor()
        follow.textAlignment = .Right
        follow.addTarget(self, action: .tapFollow)
        backImgView.addSubview(follow)
        follow.snp.makeConstraints { (make) in
            make.centerY.equalTo(lineV)
            make.right.equalTo(lineV.snp.left).offset(kScale(-18))
            make.height.equalTo(kHeight(16))
        }
        
        fans = TouchLabel()
        fans.font = UIFont.customNumFontOfSize(16)
        fans.textColor = UIColor.whiteColor()
        fans.addTarget(self, action: .tapFans)
        backImgView.addSubview(fans)
        fans.snp.makeConstraints { (make) in
            make.centerY.equalTo(lineV)
            make.left.equalTo(lineV.snp.right).offset(kScale(20))
            make.height.equalTo(kHeight(16))
        }
        
        firstLabel = UILabel()
        firstLabel.font = UIFont.customFontOfSize(14)
        firstLabel.textColor = UIColor.whiteColor()
        firstLabel.textAlignment = .Center
        firstLabel.numberOfLines = 2
        backImgView.addSubview(firstLabel)
        firstLabel.snp.makeConstraints { (make) in
            make.top.equalTo(lineV.snp.bottom).offset(kScale(11))
            make.centerX.equalTo(firstLabel.superview!)
            make.left.equalTo(firstLabel.superview!).offset(kScale(60))
            make.height.equalTo(kHeight(16))
        }
        
        secondLabel = UILabel()
        secondLabel.font = UIFont.customFontOfSize(14)
        secondLabel.textColor = UIColor.whiteColor()
        secondLabel.textAlignment = .Center
        secondLabel.numberOfLines = 2
        backImgView.addSubview(secondLabel)
        secondLabel.snp.makeConstraints { (make) in
            make.top.equalTo(firstLabel.snp.bottom).offset(kScale(6))
            make.left.equalTo(secondLabel.superview!).offset(kScale(60))
            make.right.equalTo(secondLabel.superview!).offset(kScale(-60))
            make.height.equalTo(kHeight(35))
        }
        
        //backImgView.image = boxBlurImage(UIImage(named: "back.png")!, withBlurNumber: 0.5)
        vImageView = UIImageView()
        vImageView.backgroundColor = UIColor.clearColor()
        addSubview(vImageView)
        vImageView.snp.makeConstraints { (make) in
            make.bottom.right.equalTo(headImgView).offset(-2)
            make.size.equalTo(kSize(18, height: 18))
        }
        follow.text = "-- 关注"
        fans.text = "-- 粉丝"
        firstLabel.text = "纯氧认证："
        secondLabel.text = ""

    }
    
    func followLabelClick() {
        LogWarn("follow")
    }
    
    func fansLabelClick() {
        LogWarn("fans")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

