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

private extension Selector {
    static let tapReleaseButton = #selector(ReleasePictureViewController.tapReleaseButton(_:))
}

class ReleasePictureViewController: YGBaseViewController {

    var tableView: UITableView!
    lazy var shareTuple = ([UIImage](), [UIImage](), [String]())
    lazy var pictures = [UIImage]()
    lazy var photos = [UIImage]()
    lazy var originPhotos = [AnyObject]()
    var releaseButton: UIButton!
    lazy var req = ReleasePicAndVideoReq()
    var tokenObject: GetToken!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "编辑才艺"
        pictures = [UIImage(named: "release_announcement_Add pictures")!]
        self.shareTuple = YGShareHandler.handleShareInstalled()
        setupSubViews()
        
        Server.getUpdateFileToken { (success, msg, value) in
            
        }
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
                return cell
            }
        } else if indexPath.section == 1 {
            return UITableViewCell()
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
        case 1: return kHeight(257)
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
        return photos.count + 1
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
        self.originPhotos = assets
        cell.collectionView.reloadData()
        if self.photos.count/4 >= 1 {
            let range = NSMakeRange(0, 0)
            tableView.reloadSections(NSIndexSet(indexesInRange: range), withRowAnimation: .Automatic)
        }
        checkParams()
    }
    
    func tz_imagePickerControllerDidCancel(picker: TZImagePickerController!) {
        dismissViewControllerAnimated(true) { }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true) { }//TODO
    }
}

// MARK: - 按钮点击&响应
extension ReleasePictureViewController: ShareCellDelegate {
    
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
    
    func tapReleaseButton(sender: UIButton) {

        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        let group = dispatch_group_create()
        
        dispatch_group_async(group, queue) { [unowned self] in
            LogWarn("group cover")
            dispatch_group_enter(group)
            OSSImageUploader.asyncUploadImage(self.photos[0]) { (names, state) in
                if state == .Success {
                    self.req.cover = names.first ?? ""
                    dispatch_group_leave(group)
                } else {
                    LogError("上传封面失败")
                }
            }
        }
        dispatch_group_async(group, queue) { [unowned self] in
            LogWarn("group images")
            dispatch_group_enter(group)
            OSSImageUploader.asyncUploadImages(self.photos) { (names, state) in
                if state == .Success {
                    self.req.picture = names.joinWithSeparator(",")
                    dispatch_group_leave(group)
                } else {
                    LogError("上传图片门失败")
                }
            }
        }
        dispatch_group_notify(group, queue) { 
            LogWarn("group notify")
            Server.releasePicAndVideo(self.req, handler: { (success, msg, value) in
                if success {
                    LogInfo(value!)
                } else {
                    LogError("提交失败 = \(msg)")
                }
            })
        }
        
        dismissViewControllerAnimated(true, completion: { [unowned self] in
            self.photos.removeAll()
            self.pictures.removeAll()
            self.originPhotos.removeAll()
        })
    }
    
    func shareCellReturnsShareTitle(text: String) {
        LogInfo("分享 \(text)")
    }
}
