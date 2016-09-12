//
//  TalentDetailNomalCell.swift
//  OutLookers
//
//  Created by 宋碧海 on 16/9/12.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit


class TalentDetailNomalCell: UITableViewCell {

    var info: TalentPhotoModel! {
        didSet {
            imgView.yy_setImageWithURL(info.url.addImagePath(kSize(CGFloat(info.width), height: CGFloat(info.height))), placeholder: kPlaceholder)
        }
    }
    
    var imgView: UIImageView!
    
//    var videoBtn: UIButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubViews() {
        imgView = UIImageView()
        imgView.userInteractionEnabled = true
        imgView.clipsToBounds = true
        imgView.contentMode = .ScaleAspectFill
        contentView.addSubview(imgView)
        imgView.snp.makeConstraints { [unowned self](make) in
            make.edges.equalTo(self.contentView)
        }
        
//        videoBtn = UIButton()
//        videoBtn.setImage(UIImage(named: "play"), forState: .Normal)
//        imgView.addSubview(videoBtn)
//        videoBtn.snp.makeConstraints { [unowned self](make) in
//            make.centerX.centerY.equalTo(self.imgView)
//            make.size.equalTo(kSize(50, height: 50))
//        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
