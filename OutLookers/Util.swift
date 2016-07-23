//
//  Util.swift
//  OutLookers
//
//  Created by C on 16/7/13.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import MobileCoreServices

class Util {
    
    class func createReleaseButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, forState: .Normal)
        button.backgroundColor = kGrayColor
        button.titleLabel!.font = UIFont.customFontOfSize(16)
        return button
    }
    
    class func actionSheetImagePicker(isCamera camera: Bool) -> UIImagePickerController? {
        if camera {
            if UIImagePickerController.isAvailableCamera() && UIImagePickerController.isSupportTakingPhotos(){
                let controller = UIImagePickerController()
                controller.sourceType = .Camera
                if UIImagePickerController.isAvailableCameraDeviceFront() {
                    controller.cameraDevice = .Front
                }
                var mediaTypes = [String]()
                mediaTypes.append(kUTTypeImage as String)
                controller.mediaTypes = mediaTypes
                controller.allowsEditing = true
                return controller
            }
            return nil
        } else {
            if UIImagePickerController.isAvailablePhotoLibrary() {
                let controller = UIImagePickerController()
                controller.sourceType = .PhotoLibrary
                var mediaTypes = [String]()
                mediaTypes.append(kUTTypeImage as String)
                controller.mediaTypes = mediaTypes
                controller.allowsEditing = true
                return controller
            }
            return nil
        }
    }
    
    class func setupLeftBarButtonItemOfViewController(viewController: UIViewController, imgName: String) -> (UIButton, UIImageView) {
        let back = UIButton(type: .Custom)
        back.frame = CGRect(x: 0, y: 0, width: 45, height: 49)
        let imgView = UIImageView(image: UIImage(named: imgName))
        back.addSubview(imgView)
        imgView.frame = CGRect(x: 0, y: back.gg_midY - 10, width: 12, height: 20)
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: back)
        return (back, imgView)
    }
    /*
     UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
     backButton.frame = CGRectMake(0, 0, 45, 49);
     UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgName]];
     [backButton addSubview:imageView];
     [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
     make.left.equalTo(imageView.superview);
     make.centerY.equalTo(imageView.superview);
     make.size.mas_equalTo(CGSizeMake(16, 16));
     }];
     vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
     return backButton;
     */
}