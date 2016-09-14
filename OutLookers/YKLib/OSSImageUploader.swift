//
//  OSSImageUploder.swift
//  OutLookers
//
//  Created by C on 16/7/27.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import AliyunOSSiOS
import SwiftyJSON
import Alamofire

enum UploadImageState: Int {
    case Failed = 0
    case Success
}

class OSSImageUploader {
    // 最好不要用
    class func asyncUploadImage(object:GetToken, image: UIImage, complete: (names: [String], state: UploadImageState) -> Void) {
        self.uploadImages(object, images: [image], isAsync: true, complete: complete)
    }
    
    class func syncUploadImage(object:GetToken, image: UIImage, complete: (names: [String], state: UploadImageState) -> Void) {
        self.uploadImages(object, images: [image], isAsync: true, complete: complete)
    }
    
    class func asyncUploadImages(object:GetToken, images: [UIImage], complete: (names: [String], state: UploadImageState) -> Void) {
        self.uploadImages(object, images: images, isAsync: true, complete: complete)
    }
    
    class func syncUploadImages(object:GetToken, images: [UIImage], complete: (names: [String], state: UploadImageState) -> Void) {
        self.uploadImages(object, images: images, isAsync: true, complete: complete)
    }
    
    class func uploadImages(object:GetToken, images: [UIImage], isAsync: Bool, complete: (names: [String], state: UploadImageState) -> Void) {
        let credential = OSSFederationCredentialProvider { () -> OSSFederationToken! in
            return self.getToken(object)
        }
        let config = OSSClientConfiguration()
        config.maxRetryCount = 0
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource  = 24 * 60 * 60
        let endpoint = "http://" + object.region + ".aliyuncs.com"
        let clinet = OSSClient(endpoint: endpoint, credentialProvider: credential, clientConfiguration: config)
        let queue = NSOperationQueue()
        queue.maxConcurrentOperationCount = images.count <= 3 ? images.count : 3
        var names = [String]()
        
        for (var i, image) in images.enumerate() {
            let operation = NSBlockOperation(block: {
                let put = OSSPutObjectRequest()
                put.bucketName = object.bucket
                let date = NSDate()
                let dateStr = date.stringFromDateWith("yyyyMMddHHmmssSSS")
                let imageName = object.dir + "i\(dateStr).png"
                put.objectKey = imageName
                put.callbackParam = [
                    "callbackUrl": object.callbackUrl,
                    "callbackBody": object.callbackBody
                ]
                put.uploadProgress = { (bytesSent: Int64, totalByteSent: Int64, totalBytesExpectedToSend: Int64) in
                    LogError("\(bytesSent)   \(totalByteSent)     \(totalBytesExpectedToSend)")
                    let progress = Float(totalByteSent) / Float(totalBytesExpectedToSend)
                    //NSNotificationCenter.defaultCenter().postNotificationName(kUploadImageProressNotification, object: ["\(i)" : "\(progress)"])
                }
                var data: NSData?
                LogDebug("调试  =  \(image)")
                data = UIImageJPEGRepresentation(image, 0.9)
                put.uploadingData = data
                let putTask = clinet.putObject(put)
                //putTask.waitUntilFinished()
                putTask.continueWithBlock({ (task) in
                    if task.error != nil {
                        LogInfo("-----上传图片\(i)失败")
                        LogError(task.error!)
                        SVToast.showWithError(task.error!.localizedDescription)
                    } else {
                        LogInfo("-----上传图片\(i)成功")
                        let result = task.result!
                        let json = JSON.parse(result.serverReturnJsonString)
                        names.append(json["result"].stringValue)
                        if images.count == i {
                            complete(names: names, state: .Success)
                        }
                    }
                    return nil
                })
            })
            i = i + 1
            if queue.operations.count != 0 {
                operation.addDependency(queue.operations.last!)
            }
            queue.addOperation(operation)
        }
        if !isAsync {
            queue.waitUntilAllOperationsAreFinished()
            complete(names: names, state: .Success)
        }
    }
    
    class func getToken(object: GetToken) -> OSSFederationToken! {
            let token: OSSFederationToken = OSSFederationToken()
            token.tAccessKey = object.accessKeyId
            token.tSecretKey = object.accessKeySecret
            token.tToken = object.securityToken
            token.expirationTimeInGMTFormat = object.expiration
            return token
    }
    
    // 调用此方法上传图片
    class func asyncUploadImageData(object: GetToken, data: NSData, complete: (names: [String], state: UploadImageState) -> Void) {
        self.uploadImageDatas(object, datas: [data], isAsync: true, complete: complete)
    }
    
    class func asyncUploadImageDatas(object:GetToken, datas: [NSData], complete: (names: [String], state: UploadImageState) -> Void) {
        self.uploadImageDatas(object, datas: datas, isAsync: true, complete: complete)
    }
    
    class func uploadImageDatas(object:GetToken, datas: [NSData], isAsync: Bool, complete: (names: [String], state: UploadImageState) -> Void) {
        let credential = OSSFederationCredentialProvider { () -> OSSFederationToken! in
            return self.getToken(object)
        }
        let config = OSSClientConfiguration()
        config.maxRetryCount = 2
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource  = 24 * 60 * 60
        let endpoint = "http://" + object.region + ".aliyuncs.com"
        let clinet = OSSClient(endpoint: endpoint, credentialProvider: credential, clientConfiguration: config)
        let queue = NSOperationQueue()
        queue.maxConcurrentOperationCount = datas.count
        var names = [String]()
        var dataTotalBytes: Int64 = 0
        var dataSendBytes: Int64 = 0
        datas.forEach { (data) in
            dataTotalBytes += data.length
        }
        for (var i, data) in datas.enumerate() {
            let operation = NSBlockOperation(block: {
                let put = OSSPutObjectRequest()
                put.bucketName = object.bucket
                let date = NSDate()
                let dateStr = date.stringFromDateWith("yyyyMMddHHmmssSSS")
                let imageName = object.dir + "i\(dateStr).png"
                put.objectKey = imageName
                put.callbackParam = [
                    "callbackUrl": object.callbackUrl,
                    "callbackBody": object.callbackBody
                ]
                put.uploadProgress = { (bytesSent: Int64, totalByteSent: Int64, totalBytesExpectedToSend: Int64) in
                    LogError("\(bytesSent)   \(totalByteSent)     \(totalBytesExpectedToSend)")
                    dataSendBytes += bytesSent
                    SVProgressHUD.showProgress(Float(dataSendBytes)/Float(dataTotalBytes), status: "图片正在上传")
                    if Float(dataSendBytes)/Float(dataTotalBytes) == 1 {
                        SVProgressHUD.dismiss()
                    }
                    //NSNotificationCenter.defaultCenter().postNotificationName(kUploadImageProressNotification, object: ["\(i)" : "\(progress)"])
                }
                put.uploadingData = data
                let putTask = clinet.putObject(put)
                //putTask.waitUntilFinished()
                putTask.continueWithBlock({ (task) in
                    if task.error != nil {
                        LogInfo("-----上传图片\(i)失败")
                        LogError(task.error!)
                    } else {
                        LogInfo("-----上传图片\(i)成功")
                        let result = task.result!
                        let json = JSON.parse(result.serverReturnJsonString)
                        names.append(json["result"].stringValue)
                        if datas.count == i {
                            complete(names: names, state: .Success)
                        }
                    }
                    return nil
                })
            })
            i = i + 1
            if queue.operations.count != 0 {
                operation.addDependency(queue.operations.last!)
            }
            queue.addOperation(operation)
        }
        if !isAsync {
            queue.waitUntilAllOperationsAreFinished()
            complete(names: names, state: .Success)
        }
    }
}
