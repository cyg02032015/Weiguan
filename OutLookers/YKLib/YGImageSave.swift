//
//  YGImageSave.swift
//  OutLookers
//
//  Created by C on 16/7/27.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//  储存照片

import UIKit

class YGImageSave {
    class func save(dir: String, image: UIImage) -> (String, String)? {
        let fileManager = NSFileManager.defaultManager()
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        LogInfo(path)
        let date = NSDate()
        let dateStr = date.stringFromDateWith("yyyyMMddHHmmssSSS")
        let imageName = "i\(dateStr).png"
        LogInfo(imageName)
        // 判断 user-id/ 文件夹是否存在
        var objcBool: ObjCBool = true
        let directsuccess = fileManager.fileExistsAtPath(path.stringByAppendingString("/\(dir)"), isDirectory: &objcBool)
        if !directsuccess { // 不存在创建
            do {
                try fileManager.createDirectoryAtPath(path.stringByAppendingString("/\(dir)"), withIntermediateDirectories: true, attributes: nil)
            } catch let error as NSError {
                LogError(error)
            }
        }
        let imageFilePath = (path as NSString).stringByAppendingPathComponent(dir + imageName)
        LogDebug(imageFilePath)
        let success = fileManager.fileExistsAtPath(imageFilePath)
        if success {
            do {
                try fileManager.removeItemAtPath(imageFilePath)
            } catch let error as NSError {
                LogError("删除失败 \(error)")
            }
        } else {
            let success = UIImagePNGRepresentation(image)!.writeToFile(imageFilePath, atomically: true)
            if success {
                return (imageFilePath, imageName)
            } else {
                return nil
            }
        }
        return nil
    }
    
    /*

     
     UIImage *smallImage = [selfthumbnailWithImageWithoutScale:image size:CGSizeMake(93,93)];
     
     [UIImageJPEGRepresentation(smallImage,0.3)writeToFile:imageFilePathatomically:YES];
     
     UIImage *selfPhoto = [UIImageimageWithContentsOfFile:imageFilePath];//读取图片文件
     
     NSData *ImageData =UIImagePNGRepresentation(selfPhoto);
     
     [self updateToALi:ImageDataimageName:imageName];
     */
}
