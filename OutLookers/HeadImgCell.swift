//
//  HeadImgCell.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/14.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private extension Selector {
    static let tapImgView = #selector(HeadImgCell.tapImgView)
}

protocol HeadImgCellDelegate: class {
    func headImgTap(imgView: TouchImageView)
}

class HeadImgCell: UITableViewCell {

    weak var delegate: HeadImgCellDelegate!
    var imgView: TouchImageView!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        imgView = TouchImageView()
        imgView.image = UIImage(named: "upload")
        imgView.addTarget(self, action: .tapImgView)
        contentView.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.superview!).offset(kScale(15))
            make.centerY.equalTo(imgView.superview!)
            make.size.equalTo(kSize(82, height: 82))
        }
    }
    
    func tapImgView() {
        if delegate != nil {
            delegate.headImgTap(imgView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
