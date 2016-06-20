//
//  SelectPhotoCell.swift
//  OutLookers
//
//  Created by C on 16/6/19.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private extension Selector {
    static let tapSelectImg = #selector(SelectPhotoCell.tapSelectImg(_:))
}

protocol SelectPhotoCellDelegate: class {
    func selectPhoto(sender: UIButton)
}

class SelectPhotoCell: UITableViewCell {

    var selectImgButton: UIButton!
    weak var delegate: SelectPhotoCellDelegate!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    func setupSubViews() {
        let label = UILabel()
        label.text = "工作详情"
        label.font = UIFont.systemFontOfSize(15)
        contentView.addSubview(label)
        
        selectImgButton = UIButton()
        selectImgButton.setImage(UIImage(named: "release_announcement_Addpictures"), forState: .Normal)
        selectImgButton.addTarget(self, action: .tapSelectImg, forControlEvents: .TouchUpInside)
        contentView.addSubview(selectImgButton)
        
        label.snp.makeConstraints { (make) in
            make.left.equalTo(label.superview!).offset(15)
            make.top.equalTo(label.superview!).offset(15)
            make.height.equalTo(15)
        }
        
        selectImgButton.snp.makeConstraints { (make) in
            make.left.equalTo(label)
            make.top.equalTo(label.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: 112, height: 63))
        }
    }
    
    func tapSelectImg(sender: UIButton) {
        delegate.selectPhoto(sender)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
