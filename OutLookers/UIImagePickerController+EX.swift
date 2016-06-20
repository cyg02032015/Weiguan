//
//  UIImagePickerController+EX.swift
//  OutLookers
//
//  Created by C on 16/6/20.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices

extension UIImagePickerController {
    
    /// 相册是否可用
    func isAvailablePhotoLibrary() -> Bool {
        return UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary)
    }
    /// 相机是否可用
    func isAvailableCamera() -> Bool {
        return UIImagePickerController.isSourceTypeAvailable(.Camera)
    }
    
    /// 是否可以保存相册可用
    func isAvailableSavedPhotosAlbum() -> Bool {
        return UIImagePickerController.isSourceTypeAvailable(.SavedPhotosAlbum)
    }
    
    /// 是否后置摄像头可用
    func isAvailableCameraDeviceRear() -> Bool {
        return UIImagePickerController.isCameraDeviceAvailable(.Rear)
    }
    
    /// 是否前置摄像头可用
    func isAvailableCameraDeviceFront() -> Bool {
        return UIImagePickerController.isCameraDeviceAvailable(.Front)
    }
    
    /// 是否支持拍照权限
    func isSupportTakingPhotos() -> Bool {
        let mediaType = AVMediaTypeVideo
        let authStatus = AVCaptureDevice.authorizationStatusForMediaType(mediaType)
        if authStatus == .Restricted || authStatus == .Denied {
            return false
        } else {
            return true
        }
    }
    
    /// 是否支持获取相册视频权限
    func isSupportPickVideosFromPhotoLibrary() -> Bool {
        return self.isSupportsMedia(kUTTypeMovie as String, sourceType: .PhotoLibrary)
    }
    
    /// 是否支持获取相册图片权限
    func isSupportsMedia() -> Bool {
        return self.isSupportsMedia(kUTTypeImage as String, sourceType: .PhotoLibrary)
    }
    
    class func imagePickerControllerWithSourceType(sourceType: UIImagePickerControllerSourceType) -> UIImagePickerController {
        let controller = UIImagePickerController()
        controller.sourceType = sourceType
        controller.mediaTypes = [kUTTypeImage as String]
        return controller
    }
    
    
    func isSupportsMedia(mediaType: String, sourceType: UIImagePickerControllerSourceType) -> Bool {
        var result: Bool = false
        if mediaType.characters.count == 0 {
            return false
        }
        let availableMediaTypes = UIImagePickerController.availableMediaTypesForSourceType(sourceType)
        guard let available = availableMediaTypes?.enumerate() else { fatalError("availableMediaTypes nil") }
        for (_,obj) in available.enumerate() {
            let mediaType = obj
            if mediaType == mediaType {
                result = true
                break
            }
        }
        return result
    }
    
}
