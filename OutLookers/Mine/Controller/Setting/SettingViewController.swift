//
//  SettingViewController.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/26.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let arrowEidtCellId = "arrowEidtCellId"
private let noarrowEdictCellId = "noarrowEdictCellId"
private let logButtonCellId = "logButtonCellId"

class SettingViewController: YGBaseViewController {
    var titles = ["我的账号", "通知设置", "关于纯氧", "清除缓存"]
    var tableView: UITableView!
    
    // 计算缓存大小
    private var cacheSize: String{
        get{
            let basePath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).first
            let fileManager = NSFileManager.defaultManager()
            func caculateCache() -> Float{
                var total: Float = 0
                if fileManager.fileExistsAtPath(basePath!){
                    let childrenPath = fileManager.subpathsAtPath(basePath!)
                    if childrenPath != nil{
                        for path in childrenPath!{
                            let childPath = basePath!.stringByAppendingString("/").stringByAppendingString(path)
                            do{
                                let attr = try fileManager.attributesOfItemAtPath(childPath)
                                let fileSize = attr["NSFileSize"] as! Float
                                total += fileSize
                            }catch _{
                                
                            }
                        }
                    }
                }
                return total
            }
            let totalCache = caculateCache()
            return NSString(format: "%.2f MB", totalCache / 1024.0 / 1024.0 ) as String
        }
    }
    
    // 清除缓存
    private func clearCache() -> Bool{
        var result = true
        let basePath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).first
        let fileManager = NSFileManager.defaultManager()
        if fileManager.fileExistsAtPath(basePath!){
            let childrenPath = fileManager.subpathsAtPath(basePath!)
            for childPath in childrenPath!{
                let cachePath = basePath?.stringByAppendingString("/").stringByAppendingString(childPath)
                do{
                    try fileManager.removeItemAtPath(cachePath!)
                }catch {
                    if cacheSize == "0.00 MB" {
                        return true
                    }
                    result = false
                }
            }
        }
        return result
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }
    
    func setupSubViews() {
        title = "设置"
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = kBackgoundColor
        tableView.registerClass(ArrowEditCell.self, forCellReuseIdentifier: arrowEidtCellId)
        tableView.registerClass(NoArrowEditCell.self, forCellReuseIdentifier: noarrowEdictCellId)
        tableView.registerClass(LogButtonCell.self, forCellReuseIdentifier: logButtonCellId)
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
    }
}

extension SettingViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2 {
            let cell = tableView.dequeueReusableCellWithIdentifier(arrowEidtCellId, forIndexPath: indexPath) as! ArrowEditCell
            cell.setTextInCell(titles[indexPath.section], placeholder: "")
            cell.label.font = UIFont.customFontOfSize(14)
            return cell
        } else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCellWithIdentifier(noarrowEdictCellId, forIndexPath: indexPath) as! NoArrowEditCell
            cell.setTextInCell(titles[indexPath.section], placeholder: "")
            cell.label.font = UIFont.customFontOfSize(14)
            cell.textFieldEnable = false
            cell.tf.text = cacheSize
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(logButtonCellId, forIndexPath: indexPath) as! LogButtonCell
            if UserSingleton.sharedInstance.isLogin() {
                cell.label.text = "退出登录"
            } else {
                cell.label.text = "立即登录"
            }
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            if UserSingleton.sharedInstance.isLogin() {
                let vc = AccountViewController()
                navigationController?.pushViewController(vc, animated: true)
            } else {
                let logView = YGLogView()
                logView.animation()
                logView.tapLogViewClosure({ (type) in
                    LogInHelper.logViewTap(self, type: type)
                })
            }
            
        case 1: ""
        case 2:
            let vc = AboutViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 3:
            self.showAlertController("确定清除缓存？", message: "", defults: ["确定"], handler: { (index, alertAction) in
                SVToast.show("正在清理缓存")
                let cell = tableView.cellForRowAtIndexPath(indexPath) as! NoArrowEditCell
                if self.clearCache() {
                    SVToast.showWithSuccess("缓存已清除")
                    delay(0.9, task: {
                        cell.tf.text = "0 MB"
                    })
                }else {
                    SVToast.showWithError("缓存清除失败")
                }
            })
        case 4:
            if UserSingleton.sharedInstance.isLogin() {
                LogInHelper.logout()
                NSNotificationCenter.defaultCenter().postNotificationName(ReloadData, object: nil)
            } else {
                let logView = YGLogView()
                logView.animation()
                logView.tapLogViewClosure({ (type) in
                    LogInHelper.logViewTap(self, type: type)
                })
            }
            tableView.reloadData()
        default:""
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return kHeight(50)
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kHeight(10)
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}