//
//  MPraiseViewController.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/21.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let mPraiseCellId = "mPraiseCellId"

class MPraiseViewController: YGBaseViewController {

    var likeListObj: LikeListResp?
    var num: Int?
    var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        getPraiseList()
        guard let _ = num else { return }
        guard num != 0 else { return } //本身为0就不必去发送请求
        releaseLike()
    }
    
    func setupSubViews() {
        title = "赞了"
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(MPraiseCell.self, forCellReuseIdentifier: mPraiseCellId)
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
    }
    
    func releaseLike() {
        HttpTool.post(API.releaseLikeRead, parameters: ["userId" : UserSingleton.sharedInstance.userId], complete: { (response) in
            if response["success"].boolValue {
                NSNotificationCenter.defaultCenter().postNotificationName(kMessageLikeReleaseReadNotification, object: nil)
            }
            }) { (error) in
                SVToast.showWithError(error.localizedDescription)
        }
    }
    
    func getPraiseList() {
        SVToast.show()
        Server.likeList(1, dynamicId: "0", handler: { (success, msg, value) in
            SVToast.dismiss()
            if success {
                guard let obj = value else {return}
                self.likeListObj = obj
                self.tableView.reloadData()
            } else {
                LogError("无法获取点赞列表")
            }
        })
    }
}

extension MPraiseViewController {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.likeListObj?.lists.count {
            return count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(mPraiseCellId, forIndexPath: indexPath) as! MPraiseCell
        let likeData = self.likeListObj?.lists[indexPath.row]
        cell.likeData = likeData
        cell.headImgView.iconHeaderTap { [weak self] in
            let vc = PHViewController()
            vc.user = "\(likeData!.userId)"
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        cell.imgView.tapImageAction { [weak self] in
            let vc = DynamicDetailViewController()
            let dynamic = DynamicResult()
            dynamic.id = likeData?.dynamicId
            dynamic.name = likeData?.nickname
            dynamic.photo = likeData?.headImgUrl
            dynamic.detailsType = likeData?.detailsType
//            dynamic.follow = likeData?.follow
            vc.dynamicObj = dynamic
            vc.shareImage = cell.imgView.image
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
    
    func touchCoverImage() {
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return kHeight(62)
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}