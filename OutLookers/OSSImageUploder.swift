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
    
    class func asyncUploadImage(object:GetToken, image: UIImage, complete: (names: [String], state: UploadImageState) -> Void) {
        self.uploadImages(object, images: [image], isAsync: true, complete: complete)
    }
    
    class func syncUploadImage(object:GetToken, image: UIImage, complete: (names: [String], state: UploadImageState) -> Void) {
        self.uploadImages(object, images: [image], isAsync: false, complete: complete)
    }
    
    class func asyncUploadImages(object:GetToken, images: [UIImage], complete: (names: [String], state: UploadImageState) -> Void) {
        self.uploadImages(object, images: images, isAsync: true, complete: complete)
    }
    
    class func syncUploadImages(object:GetToken, images: [UIImage], complete: (names: [String], state: UploadImageState) -> Void) {
        self.uploadImages(object, images: images, isAsync: false, complete: complete)
    }
    
    class func uploadImages(object:GetToken, images: [UIImage], isAsync: Bool, complete: (names: [String], state: UploadImageState) -> Void) {
//        OSSLog.enableLog()
        let credential = OSSFederationCredentialProvider { () -> OSSFederationToken! in
            return self.getToken(object)
        }
        let config = OSSClientConfiguration()
        config.maxRetryCount = 2
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource  = 24 * 60 * 60
        let endpoint = "http://" + object.region + ".aliyuncs.com"
        LogInfo(endpoint)
        let clinet = OSSClient(endpoint: endpoint, credentialProvider: credential, clientConfiguration: config)
        let queue = NSOperationQueue()
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
                let data = UIImagePNGRepresentation(image)
                put.uploadingData = data
                let putTask = clinet.putObject(put)
                putTask.continueWithBlock({ (task) in
                    if task.error != nil {
                        LogError(task.error!)
                    } else {
                        let result = task.result!
                        let json = JSON.parse(result.serverReturnJsonString)
                        names.append(json["result"].stringValue)
                        if images.count == i {
                            complete(names: names, state: .Success)
                        }
                    }
                    return nil
                })
                putTask.waitUntilFinished()
                if putTask.error == nil {
                    LogInfo("upload object success!")
                } else {
                    LogError("upload object failed, error: \(putTask.error!)")
                }
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
}
