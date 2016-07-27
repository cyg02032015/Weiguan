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
        OSSLog.enableLog()
        //        let credential = OSSStsTokenCredentialProvider(accessKeyId: object.accessKeyId, secretKeyId: object.accessKeySecret, securityToken: object.securityToken)
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
        for image in images {
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
                names.append(imageName)
                let data = UIImagePNGRepresentation(image)
                put.uploadingData = data
                let putTask = clinet.putObject(put)
                putTask.continueWithBlock({ (task) in
                    if task.error != nil {
                        LogError(task.error!)
                    } else {
                        let result = OSSPutObjectResult()
                        LogDebug("\(result.serverReturnJsonString)")
                    }
                    return nil
                })
                putTask.waitUntilFinished()
                if putTask.error == nil {
                    LogInfo("upload object success!")
                } else {
                    LogError("upload object failed, error: \(putTask.error!)")
                }
                if isAsync {
                    if image == images.last {
                        LogDebug("upload object Finished")
                    }
                    complete(names: names, state: .Success)
                }
            })
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
    
    class func getToken(object: GetToken) -> OSSFederationToken? {
        let url: NSURL = NSURL(string: "http://" + object.region + ".aliyuncs.com")!
        let request: NSURLRequest = NSURLRequest(URL: url)
        let tcs: OSSTaskCompletionSource = OSSTaskCompletionSource()
        let session: NSURLSession = NSURLSession.sharedSession()
        let sessionTask: NSURLSessionTask = session.dataTaskWithRequest(request, completionHandler: {(data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if error != nil {
                tcs.setError(error!)
                return
            }
            tcs.setResult(data)
        })
        sessionTask.resume()
        tcs.task.waitUntilFinished()
        if tcs.task.error != nil {
            return nil
        } else {
            guard let data = tcs.task.result as? NSData else {
                LogError("tcs.task.result == nil")
                return nil
            }
            let object = JSON(data: data)
            let token: OSSFederationToken = OSSFederationToken()
            token.tAccessKey = object["AccessKeyId"].stringValue
            token.tSecretKey = object["AccessKeySecret"].stringValue
            token.tToken = object["SecurityToken"].stringValue
            token.expirationTimeInGMTFormat = object["Expiration"].stringValue
            print("AccessKey: \(token.tAccessKey) \n SecretKey: \(token.tSecretKey) \n Token:\(token.tToken) expirationTime: \(token.expirationTimeInGMTFormat) \n")
            return token
        }
//        do {
//            if tcs.task.error != nil {
//                return nil
//            }
//            else {guard let data = tcs.task.result as? NSData else {
//                LogError("tcs.task.result == nil")
//                return nil
//                }
//                let object = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
//                let token: OSSFederationToken = OSSFederationToken()
//                token.tAccessKey = (object["AccessKeyId"] as! String)
//                token.tSecretKey = (object["AccessKeySecret"] as! String)
//                token.tToken = (object["SecurityToken"] as! String)
//                token.expirationTimeInGMTFormat = (object["Expiration"] as! String)
//                print("AccessKey: \(token.tAccessKey) \n SecretKey: \(token.tSecretKey) \n Token:\(token.tToken) expirationTime: \(token.expirationTimeInGMTFormat) \n")
//                return token
//            }
//        }
//        catch let error {
//            LogError(error)
//        }
//        return nil
    }
}
