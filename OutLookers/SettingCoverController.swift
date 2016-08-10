//
//  SettingCoverControlle.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/13.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import AVFoundation

private extension Selector {
    static let tapSure = #selector(SettingCoverController.tapSure(_:))
}

protocol SettingCoverControllerDelegate: class {
    func settingCoverSendCover(image: UIImage)
}

class SettingCoverController: YGBaseViewController {

    weak var delegate: SettingCoverControllerDelegate!
    var videoUrl: NSURL!
    
    var videoContainer: UIView!
    var player: AVPlayer!
    var playerItem: AVPlayerItem!
    var playerLayer: AVPlayerLayer!
    var asset: AVAsset!
    var trimmerView: YKVideoTrimmer!
    var changePoint: CMTime = kCMTimeZero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()

    }
    
    func setupSubViews() {
        title = "设置封面"
        videoContainer = UIView()
        videoContainer.backgroundColor = UIColor.blackColor()
        view.addSubview(videoContainer)
        videoContainer.snp.makeConstraints { (make) in
            make.left.right.equalTo(videoContainer.superview!)
            make.top.equalTo(videoContainer.superview!).offset(kScale(15))
            make.height.equalTo(ScreenWidth)
        }
        
        asset = AVAsset(URL: videoUrl)
        let item = AVPlayerItem(asset: asset)
        player = AVPlayer(playerItem: item)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.contentsGravity = AVLayerVideoGravityResizeAspect
        player.actionAtItemEnd = .None
        videoContainer.layer.addSublayer(playerLayer)
        
        let label = UILabel.createLabel(14, textColor: UIColor(hex: 0x666666))
        label.text = "滑动可选择一张封面"
        label.textAlignment = .Center
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.right.equalTo(label.superview!)
            make.top.equalTo(videoContainer.snp.bottom).offset(kScale(20))
            make.height.equalTo(kScale(14))
        }
        
        view.layoutIfNeeded()
        
        trimmerView = YKVideoTrimmer(frame: CGRect(x: 0, y: label.gg_bottom + kScale(14), width: ScreenWidth, height: kScale(37)), asset: asset)
        trimmerView.delegate = self
        view.addSubview(trimmerView)
        
        let sureButton = Util.createReleaseButton("确定")
        sureButton.backgroundColor = kCommonColor
        sureButton.addTarget(self, action: .tapSure, forControlEvents: .TouchUpInside)
        view.addSubview(sureButton)
        sureButton.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(sureButton.superview!)
            make.height.equalTo(kScale(50))
        }
    }
    
    func tapSure(sender: UIButton) {
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        var halfWayImage: CGImageRef?
        do {
            let seconds = CMTimeGetSeconds(changePoint)
            let time = CMTimeMakeWithSeconds(seconds, 60)
            halfWayImage = try generator.copyCGImageAtTime(time, actualTime: nil)
        } catch let e {
            LogError("\(e)")
            halfWayImage = nil
        }
        guard let halfImage = halfWayImage else {
            LogError("halfWayImage is nil")
            return
        }
        if delegate != nil {
            delegate.settingCoverSendCover(UIImage(CGImage: halfImage))
        }
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLayoutSubviews() {
        if playerLayer != nil {
            playerLayer.frame = CGRect(x: 0, y: 0, width: videoContainer.gg_width, height: videoContainer.gg_height)
        }
    }
}

extension SettingCoverController: YKVideoTrimmerDelegate {
    func trimmerTime(view: UIView, didChangePoint: CMTime) {
        changePoint = didChangePoint
        self.player.seekToTime(didChangePoint, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
    }
}
