//
//  UIImage+EX.swift
//  SuperWay
//
//  Created by C on 15/9/16.
//  Copyright © 2015年 YoungKook. All rights reserved.
//

import UIKit

//MARK: 拉伸图片
extension UIImage {
    class func resizeImageWith(imagename: String) -> UIImage {
        return self.resizeImageWith(imagename, left: 0.5, top: 0.5)
    }
    class func resizeImageWith(imageName: String, left: CGFloat, top: CGFloat) -> UIImage {
        let image = UIImage(named: imageName)!
        return image.stretchableImageWithLeftCapWidth(Int(ceil(image.size.width*left)), topCapHeight: Int(ceil(image.size.height*top)))
    }
    
    // MARK: - 降低质量
    func resetSizeOfImageData(source_image: UIImage, maxSize: Int, compeleted:(data: NSData)->Void) {
        //先调整分辨率
        var newSize = CGSize(width: source_image.size.width, height: source_image.size.height)
        
        let tempHeight = newSize.height / 1024
        let tempWidth  = newSize.width / 1024
        
        if tempWidth > 1.0 && tempWidth > tempHeight {
            newSize = CGSize(width: source_image.size.width / tempWidth, height: source_image.size.height / tempWidth)
        }
        else if tempHeight > 1.0 && tempWidth < tempHeight {
            newSize = CGSize(width: source_image.size.width / tempHeight, height: source_image.size.height / tempHeight)
        }
        
        UIGraphicsBeginImageContext(newSize)
        source_image.drawAsPatternInRect(CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //先判断当前质量是否满足要求，不满足再进行压缩
        var finallImageData = UIImageJPEGRepresentation(newImage,1.0)
        let sizeOrigin      = Int64((finallImageData?.length)!)
        let sizeOriginKB    = Int(sizeOrigin / 1024)
        if sizeOriginKB <= maxSize {
            compeleted(data: finallImageData!)
            return
        }
        
        //保存压缩系数
        let compressionQualityArr = NSMutableArray()
        let avg = CGFloat(1.0/250)
        var value = avg
        var i = 250
        while i>=1 {
            value = CGFloat(i)*avg
            compressionQualityArr.addObject(value)
            i -= 1
        }
//        for var i = 250; i>=1; i -= 1 {
//            value = CGFloat(i)*avg
//            compressionQualityArr.addObject(value)
//        }
        
        //调整大小
        //说明：压缩系数数组compressionQualityArr是从大到小存储。
        //思路：折半计算，如果中间压缩系数仍然降不到目标值maxSize，则从后半部分开始寻找压缩系数；反之从前半部分寻找压缩系数
        finallImageData = UIImageJPEGRepresentation(newImage, CGFloat(compressionQualityArr[125] as! NSNumber))
        if Int(Int64((UIImageJPEGRepresentation(newImage, CGFloat(compressionQualityArr[125] as! NSNumber))?.length)!)/1024) > maxSize {
            //拿到最初的大小
            finallImageData = UIImageJPEGRepresentation(newImage, 1.0)
            //从后半部分开始
            for idx in 126..<250 {
                let value = compressionQualityArr[idx]
                let sizeOrigin   = Int64((finallImageData?.length)!)
                let sizeOriginKB = Int(sizeOrigin / 1024)
                print("当前降到的质量：\(sizeOriginKB)")
                if sizeOriginKB > maxSize {
                    print("\(idx)----\(value)")
                    finallImageData = UIImageJPEGRepresentation(newImage, CGFloat(value as! NSNumber))
                } else {
                    break
                }
            }
        } else {
            //拿到最初的大小
            finallImageData = UIImageJPEGRepresentation(newImage, 1.0)
            //从前半部分开始
            for idx in 0..<125 {
                let value = compressionQualityArr[idx]
                let sizeOrigin   = Int64((finallImageData?.length)!)
                let sizeOriginKB = Int(sizeOrigin / 1024)
                print("当前降到的质量：\(sizeOriginKB)")
                if sizeOriginKB > maxSize {
                    print("\(idx)----\(value)")
                    finallImageData = UIImageJPEGRepresentation(newImage, CGFloat(value as! NSNumber))
                } else {
                    break
                }
            }
        }
        compeleted(data: finallImageData!)
        return 
    }
}



