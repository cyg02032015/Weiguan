//
//  DataSectionTowCell.swift
//  OutLookers
//
//  Created by C on 16/7/7.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private extension Selector {
    static let tapOrderCount = #selector(DataSecondCell.tapOrderCount(_:))
    static let tapScore = #selector(DataSecondCell.tapScore(_:))
}

protocol DataSecondCellDelegate: class {
    func dataSecondCellTapOrderCount(sender: UIButton)
    func dataSecondCellTapScore(sender: UIButton)
}

class DataSecondCell: UITableViewCell {

    weak var delegate: DataSecondCellDelegate!
    var orderCount: UIButton!
    var score: UIButton!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        
        let orderImgView = UIImageView(image: UIImage(named: "order"))
        contentView.addSubview(orderImgView)
        orderImgView.snp.makeConstraints { (make) in
            make.top.equalTo(orderImgView.superview!).offset(kScale(20.4))
            make.left.equalTo(orderImgView.superview!).offset(kScale(67))
            make.size.equalTo(kSize(15, height: 16.2))
        }
        
        let orderLabel = UILabel()
        orderLabel.font = UIFont.customFontOfSize(14)
        orderLabel.textColor = UIColor(hex: 0x777777)
        contentView.addSubview(orderLabel)
        orderLabel.snp.makeConstraints { (make) in
            make.top.equalTo(orderLabel.superview!).offset(kScale(23))
            make.left.equalTo(orderImgView.snp.right).offset(kScale(5))
            make.height.equalTo(kScale(14))
        }
        
        orderCount = UIButton()
        orderCount.layer.borderWidth = 1
        orderCount.layer.borderColor = kCommonColor.CGColor
        orderCount.layer.cornerRadius = kScale(60/2)
        orderCount.setTitleColor(kCommonColor, forState: .Normal)
        orderCount.titleLabel?.font = UIFont.customFontOfSize(16)
        orderCount.addTarget(self, action: .tapOrderCount, forControlEvents: .TouchUpInside)
        contentView.addSubview(orderCount)
        orderCount.snp.makeConstraints { (make) in
            make.size.equalTo(kSize(60, height: 60))
            make.top.equalTo(orderLabel.snp.bottom).offset(kScale(12))
            make.left.equalTo(orderImgView)
        }
        
        
        let scoreLabel = UILabel()
        scoreLabel.font = UIFont.customFontOfSize(14)
        scoreLabel.textColor = UIColor(hex: 0x777777)
        contentView.addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(orderLabel)
            make.right.equalTo(scoreLabel.superview!).offset(kScale(-59))
            make.height.equalTo(kScale(14))
        }
        
        let scoreImgView = UIImageView(image: UIImage(named: "score"))
        contentView.addSubview(scoreImgView)
        scoreImgView.snp.makeConstraints { (make) in
            make.top.equalTo(scoreImgView.superview!).offset(kScale(20))
            make.right.equalTo(scoreLabel.snp.left).offset(kScale(-5))
            make.size.equalTo(kSize(15, height: 17.4))
        }
        
        score = UIButton()
        score.layer.borderWidth = 1
        score.layer.borderColor = kCommonColor.CGColor
        score.layer.cornerRadius = kScale(60/2)
        score.setTitleColor(kCommonColor, forState: .Normal)
        score.titleLabel?.font = UIFont.customFontOfSize(16)
        score.addTarget(self, action: .tapScore, forControlEvents: .TouchUpInside)
        contentView.addSubview(score)
        score.snp.makeConstraints { (make) in
            make.size.equalTo(kSize(60, height: 60))
            make.centerY.equalTo(orderCount)
            make.right.equalTo(score.superview!).offset(kScale(-66))
        }
        
        orderLabel.text = "订单量"
        scoreLabel.text = "综合评分"
        orderCount.setTitle("0", forState: .Normal)
        score.setTitle("0.0", forState: .Normal)

    }
    
    func tapOrderCount(sender: UIButton) {
        if delegate != nil {
            delegate.dataSecondCellTapOrderCount(sender)
        }
    }
    
    func tapScore(sender: UIButton) {
        if delegate != nil {
            delegate.dataSecondCellTapScore(sender)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
