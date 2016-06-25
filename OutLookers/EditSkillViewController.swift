//
//  EditSkillViewController.swift
//  OutLookers
//
//  Created by C on 16/6/21.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import MobileCoreServices

private let noArrowIdentifier = "noArrowId"
private let arrowIdentifier = "arrowId"
private let workDetailIdentifier = "workDetailId"
private let skillSetIdentifier = "skillSetId"
private let budgetCellIdentifier = "budgetCellId"

enum PhotoSelectType: String {
    case SetCover = "SetCover"
    case AddVideo = "AddVideo"
    case AddPictrue = "AddPicture"
}

class EditSkillViewController: YGBaseViewController {

    var tableView: UITableView!
    var releaseButton: UIButton!
    var pickerView: YGPickerView!
    lazy var recruits: [Recruit] = [Recruit]()
    lazy var provinceTitles = NSArray()
    lazy var skillUnitPickerArray = [String]()
    var isProvincePicker = false  // 区分PickerView数据源
    lazy var photoArray = NSMutableArray()
    lazy var originPhotoArray = NSMutableArray()
    var photoType: PhotoSelectType!
    var setCoverButton: UIButton!
    var addVideoButton: UIButton!
    var isSelectPhotos: Bool = false // 是否选取多张
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        provinceTitles = CitiesData.sharedInstance().provinceTitle()
        skillUnitPickerArray = ["元/小时", "元/场", "元/次", "元/半天"]
        pickerView = YGPickerView(frame: CGRectZero, delegate: self)
        pickerView.delegate = self
        UIApplication.sharedApplication().keyWindow!.addSubview(pickerView)
        pickerView.hidden = true
        pickerView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(pickerView.superview!)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        if pickerView != nil {
            pickerView.removeFromSuperview()
            pickerView = nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "编辑才艺"
        setupSubViews()
    }
    
    func setupSubViews() {
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.registerClass(NoArrowEditCell.self, forCellReuseIdentifier: noArrowIdentifier)
        tableView.registerClass(ArrowEditCell.self, forCellReuseIdentifier: arrowIdentifier)
        tableView.registerClass(WorkDetailCell.self, forCellReuseIdentifier: workDetailIdentifier)
        tableView.registerClass(SkillSetCell.self, forCellReuseIdentifier: skillSetIdentifier)
        tableView.registerClass(BudgetPriceCell.self, forCellReuseIdentifier: budgetCellIdentifier)
        
        createNaviRightButton("发布")
        
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(tableView.superview!)
            make.top.equalTo(self.snp.topLayoutGuideBottom)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension EditSkillViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier(noArrowIdentifier, forIndexPath: indexPath) as! NoArrowEditCell
                cell.textFieldEnable = false
                cell.setTextInCell("才艺类型", placeholder: "")
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCellWithIdentifier(noArrowIdentifier, forIndexPath: indexPath) as! NoArrowEditCell
                cell.setTextInCell("才艺名称", placeholder: "请输入才艺名称")
                return cell
            } else if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCellWithIdentifier(budgetCellIdentifier, forIndexPath: indexPath) as! BudgetPriceCell
                cell.delegate = self
                cell.setTextInCell("才艺标价", placeholder: "请输入才艺标价", buttonText: "元/小时")
                return cell
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier(arrowIdentifier, forIndexPath: indexPath) as! ArrowEditCell
                cell.setTextInCell("服务地区 (选填)", placeholder: "请选择所在地区")
                return cell
            }
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier(workDetailIdentifier, forIndexPath: indexPath) as! WorkDetailCell
            cell.setTextInCell("才艺详情", placeholder: "请输入与您才艺相关的介绍")
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(skillSetIdentifier, forIndexPath: indexPath) as! SkillSetCell
            cell.collectionViewSetDelegate(self, indexPath: indexPath)
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 3 {
                isProvincePicker = true
                pickerView.picker.reloadAllComponents()
                pickerView.animation()
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 4
        case 1: return 1
        case 2: return 1
        default: return 1
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 1: return 193 // 才艺详情
        case 0: return 56
        case 2: return 514 + (CGFloat(self.photoArray.count) / 5 * (ScreenWidth - 30 - 20) / 5) + 5
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 5 {
            return 0
        }
        return 10
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension EditSkillViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoArray.count + 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(photoCollectionIdentifier, forIndexPath: indexPath) as! PhotoCollectionCell
        if indexPath.item == photoArray.count {
            cell.img = UIImage(named: "release_announcement_Add pictures")!
        } else {
            cell.img = (photoArray[indexPath.item] as! UIImage)
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 2)) as! SkillSetCell
        photoType = .Some(.AddPictrue)
        if indexPath.item == photoArray.count {
            isSelectPhotos = true
            let actionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "拍照", "从相册中选取")
            actionSheet.showInView(view)
        } else {
            let tz = TZImagePickerController(selectedAssets: originPhotoArray, selectedPhotos: photoArray, index: indexPath.item)
            tz.didFinishPickingPhotosHandle = { [unowned self](photos, assets, isSelectedOrigin) in
                self.originPhotoArray.setArray(assets)
                self.photoArray.setArray(photos)
                cell.collectionView.reloadData()
                self.tableView.reloadData()
            }
            
            presentViewController(tz, animated: true, completion: nil)
        }
    }
}

extension EditSkillViewController: BudgetPriceCellDelegate {
    override func tapRightButton(sender: UIButton) {
        dismissViewControllerAnimated(true) { [unowned self] in
            self.photoArray.removeAllObjects()
        }
    }
    
    func budgetPriceButtonTap(sender: UIButton) {
        isProvincePicker = false
        pickerView.picker.reloadAllComponents()
        pickerView.animation()
    }
}

// MARK: - PhotoCollectionCellDelegate
extension EditSkillViewController: SkillSetCellDelegate {
    // 设置封面
    func skillSetTapSetCover(sender: UIButton) {
        isSelectPhotos = false
        photoType = .Some(.SetCover)
        setCoverButton = sender
        let actionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "拍照", "从相册中选取")
        actionSheet.showInView(view)
    }
    
    // 添加视频
    func skillSetTapAddVideo(sender: UIButton) {
        photoType = .Some(.AddVideo)
        addVideoButton = sender
    }
}

// MARK: - UIActionSheetDelegate
extension EditSkillViewController: UIActionSheetDelegate {
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
            if isSelectPhotos {
                let tz = TZImagePickerController(maxImagesCount: 9, delegate: self)
                tz.allowTakePicture = false
                tz.allowPickingVideo = false
                tz.selectedAssets = originPhotoArray
                presentViewController(tz, animated: true, completion: nil)
            } else {
                if UIImagePickerController.isAvailablePhotoLibrary() {
                    let controller = UIImagePickerController()
                    controller.sourceType = .PhotoLibrary
                    var mediaTypes = [String]()
                    mediaTypes.append(kUTTypeImage as String)
                    controller.mediaTypes = mediaTypes
                    controller.delegate = self
                    presentViewController(controller, animated: true, completion: {})
                }
            }
            
            break
        default: LogWarn("switch default")
        }
    }
}

// MARK: - UIImagePickerControllerDelegate
extension EditSkillViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate,TZImagePickerControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let originalImg = info["UIImagePickerControllerOriginalImage"] as! UIImage
        picker.dismissViewControllerAnimated(true) {
            let imgCropper = VPImageCropperViewController(image: originalImg, cropFrame: CGRect(x: 0, y: self.view.center.y - ScreenWidth/2, width: ScreenWidth, height: ScreenWidth), limitScaleRatio: 3)
            imgCropper.delegate = self
            self.presentViewController(imgCropper, animated: true, completion: {})
        }
    }
    func imagePickerController(picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [AnyObject]!, isSelectOriginalPhoto: Bool) {
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 2)) as! SkillSetCell
        self.photoArray.setArray(photos)
        self.originPhotoArray.setArray(assets)
        cell.collectionView.reloadData()
        if self.photoArray.count/5 >= 1 {
            let range = NSMakeRange(2, 0)
            tableView.reloadSections(NSIndexSet(indexesInRange: range), withRowAnimation: .Automatic)
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true) { }//TODO
    }
}

// MARK: - VPImageCropperDelegate
extension EditSkillViewController: VPImageCropperDelegate {
    func imageCropperDidCancel(cropperViewController: VPImageCropperViewController!) {
        dismissViewControllerAnimated(true) { }//TODO
    }
    
    func imageCropper(cropperViewController: VPImageCropperViewController!, didFinished editedImage: UIImage!) {
        if photoType == .Some(.SetCover) {
            editedImage.resetSizeOfImageData(editedImage, maxSize: 300, compeleted: { [weak self](data) in
                guard let s = self else { return }
                s.setCoverButton.setImage(UIImage(data: data)!, forState: .Normal)
                s.dismissViewControllerAnimated(true) { }
            })
        }
    }
}

extension EditSkillViewController: YGPickerViewDelegate {
    func pickerViewSelectedSure(sender: UIButton) {
        if isProvincePicker {
            let city = pickerView.picker.delegate!.pickerView!(pickerView!.picker!, titleForRow: pickerView.picker.selectedRowInComponent(1), forComponent: 1)
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 3, inSection: 0)) as! ArrowEditCell
            cell.tf.text = city
        } else {
            let skillUnit = pickerView.picker.delegate!.pickerView!(pickerView!.picker!, titleForRow: pickerView.picker.selectedRowInComponent(0), forComponent: 0)
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0)) as! BudgetPriceCell
            cell.button.selected = true
            cell.setButtonText(skillUnit!)
        }
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension EditSkillViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        if isProvincePicker {
            return 2
        } else {
            return 1
        }
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if isProvincePicker {
            if component == 0 {
                return provinceTitles.count
            } else {
                let province = provinceTitles[pickerView.selectedRowInComponent(0)]
                let cities = CitiesData.sharedInstance().citiesWithProvinceName(province as! String)
                return cities.count > 0 ? cities.count : 0
            }
        } else {
            return skillUnitPickerArray.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if isProvincePicker {
            if component == 0 {
                return (provinceTitles[row] as! String)
            } else {
                let province = provinceTitles[pickerView.selectedRowInComponent(0)]
                let cities = CitiesData.sharedInstance().citiesWithProvinceName(province as! String)
                return cities.count > row ? (cities[row] as! String) : ""
            }
        } else {
            return skillUnitPickerArray[row]
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if isProvincePicker {
            if component == 0 {
                pickerView.reloadComponent(1)
            }
        }
    }
}
