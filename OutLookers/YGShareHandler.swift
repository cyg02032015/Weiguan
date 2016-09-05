//
//  YGShareSDK.swift
//  OutLookers
//
//  Created by Youngkook on 16/6/24.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

let kSelectedTimeline = "wechat_moment_c"
let kSelectedWechat = "wechat_c"
let kSelectedSina = "sina_weibo_c"
let kSelectedQzone = "qzone_c"
let kSelectedQQ = "qq_c"
let kDeleteImg = "delete  copy 4"
let kEditImg = "edit"
let kHomeImg = "Return"
let kReportImg = "Report"


let kUnSelectedTimeline = "wechat_moment－Unchecked"
let kUnSelectedWechat = "wechat_Unchecked"
let kUnSelectedSina = "sina_weibo_Unchecked"
let kUnSelectedQzone = "qzone_Unchecked"
let kUnSelectedQQ = "qq_Unchecked"

let kTitleTimeline = "朋友圈"
let kTitleWechat = "微信"
let kTitleSina = "微博"
let kTitleQzone = "空间"
let kTitleQQ = "QQ"
let kDelete = "删除"
let kHome = "返回首页"
let kReport = "举报"
let kEdit = "编辑"

enum YGShareType : Int {
    case DYVisitor //动态详情游客视角
    case DYHost //动态详情主人视角
    case CCVisitor //通告详情游客视角
    case CCHost //通告详情主人视角
}

class YGShareHandler {
    /**
     判断有没有安装app
     
     - returns: 返回一个元组 (选中的图片， 没选中的图片， 标题)
     */
    
    //分享的时候unSelectedImages字段没有用
    static func handleShareInstalled(type: YGShareType) -> (images: [UIImage], unSelectedImages: [UIImage], titles: [String]) {
        var images = [UIImage]()
        var unSelectedImages = [UIImage]()
        var titles = [String]()
        if YGWXApi.isWXAppInstalled() && YGQQApi.isQQAppInstalled() {
            images.append(UIImage(named: kSelectedTimeline)!)
            images.append(UIImage(named: kSelectedWechat)!)
            images.append(UIImage(named: kSelectedSina)!)
            images.append(UIImage(named: kSelectedQzone)!)
            images.append(UIImage(named: kSelectedQQ)!)
            
            unSelectedImages.append(UIImage(named: kUnSelectedTimeline)!)
            unSelectedImages.append(UIImage(named: kUnSelectedWechat)!)
            unSelectedImages.append(UIImage(named: kUnSelectedSina)!)
            unSelectedImages.append(UIImage(named: kUnSelectedQzone)!)
            unSelectedImages.append(UIImage(named: kUnSelectedQQ)!)

            titles.append(kTitleTimeline)
            titles.append(kTitleWechat)
            titles.append(kTitleSina)
            titles.append(kTitleQzone)
            titles.append(kTitleQQ)
            
        } else if YGWXApi.isWXAppInstalled() && !YGQQApi.isQQAppInstalled() {
            images.append(UIImage(named: kSelectedTimeline)!)
            images.append(UIImage(named: kSelectedWechat)!)
            images.append(UIImage(named: kSelectedSina)!)
            
            unSelectedImages.append(UIImage(named: kUnSelectedTimeline)!)
            unSelectedImages.append(UIImage(named: kUnSelectedWechat)!)
            unSelectedImages.append(UIImage(named: kUnSelectedSina)!)
            
            titles.append(kTitleTimeline)
            titles.append(kTitleWechat)
            titles.append(kTitleSina)
            
        } else if !YGWXApi.isWXAppInstalled() && YGQQApi.isQQAppInstalled() {
            images.append(UIImage(named: kSelectedSina)!)
            images.append(UIImage(named: kSelectedQzone)!)
            images.append(UIImage(named: kSelectedQQ)!)
            
            unSelectedImages.append(UIImage(named: kUnSelectedSina)!)
            unSelectedImages.append(UIImage(named: kUnSelectedQzone)!)
            unSelectedImages.append(UIImage(named: kUnSelectedQQ)!)
            
            titles.append(kTitleSina)
            titles.append(kTitleQzone)
            titles.append(kTitleQQ)
        } else {
            images.append(UIImage(named: kSelectedSina)!)
            unSelectedImages.append(UIImage(named: kUnSelectedSina)!)
            titles.append(kTitleSina)
        }
        
        switch type {
        case .DYVisitor:
            images.append(UIImage(named: kReportImg)!)
            unSelectedImages.append(UIImage(named: kReportImg)!)
            titles.append(kReport)
        case .DYHost:
            images.append(UIImage(named: kDeleteImg)!)
            unSelectedImages.append(UIImage(named: kDeleteImg)!)
            titles.append(kDelete)
        case .CCVisitor:
            images.append(UIImage(named: kReportImg)!)
            unSelectedImages.append(UIImage(named: kReportImg)!)
            titles.append(kReport)
            images.append(UIImage(named: kHomeImg)!)
            unSelectedImages.append(UIImage(named: kHomeImg)!)
            titles.append(kHome)
        case .CCHost: 
            images.append(UIImage(named: kEditImg)!)
            unSelectedImages.append(UIImage(named: kEditImg)!)
            titles.append(kEdit)
            images.append(UIImage(named: kHomeImg)!)
            unSelectedImages.append(UIImage(named: kHomeImg)!)
            titles.append(kHome)
        }
        
        return (images, unSelectedImages, titles)
    }
}

// 判断用户安装木有qq
class YGQQApi {
    class func isQQAppInstalled() -> Bool {
        if UIApplication.sharedApplication().canOpenURL(NSURL(string: "mqq://")!) {
            return true
        } else {
            LogWarn("QQapp 安装返回失败")
            return false
        }
    }
}

class YGWXApi {
    class func isWXAppInstalled() -> Bool {
        if UIApplication.sharedApplication().canOpenURL(NSURL(string: "weixin://")!) {
            return true
        } else {
            LogWarn("微信app 安装返回失败")
            return false
        }
    }
}