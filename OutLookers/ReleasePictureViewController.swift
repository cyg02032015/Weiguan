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

class ReleasePictureViewController: YGBaseViewController {

    var tableView: UITableView!
    lazy var shareTuple = ([UIImage](), [UIImage](), [String]())
    lazy var pictures = [UIImage]()
    lazy var photos = NSMutableArray()
    lazy var originPhotos = NSMutableArray()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "编辑才艺"
        pictures = [UIImage(named: "release_announcement_Add pictures")!]
        self.shareTuple = YGShareHandler.handleShareInstalled()
        setupSubViews()
    }
    
    func setupSubViews() {
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .None
        tableView.registerClass(PictureSelectCell.self, forCellReuseIdentifier: pictureSelectIdentifier)
        tableView.registerClass(EditTextViewCell.self, forCellReuseIdentifier: editTextViewIdentifier)
        
        tableView.registerClass(ShareCell.self, forCellReuseIdentifier: shareCellIdentifier)
        
        createNaviRightButton("发布")
        
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(tableView.superview!)
            make.top.equalTo(self.snp.topLayoutGuideBottom)
        }
    }

}

extension ReleasePictureViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 2
        case 1: return 1
        case 2: return 1
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
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
        case 0: return indexPath.row == 0 ? 293 : 72
        case 1: return 257
        case 2: return 81
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 2 {
            return 0
        } else {
            return 10
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
            cell.img = (photos[indexPath.item] as! UIImage)
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! PictureSelectCell
        if indexPath.item == photos.count {
            let actionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "拍照", "从相册中选取")
            actionSheet.showInView(view)
        } else {
//            let tz = TZImagePickerController(selectedAssets: originPhotos, selectedPhotos: photos, index: indexPath.item)
//            tz.didFinishPickingPhotosHandle = { [unowned self](photos, assets, isSelectedOrigin) in
//                self.originPhotos.setArray(assets)
//                self.photos.setArray(photos)
//                cell.collectionView.reloadData()
//                self.tableView.reloadData()
//            }
            let vc = YKPhotoPreviewController()
            vc.currentIndex = indexPath.item
            vc.photos = self.photos
            vc.originPhotos = self.originPhotos
            vc.didFinishPickingPhotos({ (photos, originPhotos) in
                self.originPhotos.setArray(originPhotos as [AnyObject])
                self.photos.setArray(photos as [AnyObject])
                cell.collectionView.reloadData()
                self.tableView.reloadData()
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
                tz.selectedAssets = originPhotos
                presentViewController(tz, animated: true, completion: nil)
            break
        default: LogWarn("switch default")
        }
    }
}

extension ReleasePictureViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, TZImagePickerControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let originalImg = info["UIImagePickerControllerOriginalImage"] as! UIImage
        picker.dismissViewControllerAnimated(true) {}
    }
        
    func imagePickerController(picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [AnyObject]!, isSelectOriginalPhoto: Bool) {
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! PictureSelectCell
        self.photos.setArray(photos)
        self.originPhotos.setArray(assets)
        cell.collectionView.reloadData()
        if self.photos.count/4 >= 1 {
            let range = NSMakeRange(0, 0)
            tableView.reloadSections(NSIndexSet(indexesInRange: range), withRowAnimation: .Automatic)
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true) { }//TODO
    }
}

// MARK: - 按钮点击&响应
extension ReleasePictureViewController: ShareCellDelegate {
    
    override func tapRightButton(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func shareCellReturnsShareTitle(text: String) {
        LogInfo("分享 \(text)")
    }
}
