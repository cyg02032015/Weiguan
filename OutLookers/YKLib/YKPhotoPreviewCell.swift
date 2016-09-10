//
//  YKPhotoPreviewCell.swift
//  OutLookers
//
//  Created by C on 16/6/26.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private extension Selector {
    static let singleTapGesture = #selector(YKPhotoPreviewCell.singleTapGesture(_:))
    static let doubleTapGesture = #selector(YKPhotoPreviewCell.doubleTapGesture(_:))
}

protocol YKPhotoPreviewCellDelegate: class {
    func photoPreviewSingleTap(sender: UITapGestureRecognizer)
}

class YKPhotoPreviewCell: UICollectionViewCell {
    
    var _img: UIImage!
    var img: UIImage! {
        set {
            _img = newValue
            scrollView.setZoomScale(1.0, animated: false)
            imageView.image = newValue
            resizeSubviews()
        }
        get {
            return _img
        }
    }
    weak var delegate: YKPhotoPreviewCellDelegate!
    var scrollView: UIScrollView!
    var imageView: UIImageView!
    var imageContainer: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubView()
    }
    
    func resizeSubviews() {
        imageContainer.gg_origin = CGPointZero
        imageContainer.gg_width = self.gg_width
        
        guard let image = imageView.image else { LogError("image is nil"); return }
        if image.size.height / image.size.width > self.gg_height / self.gg_width {
            imageContainer.gg_height = floor(image.size.height / (image.size.width / self.gg_width))
        } else {
            var height = image.size.height / image.size.width * self.gg_width
            if height < 1 || isnan(height) {
                height = self.gg_height
            }
            height = floor(height)
            imageContainer.gg_height = height
            imageContainer.center.y = self.gg_height / 2
        }
        if imageContainer.gg_height > self.gg_height && imageContainer.gg_height - self.gg_height <= 1 {
            imageContainer.gg_height = self.gg_height
        }
        scrollView.contentSize = CGSize(width: self.gg_width, height: max(imageContainer.gg_height, self.gg_height))
        scrollView.scrollRectToVisible(self.bounds, animated: false)
        scrollView.alwaysBounceVertical = imageContainer.gg_height <= self.gg_height ? false : true
        imageView.frame = imageContainer.bounds
    }
    
    func setupSubView() {
        backgroundColor = UIColor.blackColor()
        scrollView = UIScrollView(frame: CGRect(origin: CGPointZero, size: CGSize(width: gg_width, height: gg_height)))
        scrollView.bouncesZoom = true
        scrollView.maximumZoomScale = 2.5
        scrollView.minimumZoomScale = 1.0
        scrollView.multipleTouchEnabled = true
        scrollView.scrollsToTop = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        scrollView.delaysContentTouches = true
        scrollView.alwaysBounceVertical = false
        scrollView.delegate = self
        addSubview(scrollView)
        
        imageContainer = UIView()
        imageContainer.clipsToBounds = true
        scrollView.addSubview(imageContainer)
        
        imageView = UIImageView()
        imageView.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        imageView.clipsToBounds = true
        imageContainer.addSubview(imageView)
        
        let tap1 = UITapGestureRecognizer(target: self, action: .singleTapGesture)
        addGestureRecognizer(tap1)
        
        let tap2 = UITapGestureRecognizer(target: self, action: .doubleTapGesture)
        tap2.numberOfTapsRequired = 2
        tap1.requireGestureRecognizerToFail(tap2)
        addGestureRecognizer(tap2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension YKPhotoPreviewCell: UIScrollViewDelegate {
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageContainer
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        let offsetX = (scrollView.gg_width > scrollView.contentSize.width) ? (scrollView.gg_width - scrollView.contentSize.width) * 0.5 : 0
        let offsetY = (scrollView.gg_height > scrollView.contentSize.height) ? (scrollView.gg_height - scrollView.contentSize.height) * 0.5 : 0
        self.imageContainer.center = CGPoint(x: scrollView.contentSize.width * 0.5 + offsetX, y: scrollView.contentSize.height * 0.5 + offsetY)
    }
}

extension YKPhotoPreviewCell {
    
    func singleTapGesture(recognizer: UITapGestureRecognizer) {
        delegate.photoPreviewSingleTap(recognizer)
    }
    
    func doubleTapGesture(recognizer: UITapGestureRecognizer) {
        if scrollView.zoomScale > 1 {
            scrollView.setZoomScale(1.0, animated: true)
        } else {
            let touchPoint = recognizer.locationInView(self.imageView)
            let newZoomScale = scrollView.maximumZoomScale
            let xsize = self.frame.size.width / newZoomScale
            let ysize = self.frame.size.height / newZoomScale
            scrollView.zoomToRect(CGRect(x: touchPoint.x - xsize/2, y: touchPoint.y - ysize/2, width: xsize, height: ysize), animated: true)
        }
    }
}
