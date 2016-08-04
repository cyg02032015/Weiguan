//
//  FansAuthCell.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/20.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class FansAuthCell: UICollectionViewCell {
    
    var info: FollowList! {
        didSet {
            imgView.yy_setImageWithURL(info.photo.addImagePath(kSize(72, height: 72)), placeholder: kPlaceholder)
            name.text = info.name
            setVimage(Util.userType(info.detailsType))
        }
    }
    
    var imgView: UIImageView!
    var selectButton: UIButton!
    var name: UILabel!
    var vImgView: UIImageView!
    private var _isSelect: Bool = false
    var isSelect: Bool! {
        set {
            _isSelect = newValue
            selectButton.selected = newValue
        }
        get {
            return _isSelect
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    
    func setupSubViews() {
        imgView = UIImageView()
        imgView.layer.cornerRadius = kScale(72/2)
        imgView.clipsToBounds = true
        contentView.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.size.equalTo(kSize(72, height: 72))
            make.centerX.equalTo(imgView.superview!)
            make.top.equalTo(imgView.superview!)
        }
        
        name = UILabel.createLabel(14, textColor: UIColor(hex: 0x666666))
        name.textAlignment = .Center
        contentView.addSubview(name)
        name.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(name.superview!)
            make.height.equalTo(kScale(14))
        }
        
        selectButton = UIButton()
        selectButton.setImage(UIImage(named: "chosen"), forState: .Normal)
        selectButton.setImage(UIImage(named: "normal copy 3"), forState: .Selected)
        selectButton.userInteractionEnabled = false
        contentView.addSubview(selectButton)
        selectButton.snp.makeConstraints { (make) in
            make.size.equalTo(kSize(24, height: 24))
            make.right.equalTo(imgView)
            make.top.equalTo(imgView)
        }
        
        vImgView = UIImageView()
        contentView.addSubview(vImgView)
        vImgView.snp.makeConstraints { (make) in
            make.size.equalTo(kSize(24, height: 24))
            make.right.equalTo(imgView)
            make.bottom.equalTo(imgView)
        }
    }
    
    func setVimage(type: UserType) {
        switch type {
        case .HotMan: vImgView.image = UIImage(named: "Red")
        case .Organization: vImgView.image = UIImage(named: "blue")
        case .Fans: vImgView.image = UIImage(named: "Green")
        default: ""
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
