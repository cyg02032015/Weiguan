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
    
    weak var talent: CircelView!
    weak var circular: CircelView!
    weak var video: CircelView!
    weak var picture: CircelView!
    lazy var items = [CircelView]()
    var itemSize = CGSize(width: kScale(72), height: 96)

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        animation()
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
        talent.frame = CGRect(x: self.view.gg_width / 3.0 - itemSize.width / 2.0, y: self.view.gg_height - 90 - itemSize.height, width: itemSize.width, height: itemSize.height)
        self.talent = talent
        
        let circular = CircelView(frame: CGRectZero, imgName: "tonggao", title: "通告")
        circular.tag = BtnType.Notice.rawValue
        view.addSubview(circular)
        let tapCircular = UITapGestureRecognizer(target: self, action: .tapCircled)
        circular.addGestureRecognizer(tapCircular)
        circular.frame = CGRect(x: self.view.gg_width - self.view.gg_width / 3.0 - itemSize.width / 2.0, y: talent.gg_y, width: itemSize.width, height: itemSize.height)
        self.circular = circular
        
        let video = CircelView(frame: CGRectZero, imgName: "video", title: "视频")
        video.tag = BtnType.Video.rawValue
        view.addSubview(video)
        let tapVideo = UITapGestureRecognizer(target: self, action: .tapCircled)
        video.addGestureRecognizer(tapVideo)
        video.frame = CGRect(x: talent.gg_x, y: talent.gg_y - 35 - itemSize.height, width: itemSize.width, height: itemSize.height)
        self.video = video
        
        let picture = CircelView(frame: CGRectZero, imgName: "pic", title: "图片")
        picture.tag = BtnType.Picture.rawValue
        view.addSubview(picture)
        let tapPicture = UITapGestureRecognizer(target: self, action: .tapCircled)
        picture.addGestureRecognizer(tapPicture)
        picture.frame = CGRect(x: circular.gg_x, y: video.gg_y, width: itemSize.width, height: itemSize.height)
        self.picture = picture
        
        self.items.append(self.video)
        self.items.append(self.picture)
        self.items.append(self.talent)
        self.items.append(self.circular)
        
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
    
    func animation() {
        for (idx, item) in self.items.enumerate() {
            let x = item.gg_x
            let y = item.gg_y
            let w = item.gg_width
            let h = item.gg_height
            item.frame = CGRect(x: x, y: ScreenHeight + y - self.view.gg_y, width: w, height: h)
            item.alpha = 0
            delay(NSTimeInterval(idx) * 0.03, task: {
                UIView.animateWithDuration(0.7, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 10, options: .CurveEaseIn, animations: {
                    item.frame = CGRect(x: x, y: y, width: w, height: h)
                    item.alpha = 1
                    }, completion: { (completed) in
                      // 让按钮可用户点击
                })
            })
        }
    }
    
    func removeAnimation() {
        for (idx, item) in self.items.enumerate() {
            let x = item.gg_x
            let y = item.gg_y
            let w = item.gg_width
            let h = item.gg_height
            delay(NSTimeInterval(self.items.count - idx) * 0.03, task: { 
                UIView.animateWithDuration(0.7, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 10, options: .TransitionNone, animations: {
                    item.alpha = 0
                    item.frame = CGRect(x: x, y: self.view.gg_height - self.view.gg_y + y, width: w, height: h)
                    }, completion: { (completed) in
                })
            })
        }
    }
}




// MARK: -按钮点击
extension IssueViewController {
    
    func tapCancel(sender: UIButton) {
        removeAnimation()
        delay(0.3) {
            self.dismissViewControllerAnimated(false, completion: nil)
        }
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