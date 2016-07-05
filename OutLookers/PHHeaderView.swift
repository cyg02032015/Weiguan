//
//  PHHeaderView.swift
//  OutLookers
//
//  Created by C on 16/7/4.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class PHHeaderView: UIView {

    var backImgView: UIImageView!
    var headImgView: UIImageView!
    var vImageView: UIImageView!
    var follow: UILabel!
    var followLabel: UILabel!
    var fans: UILabel!
    var fansLabel: UILabel!
    var firstLabel: UILabel!
    var secondLabel: UILabel!
//    var thirdLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    func setupSubViews() {
        backImgView = UIImageView()
        addSubview(backImgView)
        backImgView.snp.makeConstraints { (make) in
            make.edges.equalTo(backImgView.superview!)
        }
        
        headImgView = UIImageView()
        headImgView.layer.cornerRadius = kScale(80/2)
        headImgView.layer.borderWidth = 2
        headImgView.layer.borderColor = UIColor.lightGrayColor().CGColor
        headImgView.clipsToBounds = true
        backImgView.addSubview(headImgView)
        headImgView.snp.makeConstraints { (make) in
            make.top.equalTo(headImgView.superview!).offset(kScale(37))
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
        
        followLabel = UILabel()
        followLabel.font = UIFont.customFontOfSize(14)
        followLabel.textColor = UIColor.whiteColor()
        backImgView.addSubview(followLabel)
        followLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(lineV)
            make.right.equalTo(lineV.snp.left).offset(kScale(-18))
            make.height.equalTo(kHeight(14))
        }
        
        follow = UILabel()
        follow.font = UIFont.customNumFontOfSize(16)
        follow.textColor = UIColor.whiteColor()
        backImgView.addSubview(follow)
        follow.snp.makeConstraints { (make) in
            make.centerY.equalTo(followLabel)
            make.right.equalTo(followLabel.snp.left).offset(kScale(-5))
            make.height.equalTo(kHeight(16))
        }
        
        fans = UILabel()
        fans.font = UIFont.customNumFontOfSize(16)
        fans.textColor = UIColor.whiteColor()
        backImgView.addSubview(fans)
        fans.snp.makeConstraints { (make) in
            make.centerY.equalTo(lineV)
            make.left.equalTo(lineV.snp.right).offset(kScale(20))
            make.height.equalTo(kHeight(16))
        }
        
        fansLabel = UILabel()
        fansLabel.font = UIFont.customFontOfSize(14)
        fansLabel.textColor = UIColor.whiteColor()
        backImgView.addSubview(fansLabel)
        fansLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(fans)
            make.left.equalTo(fans.snp.right).offset(kScale(5))
            make.height.equalTo(kHeight(14))
        }
        
        firstLabel = UILabel()
        firstLabel.font = UIFont.customFontOfSize(12)
        firstLabel.textColor = UIColor.whiteColor()
        firstLabel.textAlignment = .Center
        backImgView.addSubview(firstLabel)
        firstLabel.snp.makeConstraints { (make) in
            make.top.equalTo(lineV.snp.bottom).offset(kScale(11))
            make.centerX.equalTo(firstLabel.superview!)
            make.height.equalTo(kHeight(12))
        }
        
        vImageView = UIImageView()
        backImgView.addSubview(vImageView)
        vImageView.snp.makeConstraints { (make) in
            make.size.equalTo(kSize(20, height: 18))
            make.right.equalTo(firstLabel.snp.left).offset(kScale(-5))
            make.centerY.equalTo(firstLabel)
        }
        
        secondLabel = UILabel()
        secondLabel.font = UIFont.customFontOfSize(12)
        secondLabel.textColor = UIColor.whiteColor()
        secondLabel.textAlignment = .Center
        secondLabel.numberOfLines = 2
        backImgView.addSubview(secondLabel)
        secondLabel.snp.makeConstraints { (make) in
            make.top.equalTo(firstLabel.snp.bottom).offset(kScale(10))
            make.left.equalTo(secondLabel.superview!).offset(kScale(60))
            make.right.equalTo(secondLabel.superview!).offset(kScale(-60))
            make.height.equalTo(kHeight(35))
        }
        
        backImgView.image = boxBlurImage(UIImage(named: "back.png")!, withBlurNumber: 0.5)
        headImgView.image = UIImage(named: "back.png")
        follow.text = "155"
        followLabel.text = "关注"
        fans.text = "234"
        fansLabel.text = "粉丝"
        firstLabel.text = "围观认证：男人装御用模特"
        vImageView.backgroundColor = UIColor.yellowColor()
        secondLabel.text = "欧美 日韩 街头 性感 中国风 欧美 日韩 街头 性感 中国风日韩 街头 性感 中国风"
        
//        thirdLabel = UILabel()
//        thirdLabel.font = UIFont.customFontOfSize(14)
//        thirdLabel.textColor = UIColor.whiteColor()
//        backImgView.addSubview(thirdLabel)
//        thirdLabel.snp.makeConstraints { (make) in
//            
//        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
