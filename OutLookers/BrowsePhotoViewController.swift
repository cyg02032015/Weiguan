//
//  BrowsePhotoViewController.swift
//  OutLookers
//
//  Created by C on 16/6/16.
//  Copyright © 2016年 youngkook. All rights reserved.
//

import UIKit

private extension Selector {
    static let singleTapGesture = #selector(BrowsePhotoViewController.singleTapGesture(_:))
    static let doubleTapGesture = #selector(BrowsePhotoViewController.doubleTapGesture(_:))
}

class BrowsePhotoViewController: YGBaseViewController {
    
    var imageContainer: UIView!
    var imageView: UIImageView!
    var scrollView: UIScrollView!
    var photos: [UIImage]! {
        didSet {
            scrollView.setZoomScale(1.0, animated: false)
            for p in oldValue {
                imageView.image = p
                resizeSubViews(oldValue)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }
    
    func setupSubViews() {
        scrollView = UIScrollView()
        scrollView.bouncesZoom = true
        scrollView.maximumZoomScale = 2.5
        scrollView.minimumZoomScale = 1.0
        scrollView.multipleTouchEnabled = true
        scrollView.scrollsToTop = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delaysContentTouches = false
        scrollView.canCancelContentTouches = false
        scrollView.alwaysBounceVertical = false
        scrollView.delegate = self;
        view.addSubview(scrollView)
        
        imageContainer = UIView()
        imageContainer.clipsToBounds = true
        scrollView.addSubview(imageContainer)
        
        imageView = UIImageView()
        imageView.clipsToBounds = true
        imageContainer.addSubview(imageView)
        
        let singleTap = UITapGestureRecognizer(target: self, action: .singleTapGesture)
        view.addGestureRecognizer(singleTap)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: .doubleTapGesture)
        doubleTap.numberOfTapsRequired = 2
        singleTap.requireGestureRecognizerToFail(doubleTap)
        view.addGestureRecognizer(doubleTap)
    }
    
    func resizeSubViews(photos: [UIImage]) {
        for p in photos {
            
        }
        imageView.frame = imageContainer.bounds
    }
    
    func singleTapGesture(recognizer: UITapGestureRecognizer) {
        
    }
    
    func doubleTapGesture(recognizer: UITapGestureRecognizer) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension BrowsePhotoViewController: UIScrollViewDelegate {
    // scrollview 减速停止
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
    }
}
