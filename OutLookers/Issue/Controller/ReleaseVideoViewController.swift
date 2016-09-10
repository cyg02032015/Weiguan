//
//  ReleaseVideoViewController.swift
//  OutLookers
//
//  Created by C on 16/6/22.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import MobileCoreServices
import MediaPlayer
import AliyunOSSiOS

private let videoCoverIdentifier = "videoCoverId"
private let editTextViewIdentifier = "editTextViewId"
private let shareCellIdentifier = "shareCellId"
private let issueTalentListId = "issueTalentListId"

enum TokenType: String {
    case Picture = "1"
    case Video = "2"
}

private extension Selector {
    static let tapReleaseButton = #selector(ReleaseVideoViewController.tapReleaseButton(_:))
}

class ReleaseVideoViewController: YGBaseViewController {
    
    var tableView: UITableView!
    var videoUrl: NSURL!
    lazy var shareTuple = ([UIImage](), [UIImage](), [String]())
    var releaseButton: UIButton!
    lazy var req = ReleasePicAndVideoReq()
    var coverImage: UIImage!
    var videoToken: GetToken!
    var picToken: GetToken!
    lazy var talentLists = [TalentResult]()
    var contentHeight: CGFloat!
    var isReload = false
    
    private var uploadVideoRequst: OSSPutObjectRequest?
    
    private var timeStr: String!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "发布视频"
        getToken()
        loadData()
        self.shareTuple = YGShareHandler.handleShareInstalled(.Video)
        setupSubViews()
    }
    
    func setupSubViews() {
        
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.backgroundColor = kBackgoundColor
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .None
        tableView.registerClass(VideoCoverCell.self, forCellReuseIdentifier: videoCoverIdentifier)
        tableView.registerClass(EditTextViewCell.self, forCellReuseIdentifier: editTextViewIdentifier)
        tableView.registerClass(ShareCell.self, forCellReuseIdentifier: shareCellIdentifier)
        tableView.registerClass(IssueTalenListCell.self, forCellReuseIdentifier: issueTalentListId)
        
        releaseButton = Util.createReleaseButton("发布")
        releaseButton.addTarget(self, action: .tapReleaseButton, forControlEvents: .TouchUpInside)
        view.addSubview(releaseButton)
        
        releaseButton.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(releaseButton.superview!)
            make.height.equalTo(kScale(50))
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(tableView.superview!)
            make.bottom.equalTo(releaseButton.snp.top)
        }
    }
    
    func loadData() {
        timeStr = NSDate().stringFromNowDate()
        Server.talentList(pageNo, state: 2, timeStr: self.timeStr) { (success, msg, value) in
            if success {
                guard let obj = value else {return}
                self.talentLists.appendContentsOf(obj.list)
                self.tableView.reloadData()
            } else {
                guard let m = msg else {return}
                SVToast.showWithError(m)
            }
        }
    }
    
    func getToken() {
        Server.getUpdateFileToken(.Video) { (success, msg, value) in
            guard let object = value else {
                LogError("获取token失败")
                return
            }
            self.videoToken = object
        }
        Server.getUpdateFileToken(.Picture) { (success, msg, value) in
            guard let object = value else {
                LogError("获取token失败")
                return
            }
            self.picToken = object
        }
    }
    
    func selectVideo() {
        if UIImagePickerController.isAvailablePhotoLibrary() {
            let controller = UIImagePickerController()
            controller.sourceType = .PhotoLibrary
            var mediaTypes = [String]()
            mediaTypes.append(kUTTypeMovie as String)
            controller.mediaTypes = mediaTypes
            controller.delegate = self
            presentViewController(controller, animated: true, completion: {})
        }
    }
    
    // MARK: 返回
    override func backButtonPressed(sender: UIButton) {
        let alert = UIAlertController(title: nil, message: "确认放弃发布视频吗?", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "确定", style: .Default, handler: { [weak self](action) in
            self?.dismissViewControllerAnimated(true) {
                self?.uploadVideoRequst?.cancel()
            }
            }))
        alert.addAction(UIAlertAction(title: "点错了", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ReleaseVideoViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 2
        case 1: return 1
        case 2: return 1
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier(videoCoverIdentifier, forIndexPath: indexPath) as! VideoCoverCell
                cell.delegate = self
                return cell
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier(editTextViewIdentifier, forIndexPath: indexPath) as! EditTextViewCell
                cell.delegate = self
                return cell
            }
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier(issueTalentListId, forIndexPath: indexPath) as! IssueTalenListCell
            cell.info = self.talentLists
            if isReload == false {
                cell.heightBlock = { [weak self, weak cell] height in
                    guard let weakSelf = self else {return}
                    weakSelf.contentHeight = height
                    tableView.reloadData()
                    weakSelf.isReload = true
                    cell?.heightBlock = nil
                }
            }
            
            cell.categoryIdsBlock = { [weak self] ids in
                guard let weakSelf = self else {return}
                weakSelf.req.talent = ids
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(shareCellIdentifier, forIndexPath: indexPath) as! ShareCell
            cell.tuple = shareTuple
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return indexPath.row == 0 ? kHeight(121) : kHeight(72)
        case 1:
            if contentHeight != nil {
                return contentHeight
            } else {
                return kScale(90)
            }
        case 2: return kHeight(81)
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 2 {
            return 0.01
        } else {
            return kHeight(10)
        }
    }
}

// MARK: - 按钮点击&响应
extension ReleaseVideoViewController: VideoCoverCellDelegate, ShareCellDelegate, EditTextViewCellDelegate {
    
    func checkParamers() {
        req.isVideo = "2"
        if videoUrl != nil {
            releaseButton.backgroundColor = kCommonColor
            releaseButton.userInteractionEnabled = true
        } else {
            releaseButton.backgroundColor = kGrayColor
            releaseButton.userInteractionEnabled = false
        }
    }
    
    func textViewCellReturnText(text: String) {
        req.text = text
    }
    
    func tapReleaseButton(sender: UIButton) {
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        let group = dispatch_group_create()
        SVToast.show("正在上传视频")
        dispatch_group_async(group, queue) { [weak self] in
            dispatch_group_enter(group)
           self?.uploadVideoRequst = OSSVideoUploader.asyncUploadVideo(self!.videoToken, videoURL: self!.videoUrl) { (id, state) in
                dispatch_group_leave(group)
                if state == .Success {
                    self?.req.picture = id
                } else {
                    SVToast.dismiss()
                    SVToast.showWithError("上传视频失败")
                }
            }
        }
        dispatch_group_async(group, queue) { [weak self] in
            dispatch_group_enter(group)
            OSSImageUploader.asyncUploadImage(self!.picToken, image: self!.coverImage, complete: { (names, state) in
                dispatch_group_leave(group)
                if state == .Success {
                    self?.req.cover = names[0]
                } else {
                    SVToast.dismiss()
                    SVToast.showWithError("上传封面失败")
                }
            })
        }
        dispatch_group_notify(group, queue) { [weak self] in
            if isEmptyString(self!.req.cover) || isEmptyString(self!.req.picture) {
                return
            }
            Server.releasePicAndVideo(self!.req, handler: { (success, msg, value) in
                SVToast.dismiss()
                if success {
                    SVToast.showWithSuccess("上传视频成功")
                    delay(1, task: {
                        self?.dismissViewControllerAnimated(true, completion: {
                        })
                    })
                } else {
                    SVToast.showWithError(msg!)
                }
            })
        }
}
    
    func videoCoverImageViewTap() {
        if videoUrl == nil {
            selectVideo()
        } else {
            let vc = SettingCoverController()
            vc.videoUrl = videoUrl
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func shareCellReturnsShareTitle(text: String) {
        LogInfo("分享 \(text)")
    }
}

extension ReleaseVideoViewController: SettingCoverControllerDelegate {
    func settingCoverSendCover(image: UIImage) {
        coverImage = image
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! VideoCoverCell
        cell.imgView.image = image
    }
}

extension ReleaseVideoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! VideoCoverCell
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        if mediaType == kUTTypeMovie as String {
            LogInfo(info[UIImagePickerControllerMediaType])
            guard let url = info[UIImagePickerControllerMediaURL] as? NSURL else { fatalError("获取视频 URL 失败")}
            videoUrl = url
            coverImage = VideoTool.getThumbleImage(url)
            cell.imgView.image = coverImage
            if videoUrl != nil && coverImage != nil {
                cell.settingV.hidden = false
            }
            checkParamers()
            dismissViewControllerAnimated(true, completion: {})
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
