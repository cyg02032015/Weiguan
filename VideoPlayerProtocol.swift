//
//  VideoPlayerProtocol.swift
//  OutLookers
//
//  Created by 宋碧海 on 16/9/7.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import ZFPlayer

public protocol VideoPlayerProtocol {
    func player(videoURL: NSURL, tableView: UITableView, indexPath: NSIndexPath, imageView: UIImageView, tag: Int)
}

extension VideoPlayerProtocol {
    public func player(videoURL: NSURL, tableView: UITableView, indexPath: NSIndexPath, imageView: UIImageView, tag: Int) {
        let playerView = ZFPlayerView.sharedPlayerView()
        playerView.setVideoURL(videoURL, withTableView: tableView, atIndexPath: indexPath, withImageViewTag: tag)
        playerView.addPlayerToCellImageView(imageView)
        playerView.playerLayerGravity = .ResizeAspect
        playerView.autoPlayTheVideo()
    }
}