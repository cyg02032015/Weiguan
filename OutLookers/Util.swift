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
    
    /// 获取发布按钮
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
    
    /// 获取导航栏左侧按钮tuple （UIButton，UIImageView）
    class func setupLeftBarButtonItemOfViewController(viewController: UIViewController, imgName: String) -> (UIButton, UIImageView) {
        let back = UIButton(type: .Custom)
        back.frame = CGRect(x: 0, y: 0, width: 45, height: 49)
        let imgView = UIImageView(image: UIImage(named: imgName))
        back.addSubview(imgView)
        imgView.frame = CGRect(x: 0, y: back.gg_midY - 10, width: 12, height: 20)
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: back)
        return (back, imgView)
    }
    
    /// 根据unit获取对应字符串
    class func unit(type: String) -> String {
        switch type {
        case "1": return "/小时"
            case "2": return "/场"
            case "3": return "/次"
            case "4": return "/半天"
            case "5": return "/天"
            case "6": return "/月"
            case "7": return "/年"
        default: return ""
        }
    }
    
    /// 获取用户类型
    class func userType(type: Int) -> UserType {
        switch type {
        case 0: return UserType.Tourist
        case 1: return UserType.HotMan
        case 2: return UserType.Organization
        case 3: return UserType.Fans
        default: return UserType.Tourist
        }
    }
    
    /// 获取应用版本号
    class func appVersion() -> String {
        guard let info = NSBundle.mainBundle().infoDictionary else {
            fatalError("info is nil")
        }
        guard let version = info["CFBundleShortVersionString"] as? String else {
            fatalError("version is nil")
        }
        return version
    }
}