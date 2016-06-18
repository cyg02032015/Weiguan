//
//  IssueViewController.swift
//  OutLookers
//
//  Created by C on 16/6/15.
//  Copyright © 2016年 youngkook. All rights reserved.
//

import UIKit

private extension Selector {
    static let tapCancel = #selector(IssueViewController.tapCancel(_:))
    static let tapCircle = #selector(IssueViewController.tapCircle(_:))
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
        /*
         视频
         图片
         才艺
         通告
         */
        let container = UIView()
        container.backgroundColor = UIColor.yellowColor()
        view.addSubview(container)
        
        let video = getCircelButton("视频")
        video.tag = BtnType.Video.rawValue
        container.addSubview(video)
        
        let picture = getCircelButton("图片")
        picture.tag = BtnType.Picture.rawValue
        container.addSubview(picture)
        
        let skill = getCircelButton("才艺")
        skill.tag = BtnType.Skill.rawValue
        container.addSubview(skill)
        
        let notice = getCircelButton("通告")
        notice.tag = BtnType.Notice.rawValue
        container.addSubview(notice)
        
        let cancel = UIButton()
        cancel.addTarget(self, action: .tapCancel, forControlEvents: .TouchUpInside)
        cancel.backgroundColor = UIColor.redColor()
        view.addSubview(cancel)
        
        container.snp.makeConstraints { (make) in
            make.left.right.equalTo(container.superview!)
            make.centerY.equalTo(container.superview!)
            make.height.equalTo(ScreenWidth)
        }
        
        video.snp.makeConstraints { (make) in
            make.centerX.equalTo(video.superview!).multipliedBy(offsetScale)
            make.size.equalTo(circleSize)
            make.centerY.equalTo(video.superview!).multipliedBy(offsetScale)
        }
        
        picture.snp.makeConstraints { (make) in
            make.centerX.equalTo(picture.superview!).offset(ScreenWidth/4)
            make.size.equalTo(video)
            make.centerY.equalTo(picture.superview!).multipliedBy(offsetScale)
        }
        
        skill.snp.makeConstraints { (make) in
            make.centerX.equalTo(skill.superview!).multipliedBy(offsetScale)
            make.size.equalTo(video)
            make.centerY.equalTo(skill.superview!).offset(ScreenWidth/4)
        }
        
        notice.snp.makeConstraints { (make) in
            make.centerX.equalTo(notice.superview!).offset(ScreenWidth/4)
            make.size.equalTo(video)
            make.centerY.equalTo(notice.superview!).offset(ScreenWidth/4)
        }
        
        cancel.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.bottom.equalTo(cancel.superview!).offset(-40)
            make.centerX.equalTo(cancel.superview!)
        }
    }
    
    func getCircelButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, forState: .Normal)
        button.backgroundColor = UIColor.brownColor()
        button.layer.cornerRadius = circleSize.width / 2
        button.addTarget(self, action: .tapCircle, forControlEvents: .TouchUpInside)
        return button
    }
}

// MARK: -按钮点击
extension IssueViewController {
    
    func tapCancel(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tapCircle(sender: UIButton) {
        switch sender.tag {
        case BtnType.Video.rawValue:
            debugPrint("视频")
        case BtnType.Picture.rawValue:
            debugPrint("图片")
        case BtnType.Skill.rawValue:
            debugPrint("才艺")
        case BtnType.Notice.rawValue:
            let notice = ReleaseNoticeViewController()
            navigationController?.pushViewController(notice, animated: true)
        default:
            fatalError("not tag with button type")
        }
    }
}