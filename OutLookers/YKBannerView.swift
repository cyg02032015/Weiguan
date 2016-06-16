//
//  YKBannerView.swift
//  YKBannerView
//
//  Created by C on 15/11/16.
//  Copyright © 2015年 YoungKook. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

enum PageControlAlignment: Int {
    case Left = 0
    case Right
    case Center
    case None
}
public class YKBannerView: UIView {
    
    typealias TapClosure = (index: Int) -> Void
    internal var tapClosure: TapClosure!
    
    private lazy var imageArray = [UIImageView]()  // 总imageView数
    private lazy var currentArray = [UIImageView]()  // 每次添加3张图片
    private var currentPage: Int = 0
    private var scrollView: UIScrollView!
    private var pageControl: UIPageControl!
    private lazy var timer = NSTimer()
    public lazy var dataArray = [String]()  // 图片资源总数
    
    public var placeHolderImage: UIImage?
    
    private var cColor: UIColor!
    public var currentIndicatorColor: UIColor? {   // 当前圈圈颜色
        get {
            return cColor
        }
        set {
            cColor = newValue
            pageControl.currentPageIndicatorTintColor = newValue
        }
    }
    
    private var pIndicatorColor: UIColor!
    public var pageIndicatorColor: UIColor? {  // pageIndicator 颜色
        get {
            return pIndicatorColor
        }
        set {
            pIndicatorColor = newValue
            pageControl.pageIndicatorTintColor = newValue
        }
    }
    
    private var duration: NSTimeInterval!
    public var animationDuration: NSTimeInterval {  // 设置几秒一次动画
        get {
            return duration
        }
        set {
            duration = newValue
            timer.invalidate()
            if newValue <= 0 {
                return
            }
            timer = NSTimer.scheduledTimerWithTimeInterval(newValue, target: self, selector: #selector(YKBannerView.animationTimerDidFired), userInfo: nil, repeats: true)
            NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
            timer.fire()
        }
    }
    
    private var pageAlign: PageControlAlignment!
    var pageControlAlignment: PageControlAlignment {   // 枚举 居左 居右  默认为居中
        get {
            return pageAlign
        }
        set {
            self.pageControl.hidden = false
            pageAlign = newValue
            let size = CGSize(width: CGFloat(dataArray.count) * 10 * 1.2, height: 10)
            switch newValue {
            case .Left:
                let x = CGFloat(20)
                let y = scrollView.frame.size.height - size.height - 10
                self.pageControl.frame = CGRect(x: x, y: y, width: size.width, height: size.height)
            case .Right:
                let x = scrollView.frame.size.width - size.width - 20
                let y = scrollView.frame.size.height - size.height - 10
                self.pageControl.frame = CGRect(x: x, y: y, width: size.width, height: size.height)
            case .Center:
                self.pageControl.frame = CGRect(x: 0, y: CGRectGetHeight(self.scrollView.frame) - 20, width: CGRectGetWidth(self.scrollView.frame), height: 10)
            case .None:
                self.pageControl.hidden = true
            }
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.autoresizesSubviews = true
        
        self.scrollView = UIScrollView(frame: self.bounds)
        self.scrollView.contentMode = .Center
        self.scrollView.contentSize = CGSize(width: CGFloat(3) * self.bounds.width, height: self.bounds.height)
        self.scrollView.delegate = self
        self.scrollView.contentOffset = CGPoint(x: self.bounds.width, y: 0)
        self.scrollView.pagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.addSubview(self.scrollView)
        
        self.pageControl = UIPageControl()
        self.pageControl.currentPageIndicatorTintColor = UIColor.whiteColor()
        self.pageControl.pageIndicatorTintColor = UIColor.grayColor()
        self.addSubview(self.pageControl)
        
        // 默认动画时间
        self.animationDuration = 5
        // 默认居中
        self.pageControlAlignment = .Center
        
        self.currentPage = 0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(YKBannerView.tap))
        self.addGestureRecognizer(tap)
    }
    
    public func animationTimerDidFired() {
        let offset = CGPoint(x:self.scrollView.contentOffset.x + CGRectGetWidth(scrollView.frame), y: scrollView.contentOffset.y)
        scrollView.setContentOffset(offset, animated: true)
    }
    
    private func downLoadImage() {
        if self.dataArray.count > 0 {
            for (_, url) in dataArray.enumerate() {
                let imageView = UIImageView(frame: self.scrollView.frame)
                imageView.kf_setImageWithURL(NSURL(string: url)!, placeholderImage: placeHolderImage)
                self.imageArray.append(imageView)
            }
            self.pageControl.numberOfPages = imageArray.count
            self.configContentViews()
        }
    }
    
    private func configContentViews() {
        for obj in self.scrollView.subviews {
            obj.removeFromSuperview()
        }
        let prePage = self.getNextPageIndex(self.currentPage - 1)
        let nextPage = self.getNextPageIndex(self.currentPage + 1)
        if currentArray.count != 0 {
            currentArray.removeAll()
        }
        guard imageArray.count > 0 else {
            return
        }
        if imageArray.count >= 3 {
            currentArray.append(imageArray[prePage])
            currentArray.append(imageArray[currentPage])
            currentArray.append(imageArray[nextPage])
        } else {
            self.getImageFromArray(imageArray[prePage])
            self.getImageFromArray(imageArray[currentPage])
            self.getImageFromArray(imageArray[nextPage])
        }
        
        for (index, obj) in currentArray.enumerate() {
            obj.userInteractionEnabled = true
            obj.frame = CGRect(origin: CGPoint(x: CGRectGetWidth(scrollView.frame) * CGFloat(index), y: 0), size: obj.frame.size)
            self.scrollView.addSubview(obj)
        }
        self.scrollView.setContentOffset(CGPoint(x: self.frame.width, y: 0), animated: false)
    }
    
    public func getImageFromArray(imageView: UIImageView) {
        autoreleasepool { () -> () in
            let tempImg = UIImageView(frame: imageView.frame)
            tempImg.image = imageView.image
            self.currentArray.append(tempImg)
        }
    }
    
    private func getNextPageIndex(currentPageIndex: Int) -> Int {
        if currentPageIndex == -1 {
            return dataArray.count - 1
        } else if currentPageIndex == dataArray.count {
            return 0
        } else {
            return currentPageIndex
        }
    }
    
    public func tap() {
        self.tapClosure(index: self.currentPage)
    }
    
    func startTapActionClosure(closure: TapClosure) {
        self.timer.fireDate = NSDate()
        downLoadImage()
        self.tapClosure = closure
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("required init fail")
    }
}

extension YKBannerView: UIScrollViewDelegate {
    public func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        timer.fireDate = NSDate.distantFuture()
    }
    
    public func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        timer.fireDate = NSDate.distantPast()
    }
    
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        let contentOffsetX = Int(scrollView.contentOffset.x)
        if CGFloat(contentOffsetX) >= 2 * CGRectGetWidth(scrollView.frame) {
            self.currentPage = getNextPageIndex(currentPage + 1)
            pageControl.currentPage = currentPage
            self.configContentViews()
        }
        if contentOffsetX <= 0 {
            self.currentPage = getNextPageIndex(currentPage - 1)
            pageControl.currentPage = currentPage
            self.configContentViews()
        }
    }
    
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        scrollView.setContentOffset(CGPoint(x: CGRectGetWidth(scrollView.frame), y: 0), animated: true)
    }
}
