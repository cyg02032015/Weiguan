//
//  YGPhotoKitController.swift
//  OutLookers
//
//  Created by C on 16/6/20.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

protocol YGPhotoKitDelegate: class {
    func photoKitController(photoKitController: YGPhotoKitController, resultImage: UIImage)
}

public class YGPhotoKitController: UIViewController {

    /// 原始图片
    public var imageOriginal: UIImage!
    /// 图片的尺寸,剪切框，最好是需求图片的2x, 默认是CGSizeMake(ScreenWidth, ScreenWidth);
    public var sizeClip: CGSize!
    weak var delegate: YGPhotoKitDelegate!
    
    /// 图片
    private var imageView: UIImageView!
    /// 取消按钮
    private var buttonCancel: UIButton!
    /// 确认按钮
    private var confirm: UIButton!
    /// 覆盖图
    private var viewOverlay: UIView!
    /// 修建的位置
    private var rectClip: CGRect!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    /*
     - (void)viewDidLoad {
     [super viewDidLoad];
     [self.viewOverlay setHollowWithCenterFrame:self.rectClip];
     [self.view setBackgroundColor:[UIColor blackColor]];
     [self.view addSubview:self.imageView];
     [self.view addSubview:self.viewOverlay];
     [self.view addSubview:self.buttonCancel];
     [self.view addSubview:self.buttonConfirm];
     [self.view addSubview:self.buttonBack];
     [self addGestureRecognizerToView:self.view];
     }

     */
    
//    func cancel(sender: UIButton)  {
//        dismissViewControllerAnimated(true, completion: nil)
//    }
//    
//    func confirm(sender: UIButton) {
//        delegate.photoKitController(self, resultImage: self.getResultImage)
//        dismissViewControllerAnimated(true, completion: nil)
//    }
    
    
}