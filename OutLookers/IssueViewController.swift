//
//  IssueViewController.swift
//  OutLookers
//
//  Created by C on 16/6/15.
//  Copyright © 2016年 youngkook. All rights reserved.
//

import UIKit

private extension Selector {
    static let tapCanceled = #selector(IssueViewController.tapCancel(_:))
    static let tapCircled = #selector(IssueViewController.tapCircle(_:))
}

private let offsetScale = 1.0/2.0
private let circleSize = CGSize(width: 100, height: 100)

public enum BtnType: NSInteger {
    case Video = 1, Picture, Skill, Notice
}

class IssueViewController: YGBaseViewController {

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }

    func setupSubViews() {
        let blurImgView = UIImageView()
        blurImgView.image = boxBlurImage(UIImage(named: "video1")!, withBlurNumber: 0.3)
        view.addSubview(blurImgView)
        blurImgView.snp.makeConstraints { (make) in
            make.edges.equalTo(blurImgView.superview!)
        }
        
        let tapView = UITapGestureRecognizer(target: self, action: .tapCanceled)
        view.addGestureRecognizer(tapView)

        let talent = CircelView(frame: CGRectZero, imgName: "caiyi", title: "才艺")
        talent.tag = BtnType.Skill.rawValue
        view.addSubview(talent)
        let tapTalent = UITapGestureRecognizer(target: self, action: .tapCircled)
        talent.addGestureRecognizer(tapTalent)
        
        talent.snp.makeConstraints { (make) in
            make.bottom.equalTo(talent.superview!).offset(kScale(-90))
            make.centerX.equalTo(talent.superview!).offset(kScale(-70))
            make.size.equalTo(kSize(72, height: 96))
        }
        
        let circular = CircelView(frame: CGRectZero, imgName: "tonggao", title: "通告")
        circular.tag = BtnType.Notice.rawValue
        view.addSubview(circular)
        let tapCircular = UITapGestureRecognizer(target: self, action: .tapCircled)
        circular.addGestureRecognizer(tapCircular)
        circular.snp.makeConstraints { (make) in
            make.centerY.equalTo(talent)
            make.centerX.equalTo(circular.superview!).offset(kScale(70))
            make.size.equalTo(talent)
        }
        
        let video = CircelView(frame: CGRectZero, imgName: "video", title: "视频")
        video.tag = BtnType.Video.rawValue
        view.addSubview(video)
        let tapVideo = UITapGestureRecognizer(target: self, action: .tapCircled)
        video.addGestureRecognizer(tapVideo)
        video.snp.makeConstraints { (make) in
            make.centerX.equalTo(talent)
            make.size.equalTo(talent)
            make.bottom.equalTo(talent.snp.top).offset(kScale(-30))
        }
        
        let picture = CircelView(frame: CGRectZero, imgName: "pic", title: "图片")
        picture.tag = BtnType.Picture.rawValue
        view.addSubview(picture)
        let tapPicture = UITapGestureRecognizer(target: self, action: .tapCircled)
        picture.addGestureRecognizer(tapPicture)
        picture.snp.makeConstraints { (make) in
            make.centerX.equalTo(circular)
            make.centerY.equalTo(video)
            make.size.equalTo(talent)
        }
        
        let cancel = UIButton()
        cancel.setImage(UIImage(named: "Combined Shape"), forState: .Normal)
        cancel.addTarget(self, action: .tapCanceled, forControlEvents: .TouchUpInside)
        view.addSubview(cancel)
        cancel.snp.makeConstraints { (make) in
            make.centerX.equalTo(cancel.superview!)
            make.bottom.equalTo(cancel.superview!).offset(kScale(-8))
            make.size.equalTo(kSize(44, height: 44))
        }
        
    }
}

// MARK: -按钮点击
extension IssueViewController {
    
    func tapCancel(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tapCircle(sender: UITapGestureRecognizer) {
        switch sender.view!.tag {
        case BtnType.Video.rawValue:
            let video = ReleaseVideoViewController()
            navigationController?.pushViewController(video, animated: true)
        case BtnType.Picture.rawValue:
            let picture = ReleasePictureViewController()
            navigationController?.pushViewController(picture, animated: true)
        case BtnType.Skill.rawValue:
            let skill = SelectSkillViewController()
            skill.type = SelectSkillType.Tovc
            navigationController?.pushViewController(skill, animated: true)
        case BtnType.Notice.rawValue:
            let notice = ReleaseNoticeViewController()
            navigationController?.pushViewController(notice, animated: true)
        default:
            fatalError("not tag with button type")
        }
    }
}