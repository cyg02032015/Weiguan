//
//  PHHeaderView.swift
//  OutLookers
//
//  Created by C on 16/7/4.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class PHHeaderView: UIView {

    var personalData: IsAuthData! {
        didSet {
            headImgView.yy_setImageWithURL(personalData.headImgUrl.addImagePath(CGSize(width: kScale(80), height: kScale(80))), placeholder: kHeadPlaceholder)
            secondLabel.text = personalData.introduction
            switch personalData.type {
                case 1:
                    firstLabel.text = "纯氧认证：" + personalData.name
                    vImageView.image = UIImage(named: "Red")
                case 2:
                    firstLabel.text = "纯氧认证：" + personalData.name + " 官方机构"
                    vImageView.image = UIImage(named: "blue")
                case 3:
                    firstLabel.text = "纯氧认证：" + personalData.name
                    vImageView.image = UIImage(named: "Green")
                default:
                    break
            }
        }
    }
    
    var countObj: GetContent! {
        didSet {
            follow.text = "\(countObj.follow)"
            fans.text = "\(countObj.fan)"
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
        headImgView.clipsToBounds = true
        headImgView.image = kHeadPlaceholder
        backImgView.addSubview(headImgView)
        _ = headImgView.rx_observe(UIImage.self, "image").subscribeNext { [weak self](image) in
            self?.backImgView.image = image?.boxblurImageWithBlur(0.3)
        }
        headImgView.snp.makeConstraints { [unowned self](make) in
            make.top.equalTo(self.headImgView.superview!).offset(kScale(101))
            make.centerX.equalTo(self.headImgView.superview!)
            make.size.equalTo(kSize(80, height: 80))
        }
        
        //给头像加透明度为0.5的白色边框
        let shapeLayer = CAShapeLayer()
        let path = UIBezierPath()
        path.addArcWithCenter(CGPointMake(ScreenWidth / 2, kScale(141)), radius: kScale(41), startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true)
        shapeLayer.path = path.CGPath
        shapeLayer.lineWidth = 2
        shapeLayer.opacity = 0.5
        shapeLayer.strokeColor = UIColor.whiteColor().CGColor
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.strokeEnd = 1.0
        backImgView.layer.addSublayer(shapeLayer)
        
        let lineV = UIView()
        lineV.backgroundColor = UIColor.whiteColor()
        backImgView.addSubview(lineV)
        lineV.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 1/UIScreen.mainScreen().scale, height: 15))
            make.top.equalTo(headImgView.snp.bottom).offset(kScale(13))
            make.centerX.equalTo(lineV.superview!)
        }
        
        let followL = UILabel()
        followL.textColor = UIColor.whiteColor()
        followL.text = "关注"
        followL.font = UIFont.systemFontOfSize(kScale(16))
        backImgView.addSubview(followL)
        followL.snp.makeConstraints { (make) in
            make.centerY.equalTo(lineV)
            make.right.equalTo(lineV.snp.left).offset(kScale(-18))
            make.height.equalTo(kHeight(16))
        }
        
        follow = TouchLabel()
        follow.font = UIFont.customNumFontOfSize(16)
        follow.textColor = UIColor.whiteColor()
        follow.textAlignment = .Right
        backImgView.addSubview(follow)
        follow.snp.makeConstraints { (make) in
            make.centerY.equalTo(followL)
            make.right.equalTo(followL.snp.left).offset(kScale(-8))
            make.height.equalTo(kHeight(16))
        }
        
        fans = TouchLabel()
        fans.font = UIFont.customNumFontOfSize(16)
        fans.textColor = UIColor.whiteColor()
        backImgView.addSubview(fans)
        fans.snp.makeConstraints { (make) in
            make.centerY.equalTo(lineV)
            make.left.equalTo(lineV.snp.right).offset(kScale(18))
            make.height.equalTo(kHeight(16))
        }
        
        
        let fansL = UILabel()
        fansL.textColor = UIColor.whiteColor()
        fansL.text = "粉丝"
        fansL.font = UIFont.systemFontOfSize(kScale(16))
        backImgView.addSubview(fansL)
        fansL.snp.makeConstraints { [unowned self](make) in
            make.centerY.equalTo(self.fans)
            make.left.equalTo(self.fans.snp.right).offset(kScale(8))
            make.height.equalTo(kHeight(16))
        }
        
        firstLabel = UILabel()
        firstLabel.font = UIFont.customFontOfSize(14)
        firstLabel.textColor = UIColor.whiteColor()
        firstLabel.textAlignment = .Center
        firstLabel.numberOfLines = 2
        backImgView.addSubview(firstLabel)
        firstLabel.snp.makeConstraints { [unowned self](make) in
            make.top.equalTo(lineV.snp.bottom).offset(kScale(11))
            make.centerX.equalTo(self.firstLabel.superview!)
            make.left.equalTo(self.firstLabel.superview!).offset(kScale(60))
            make.height.equalTo(kHeight(16))
        }
        
        secondLabel = UILabel()
        secondLabel.font = UIFont.customFontOfSize(14)
        secondLabel.textColor = UIColor.whiteColor()
        secondLabel.textAlignment = .Center
        secondLabel.numberOfLines = 2
        backImgView.addSubview(secondLabel)
        secondLabel.snp.makeConstraints { [unowned self](make) in
            make.top.equalTo(self.firstLabel.snp.bottom).offset(kScale(11))
            make.left.equalTo(self.secondLabel.superview!).offset(kScale(60))
            make.right.equalTo(self.secondLabel.superview!).offset(kScale(-60))
        }
        
        vImageView = UIImageView()
        addSubview(vImageView)
        vImageView.snp.makeConstraints { [unowned self](make) in
            make.right.equalTo(self.headImgView).offset(-5)
            make.bottom.equalTo(self.headImgView)
            make.size.equalTo(kSize(20, height: 20))
        }
        follow.text = "--"
        fans.text = "--"
        firstLabel.text = "纯氧认证："
        secondLabel.text = ""

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

