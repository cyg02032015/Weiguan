//
//  BrowsePhotoViewController.swift
//  OutLookers
//
//  Created by C on 16/6/16.
//  Copyright © 2016年 youngkook. All rights reserved.
//

import UIKit

let iOS7Later = Float(UIDevice.currentDevice().systemVersion) > 7.0
private let photoPreviewCellIdentifier = "photoPreviewCellId"

private extension Selector {
    static let tapBackButton = #selector(YKPhotoPreviewController.tapBackButton(_:))
    static let tapDeletButton = #selector(YKPhotoPreviewController.tapDeletButton(_:))
}

class YKPhotoPreviewController: YGBaseViewController {
    typealias didFinishPickImage = (photos: [UIImage], originPhotos: [AnyObject]) -> Void
    var didFinishPickClousure: didFinishPickImage!
    var collectionView: UICollectionView!
    lazy var photos = [UIImage]()
    lazy var originPhotos = [AnyObject]()
    var naviBar: UIView!
    var titleLabel: UILabel!
    var toolBar: UIView!
    
    var currentIndex: Int!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//        if iOS7Later {
//            UIApplication.sharedApplication().statusBarHidden = true
//        }
        if currentIndex != nil {
            collectionView.setContentOffset(CGPoint(x: view.gg_width * CGFloat(currentIndex), y: 0), animated: false)
        }
        if photos.count > 0 {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        configNavigationBar()
        configToolBar()
    }
    
    func configToolBar() {
        toolBar = UIView(frame: CGRect(origin: CGPoint(x: 0, y: view.gg_height - 49), size: CGSize(width: view.gg_width, height: 49)))
        toolBar.backgroundColor = UIColor(r: 34, g: 34, b: 34, a: 1.0)
        toolBar.alpha = 0.7
        view.addSubview(toolBar)
        
        let deletButton = UIButton(frame: CGRect(x: view.gg_width - 50, y: 0, width: 44, height: 49))
        deletButton.addTarget(self, action: .tapDeletButton, forControlEvents: .TouchUpInside)
        deletButton.setTitle("de", forState: .Normal)
        toolBar.addSubview(deletButton)
    }
    
    func configNavigationBar() {
        naviBar = UIView(frame: CGRect(origin: CGPointZero, size: CGSize(width: view.gg_width, height: 64)))
        naviBar.backgroundColor = UIColor(r: 34, g: 34, b: 34, a: 1.0)
        naviBar.alpha = 0.7
        view.addSubview(naviBar)
        
        let backButton = UIButton(frame: CGRect(x: 10, y: 10, width: 44, height: 44))
        backButton.addTarget(self, action: .tapBackButton, forControlEvents: .TouchUpInside)
        backButton.setTitle("返回", forState: .Normal)
        naviBar.addSubview(backButton)
        
        titleLabel = UILabel(frame: CGRect(x: 50, y: 0, width: view.gg_width - 100, height: naviBar.gg_height))
        titleLabel.textAlignment = .Center
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.text = "\(currentIndex + 1)/\(photos.count)"
        naviBar.addSubview(titleLabel)
    }
    
    func configCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.gg_width, height: view.gg_height)
        layout.scrollDirection = .Horizontal
        
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: CGRect(origin: CGPointZero, size: CGSize(width: view.gg_width, height: view.gg_height)), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.blackColor()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.pagingEnabled = true
        collectionView.scrollsToTop = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentOffset = CGPointZero
        collectionView.contentSize = CGSizeMake(view.gg_width * CGFloat(photos.count), view.gg_height)
        view.addSubview(collectionView)
        collectionView.registerClass(YKPhotoPreviewCell.self, forCellWithReuseIdentifier: photoPreviewCellIdentifier)
    }
}

extension YKPhotoPreviewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(photoPreviewCellIdentifier, forIndexPath: indexPath) as! YKPhotoPreviewCell
        cell.img = photos[indexPath.item]
        cell.delegate = self
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        currentIndex = Int((offset.x + (view.gg_width * 0.5)) / view.gg_width)
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        titleLabel.text = "\(currentIndex + 1)/\(photos.count)"
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        titleLabel.text = "\(currentIndex + 1)/\(photos.count)"
    }
}

// MARK: - 按钮点击响应
extension YKPhotoPreviewController: YKPhotoPreviewCellDelegate {
    
    func tapBackButton(sender: UIButton) {
        if didFinishPickClousure != nil {
            didFinishPickClousure(photos: photos, originPhotos: originPhotos)
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func didFinishPickingPhotos(closure: didFinishPickImage) {
        didFinishPickClousure = closure
    }
    
    func tapDeletButton(sender: UIButton) {
        let alert = UIAlertView(title: "", message: "确定删除该图片吗?", delegate: self, cancelButtonTitle: "确定", otherButtonTitles: "点错了")

        alert.show()

    }
    
    func photoPreviewSingleTap(sender: UITapGestureRecognizer) {
        
    }
}

extension YKPhotoPreviewController: UIAlertViewDelegate {
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        LogDebug(buttonIndex)
        switch buttonIndex {
        case 0:
            if photos.count > 0 {
                self.photos.removeAtIndex(currentIndex)
                self.originPhotos.removeAtIndex(currentIndex)
                if currentIndex >= 1 {
                    currentIndex = currentIndex - 1
                } else {
                    currentIndex = 0
                    titleLabel.text = "\(currentIndex + 1)/\(photos.count)"
                }
                if photos.count == 0 {
                    if didFinishPickClousure != nil {
                        didFinishPickClousure(photos: photos, originPhotos: originPhotos)
                    }
                    dismissViewControllerAnimated(true, completion: nil)
                    return
                }
                collectionView.reloadData()
                collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: currentIndex, inSection: 0), atScrollPosition: .None, animated: true)
            }
            break
        case 1:
            LogDebug("点错了")
            break
        default: LogWarn("switch default")
        }
    }
}