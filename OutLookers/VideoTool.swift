
//
//  VideoTool.swift
//  OutLookers
//
//  Created by C on 16/6/25.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import AVFoundation

class VideoTool {
    
    /**
     获取视频第一帧视频缩略图
     
     - parameter url: 视频url路径
     
     - returns: 视频缩略图
     */
    class func getThumbleImage(url: NSURL) -> UIImage {
        // 获取视频缩略图
        let avAsset = AVAsset(URL: url)
        let generator = AVAssetImageGenerator(asset: avAsset)
        generator.appliesPreferredTrackTransform = true
        let time = CMTimeMakeWithSeconds(0.0, 600)
        var actualTime: CMTime = CMTimeMake(0, 0)
        var imageRef: CGImageRef?
        do {
            imageRef = try generator.copyCGImageAtTime(time, actualTime: &actualTime)
        } catch let e {
            debugPrint("获取视频缩略图跑出异常 \(e)")
        }
        let thumbleImage = UIImage(CGImage: imageRef!)
        return thumbleImage
    }
}
