//
//  ReleasePictureViewController.swift
//  OutLookers
//
//  Created by C on 16/6/22.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import MobileCoreServices

private let pictureSelectIdentifier = "pictureSelectIdentifier"
private let editTextViewIdentifier = "editTextViewIdentifier"
private let shareCellIdentifier = "shareCellId"
private let issueTalentListId = "issueTalentListId"

private extension Selector {
    static let tapReleaseButton = #selector(ReleasePictureViewController.tapReleaseButton(_:))
}

class ReleasePictureViewController: YGBaseViewController {
    var tableView: UITableView!
    lazy var shareTuple = ([UIImage](), [UIImage](), [String]())
    lazy var photos = [UIImage]()
    lazy var originPhotos = [AnyObject]()
    var releaseButton: UIButton!
    lazy var req = ReleasePicAndVideoReq()
    var tokenObject: GetToken!
    lazy var imageData = [NSData]()
    lazy var talentLists = [TalentResult]()
    var contentHeight: CGFloat!
    var isReload = false
    
    private var timeStr: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "发布图片"
        self.shareTuple = YGShareHandler.handleShareInstalled(.DYVisitor)
        setupSubViews()
        getToken()
        loadData()
    }
    
    func setupSubViews() {
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.backgroundColor = kBackgoundColor
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .None
        tableView.registerClass(PictureSelectCell.self, forCellReuseIdentifier: pictureSelectIdentifier)
        tableView.registerClass(EditTextViewCell.self, forCellReuseIdentifier: editTextViewIdentifier)
        tableView.registerClass(IssueTalenListCell.self, forCellReuseIdentifier: issueTalentListId)
        tableView.registerClass(ShareCell.self, forCellReuseIdentifier: shareCellIdentifier)
        
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
        Server.getUpdateFileToken(.Picture) { (success, msg, value) in
            guard let object = value else {
                LogError("获取token失败")
                return
            }
            self.tokenObject = object
        }
    }
    
    // MARK: 返回
    override func backButtonPressed(sender: UIButton) {
        let alert = UIAlertController(title: nil, message: "确认放弃发布图片吗?", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "确定", style: .Default, handler: { [weak self](action) in
            self?.dismissViewControllerAnimated(true) {
                self?.photos.removeAll()
                self?.originPhotos.removeAll()
            }
        }))
        alert.addAction(UIAlertAction(title: "点错了", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}

extension ReleasePictureViewController {
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
                let cell = tableView.dequeueReusableCellWithIdentifier(pictureSelectIdentifier, forIndexPath: indexPath) as! PictureSelectCell
                cell.collectionViewSetDelegate(self, indexPath: indexPath)
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
        case 0: return indexPath.row == 0 ? kHeight(293) : kHeight(72)
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

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ReleasePictureViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count >= 9 ? photos.count : photos.count + 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(releasePictureCollectionCellIdentifier, forIndexPath: indexPath) as! PhotoCollectionCell
        if photos.count == indexPath.item {
            cell.img = UIImage(named: "release_picture_Add pictures")!
        } else {
            cell.img = photos[indexPath.item]
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! PictureSelectCell
        if indexPath.item == photos.count {
            let actionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "拍照", "从相册中选取")
            actionSheet.showInView(view)
        } else {
            let vc = YKPhotoPreviewController()
            vc.currentIndex = indexPath.item
            vc.photos = self.photos
            vc.originPhotos = self.originPhotos
            vc.didFinishPickingPhotos({ (photos, originPhotos) in
                self.originPhotos = originPhotos
                self.photos = photos
                cell.collectionView.reloadData()
                self.tableView.reloadData()
                self.checkParams()
            })
            presentViewController(vc, animated: true, completion: nil)
        }
    }
}

extension ReleasePictureViewController: UIActionSheetDelegate {
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        switch buttonIndex {
        case 1:// 拍照
            if UIImagePickerController.isAvailableCamera() && UIImagePickerController.isSupportTakingPhotos(){
                let controller = UIImagePickerController()
                controller.sourceType = .Camera
                if UIImagePickerController.isAvailableCameraDeviceFront() {
                    controller.cameraDevice = .Front
                }
                var mediaTypes = [String]()
                mediaTypes.append(kUTTypeImage as String)
                controller.mediaTypes = mediaTypes
                controller.delegate = self
                presentViewController(controller, animated: true, completion: {})
            }
            break
        case 2:// 相册
                let tz = TZImagePickerController(maxImagesCount: 9, delegate: self)
//                tz.photoWidth = ScreenWidth
                tz.allowTakePicture = false
                tz.allowPickingVideo = false
                tz.selectedAssets = NSMutableArray(array: originPhotos)
                presentViewController(tz, animated: true, completion: nil)
            break
        default: LogWarn("switch default")
        }
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate, TZImagePickerControllerDelegate
extension ReleasePictureViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, TZImagePickerControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        _ = info["UIImagePickerControllerOriginalImage"] as! UIImage
        picker.dismissViewControllerAnimated(true) {}
    }
        
    func imagePickerController(picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [AnyObject]!, isSelectOriginalPhoto: Bool) {
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! PictureSelectCell
        self.photos = photos
        self.imageData = photos.dataWithImages()
        self.originPhotos = assets
        cell.collectionView.reloadData()
        if self.photos.count/4 >= 1 {
            let range = NSMakeRange(0, 0)
            tableView.reloadSections(NSIndexSet(indexesInRange: range), withRowAnimation: .Automatic)
        }
        checkParams()
    }
    
    func tz_imagePickerControllerDidCancel(picker: TZImagePickerController!) {
//        dismissViewControllerAnimated(true) { }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true) { }//TODO
    }
}

// MARK: - 按钮点击&响应
extension ReleasePictureViewController: ShareCellDelegate, EditTextViewCellDelegate {
    
    func checkParams() {
        req.isVideo = "1"
        if self.photos.count > 0 {
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
        SVToast.show("正在上传图片")
        if self.photos.count > 0 {
            dispatch_group_async(group, queue) { [weak self] in
                dispatch_group_enter(group)
                OSSImageUploader.asyncUploadImageData(self!.tokenObject, data: self!.imageData[0], complete: { (names, state) in
                    if state == .Success {
                        LogInfo("图片们上传完成")
                        self?.req.cover = names.first
                        dispatch_group_leave(group)
                    } else {
                        SVToast.dismiss()
                        SVToast.showWithError("上传封面失败")
                        dispatch_group_leave(group)
                    }
                })
            }
            
            dispatch_group_async(group, queue) { [weak self] in
                dispatch_group_enter(group)
                OSSImageUploader.uploadImageDatas(self!.tokenObject, datas: self!.imageData, isAsync: true, complete: { (names, state) in
                        if state == .Success {
                            LogWarn("pictures = \(names.joinWithSeparator(","))")
                            LogInfo("图片们上传完成")
                            self?.req.picture = names.joinWithSeparator(",")
                            dispatch_group_leave(group)
                        } else {
                            self?.req.picture = ""
                            SVToast.dismiss()
                            SVToast.showWithError("上传图片失败")
                            dispatch_group_leave(group)
                        }
                })
            }
        }
        
        
        dispatch_group_notify(group, queue) { [weak self] in
            if isEmptyString(self!.req.picture) && isEmptyString(self!.req.cover) {
                SVToast.showWithError("图片或者封面id为空")
                return
            }
            LogInfo("")
            LogInfo("picture = \(self!.req.picture)")
            Server.releasePicAndVideo(self!.req, handler: { (success, msg, value) in
                SVToast.dismiss()
                if success {
                    self?.dismissViewControllerAnimated(true, completion: {
                        self?.photos.removeAll()
                        self?.originPhotos.removeAll()
                        })
                } else {
                    guard let m = msg else {return}
                    SVToast.showWithError(m)
                }
            })
        }
    }
    
    func shareCellReturnsShareTitle(text: String) {
        LogInfo("分享 \(text)")
    }
}
