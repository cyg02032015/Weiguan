//
//  PraiseListCollectionViewCell.swift
//  OutLookers
//
//  Created by C on 16/8/28.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class PraiseListCollectionViewCell: UICollectionViewCell {
    
    var info: LikeList! {
        didSet {
            header.iconURL = info.headImgUrl.addImagePath(kSize(24, height: 24))
            header.setVimage(Util.userType(info.detailsType))
            label.hidden = true
        }
    }

    weak var label: UILabel!
    var header: IconHeaderView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    func setupSubViews() {
        header = IconHeaderView()
        header.customCornerRadius = kScale(24/2)
        header.vImgSize = kSize(9, height: 8)
        contentView.addSubview(header)
        header.snp.makeConstraints { (make) in
            make.edges.equalTo(header.superview!)
        }
        
        let label = UILabel.createLabel(12, textColor: UIColor(hex: 0x999999))
        label.layer.cornerRadius = kScale(24/2)
        label.clipsToBounds = true
        label.backgroundColor = UIColor(hex: 0xe9e9e9)
        label.textAlignment = .Center
        contentView.addSubview(label)
        label.hidden = true
        self.label = label
        label.snp.makeConstraints { (make) in
            make.edges.equalTo(label.superview!)
        }
    }
    
    func showCountlabel(isShow: Bool, count: String) {
        if isShow {
            label.hidden = false
            label.text = count
        } else {
            label.hidden = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
