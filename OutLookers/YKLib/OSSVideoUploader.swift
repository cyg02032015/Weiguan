//
//  OSSVideoUploader.swift
//  OutLookers
//
//  Created by C on 16/7/28.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import AliyunOSSiOS
import SwiftyJSON

class OSSVideoUploader {
    
    @warn_unused_result(message="返回的OSSPutObjectRequest对象没有使用")
    class func asyncUploadVideo(object:GetToken, videoURL: NSURL, complete: (id: String, state: UploadImageState) -> Void) -> OSSPutObjectRequest {
        return self.uploadVideos(object, videoURL: videoURL, isAsync: true, complete: complete)
    }
    
    class func uploadVideos(object:GetToken, videoURL: NSURL, isAsync: Bool, complete: (id: String, state: UploadImageState) -> Void) -> OSSPutObjectRequest {
        let credential = OSSFederationCredentialProvider { () -> OSSFederationToken! in
            return self.getToken(object)
        }
        let config = OSSClientConfiguration()
        config.maxRetryCount = 0
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource  = 24 * 60 * 60
        let endpoint = "http://" + object.region + ".aliyuncs.com"
        LogInfo(endpoint)
        let clinet = OSSClient(endpoint: endpoint, credentialProvider: credential, clientConfiguration: config)
        let put = OSSPutObjectRequest()
        put.bucketName = object.bucket
        let date = NSDate()
        let dateStr = date.stringFromDateWith("yyyyMMddHHmmssSSS")
        let videoName = object.dir + "i\(dateStr).mp4"
        put.objectKey = videoName
        put.callbackParam = [
            "callbackUrl": object.callbackUrl,
            "callbackBody": object.callbackBody
        ]
        put.uploadingFileURL = videoURL
        put.uploadProgress = { (bytesSent: Int64, totalByteSent: Int64, totalBytesExpectedToSend: Int64) in
            LogError("\(bytesSent)   \(totalByteSent)     \(totalBytesExpectedToSend)")
            let progress = Float(totalByteSent) / Float(totalBytesExpectedToSend)
            dispatch_async_safely_to_main_queue({
                SVProgressHUD.showProgress(progress, status: "\(Int(progress*100))%")
            })
        }
        let putTask = clinet.putObject(put)
        putTask.continueWithBlock({ (task) in
            if task.error != nil {
                LogError(task.error!)
                SVToast.showWithError(putTask.error!.localizedDescription)
            } else {
                let result = task.result!
                let json = JSON.parse(result.serverReturnJsonString)
                complete(id: json["result"].stringValue, state: .Success)
            }
            return nil
        })
        //putTask.waitUntilFinished()
        if putTask.error == nil {
            LogInfo("upload video success! = \(videoName)")
        } else {
            LogError("upload video failed, error: \(putTask.error!)")
            SVToast.showWithError(putTask.error!.localizedDescription)
        }
        return put
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
