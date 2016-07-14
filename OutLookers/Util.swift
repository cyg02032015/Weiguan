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
}