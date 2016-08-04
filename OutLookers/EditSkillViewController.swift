//
//  EditSkillViewController.swift
//  OutLookers
//
//  Created by C on 16/6/21.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit
import MobileCoreServices

private let skillTypeCellId = "skillTypeCellId"
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

private extension Selector {
    static let tapReleaseButton = #selector(EditSkillViewController.tapReleaseButton(_:))
}

class EditSkillViewController: YGBaseViewController {

    var skillType: PersonCharaterModel!
    var tableView: UITableView!
    var releaseButton: UIButton!
    var pickerView: YGPickerView!
    lazy var recruits: [Recruit] = [Recruit]()
    lazy var provinceTitles = NSArray()
    lazy var skillUnitPickerArray = [String]()
    var isProvincePicker = false  // 区分PickerView数据源
    lazy var photoArray = [UIImage]()
    lazy var originPhotoArray = [AnyObject]()
    var photoType: PhotoSelectType!
    var setCoverButton: UIButton!
    var addVideoButton: UIButton!
    var isSelectPhotos: Bool = false // 是否选取多张
    lazy var req = ReleaseTalentReq()
    var coverImage: UIImage!
    lazy var cityResp = YGCityData.loadCityData()
    var provinceInt: Int = 0
    var tokenObject: GetToken!
    var videoURL: NSURL!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "编辑才艺"
        setupSubViews()
        getToken()
        provinceTitles = CitiesData.sharedInstance().provinceTitle()
        skillUnitPickerArray = ["元/小时", "元/场", "元/次", "元/半天", "元/天", "元/月", "元/年"]
        pickerView = YGPickerView(frame: CGRectZero, delegate: self)
        pickerView.delegate = self
        
        if skillType != nil {
            req.categoryId = "\(skillType.id)"
            req.categoryName = skillType.name
        }
        req.unit = UnitType.YuanHour.rawValue
        
    }
    
    func setupSubViews() {
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.backgroundColor = kBackgoundColor
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = kLineColor
        tableView.tableFooterView = UIView()
        tableView.registerClass(SkillTypeCell.self, forCellReuseIdentifier: skillTypeCellId)
        tableView.registerClass(NoArrowEditCell.self, forCellReuseIdentifier: noArrowIdentifier)
        tableView.registerClass(ArrowEditCell.self, forCellReuseIdentifier: arrowIdentifier)
        tableView.registerClass(WorkDetailCell.self, forCellReuseIdentifier: workDetailIdentifier)
        tableView.registerClass(SkillSetCell.self, forCellReuseIdentifier: skillSetIdentifier)
        tableView.registerClass(BudgetPriceCell.self, forCellReuseIdentifier: budgetCellIdentifier)
        
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
    
    func getToken() {
        Server.getUpdateFileToken(.Picture) { (success, msg, value) in
            guard let object = value else {
                LogError("获取token失败")
                return
            }
            self.tokenObject = object
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension EditSkillViewController {
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier(skillTypeCellId, forIndexPath: indexPath) as! SkillTypeCell
                cell.setTextInCell("才艺类型", placeholder: skillType.name)
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCellWithIdentifier(noArrowIdentifier, forIndexPath: indexPath) as! NoArrowEditCell
                cell.indexPath = indexPath
                cell.delegate = self
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
            cell.delegate = self
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
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 4
        case 1: return 1
        case 2: return 1
        default: return 1
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 1: return kHeight(193) // 才艺详情
        case 0: return kHeight(56)
        case 2: return kHeight(514 + (CGFloat(self.photoArray.count) / 5 * (ScreenWidth - 30 - 20) / 5) + 5)
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 5 {
            return 0
        }
        return kHeight(10)
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
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
            cell.img = photoArray[indexPath.item]
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
            let vc = YKPhotoPreviewController()
            vc.currentIndex = indexPath.item
            vc.photos = self.photoArray
            vc.originPhotos = self.originPhotoArray
            vc.didFinishPickingPhotos({ (photos, originPhotos) in
                self.originPhotoArray = originPhotos
                self.photoArray = photos
                cell.collectionView.reloadData()
                self.tableView.reloadData()
            })
            presentViewController(vc, animated: true, completion: nil)
        }
    }
}

extension EditSkillViewController: BudgetPriceCellDelegate, NoArrowEditCellDelegate, WorkDetailCellDelegate {
    
    func checkParameters() {
        LogDebug(req)
        guard !isEmptyString(req.name) && !isEmptyString(req.categoryId) && !isEmptyString(req.categoryName) && !isEmptyString(req.details) && !isEmptyString(req.unit) && !isEmptyString(req.price) else {
            releaseButton.backgroundColor = kGrayColor
            releaseButton.userInteractionEnabled = false
            return
        }
        releaseButton.backgroundColor = kCommonColor
        releaseButton.userInteractionEnabled = true
    }
    
    func tapReleaseButton(sender: UIButton) {
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        let group = dispatch_group_create()
        SVToast.show()
        // 上传作品集封面
        if coverImage != nil {
            dispatch_group_async(group, queue) { [unowned self] in
                dispatch_group_enter(group)
                OSSImageUploader.asyncUploadImage(self.tokenObject, image: self.coverImage, complete: { (names, state) in
                    dispatch_group_leave(group)
                    if state == .Success {
                        self.req.worksCover = names.first
                    } else {
                        self.req.worksCover = ""
                        SVToast.dismiss()
                        SVToast.showWithError("上传封面失败")
                    }
                })
            }
        }
        
        if videoURL != nil {
            dispatch_group_async(group, queue, { [unowned self] in
                dispatch_group_enter(group)
                OSSVideoUploader.asyncUploadVideo(self.tokenObject, videoURL: self.videoURL, complete: { (id, state) in
                    dispatch_group_leave(group)
                    if state == .Success {
                        self.req.worksVideo = id
                    } else {
                        SVToast.dismiss()
                        SVToast.showWithError("上传视频失败")
                    }
                })
            })
        }
        
        if self.photoArray.count > 0 {
            dispatch_group_async(group, queue) { [unowned self] in
                dispatch_group_enter(group)
                OSSImageUploader.asyncUploadImages(self.tokenObject, images: self.photoArray, complete: { (names, state) in
                    dispatch_group_leave(group)
                    if state == .Success {
                        self.req.worksPicture = names.joinWithSeparator(",")
                    } else {
                        SVToast.dismiss()
                        SVToast.showWithError("上传图片失败")
                    }
                })
            }
        }
        
        dispatch_group_notify(group, queue) { [unowned self] in
            Server.releaseTalent(self.req, handler: { (success, msg, value) in
                SVToast.dismiss()
                if success {
                    LogInfo(value!)
                    self.dismissViewControllerAnimated(true, completion: { [unowned self] in
                        self.photoArray.removeAll()
                        self.originPhotoArray.removeAll()
                        })
                } else {
                    guard let m = msg else {return}
                    SVToast.showWithError(m)
                }

            })
        }
    }
    
    func workDetailCellReturnText(text: String) {
        req.details = text
        checkParameters()
    }
    
    func noarrowCellReturnText(text: String?, tuple: (section: Int, row: Int)) {
        switch tuple {
        case (0,1): req.name = text
        default: ""
        }
        checkParameters()
    }
    
    func textFieldReturnText(text: String) {
        req.price = text
        checkParameters()
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
                tz.selectedAssets = NSMutableArray(array: originPhotoArray)
                presentViewController(tz, animated: true, completion: nil)
            } else {
                if UIImagePickerController.isAvailablePhotoLibrary() {
                    let controller = UIImagePickerController()
                    controller.sourceType = .PhotoLibrary
                    var mediaTypes = [String]()
                    mediaTypes.append(kUTTypeImage as String)
                    controller.mediaTypes = mediaTypes
                    controller.delegate = self
                    controller.allowsEditing = true
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
        if photoType == .Some(.AddVideo) {
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 2)) as! SkillSetCell
            let mediaType = info[UIImagePickerControllerMediaType] as! String
            if mediaType == kUTTypeMovie as String {
                guard let url = info[UIImagePickerControllerMediaURL] as? NSURL else { fatalError("获取视频 URL 失败")}
                videoURL = url
                let img = VideoTool.getThumbleImage(url)
                cell.videoButton.setImage(img, forState: .Normal)
                dismissViewControllerAnimated(true, completion: {})
            }
        } else {
            let originalImg = info["UIImagePickerControllerEditedImage"] as! UIImage
            originalImg.resetSizeOfImageData(originalImg, maxSize: 300, compeleted: { [weak self](data) in
                guard let s = self else { return }
                s.coverImage = UIImage(data: data)
                s.setCoverButton.setImage(s.coverImage, forState: .Normal)
                s.dismissViewControllerAnimated(true) { }
                })
        }
    }
    func imagePickerController(picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [AnyObject]!, isSelectOriginalPhoto: Bool) {
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 2)) as! SkillSetCell
        self.photoArray = photos
        self.originPhotoArray = assets
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

extension EditSkillViewController: YGPickerViewDelegate {
    func pickerViewSelectedSure(sender: UIButton, pickerView: UIPickerView) {
        if isProvincePicker {
            let city = pickerView.delegate!.pickerView!(pickerView, titleForRow: pickerView.selectedRowInComponent(1), forComponent: 1)
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 3, inSection: 0)) as! ArrowEditCell
            cell.tf.text = city
            req.city = "\(cityResp.province[provinceInt].citys[pickerView.selectedRowInComponent(1)].id)"
        } else {
            let skillUnit = pickerView.delegate!.pickerView!(pickerView, titleForRow: pickerView.selectedRowInComponent(0), forComponent: 0)
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0)) as! BudgetPriceCell
            cell.button.selected = true
            guard let unit = skillUnit else { fatalError("picker skill unit nil") }
            cell.setButtonText(unit)
            switch unit {
            case "元/小时": req.unit = UnitType.YuanHour.rawValue
            case "元/场": req.unit = UnitType.YuanRound.rawValue
            case "元/次": req.unit = UnitType.YuanOnce.rawValue
            case "元/半天": req.unit = UnitType.YuanHalfday.rawValue
            case "元/月": req.unit = UnitType.YuanMonth.rawValue
            case "元/年": req.unit = UnitType.YuanYear.rawValue
            default: ""
            }
        }
        checkParameters()
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
                return cityResp.province.count
            } else {
                let province = cityResp.province[pickerView.selectedRowInComponent(0)]
                return province.citys.count
            }
        } else {
            return skillUnitPickerArray.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if isProvincePicker {
            if component == 0 {
                return cityResp.province[row].name
            } else {
                let province = cityResp.province[pickerView.selectedRowInComponent(0)]
                return province.citys[row].name
            }
        } else {
            return skillUnitPickerArray[row]
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if isProvincePicker {
            if component == 0 {
                provinceInt = row
                pickerView.reloadComponent(1)
            }
        }
    }
}
