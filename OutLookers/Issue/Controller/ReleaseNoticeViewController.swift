//
//  ReleaseNoticeViewController.swift
//  OutLookers
//
//  Created by C on 16/6/18.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//  发布通告

import UIKit
import MobileCoreServices

private let noArrowIdentifier = "noArrowId"
private let arrowIdentifier = "arrowId"
private let recruiteIdentifier = "recruiteId"
private let workDetailIdentifier = "workDetailId"
private let selectImgIdentifier = "selectImgId"

private extension Selector {
    static let tapReleaseButton = #selector(ReleaseNoticeViewController.tapReleaseButton(_:))
}

class ReleaseNoticeViewController: YGBaseViewController {
    
    var tableView: UITableView!
    var selectDatePicker: YGSelectDateView!
    var pickerView: YGPickerView!
    lazy var recruits: [Recruit] = [Recruit]()
    lazy var provinceTitles = NSArray()
    lazy var photoArray = [UIImage]()
    var req = ReleaseNoticeRequest()
    var releaseButton: UIButton!
    lazy var cityResp: CityResp = YGCityData.loadCityData()
    var tokenObject: GetToken!
    var provinceInt: Int = 0
    var index: Int = -1 //给个标记
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "发布邀约"
        setupSubViews()
        getToken()
        selectDatePicker = YGSelectDateView()
        selectDatePicker.minimumDate = NSDate()
        pickerView = YGPickerView(frame: CGRectZero, delegate: self)
        pickerView.delegate = self
    }
    
    func setupSubViews() {
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.backgroundColor = kBackgoundColor
        tableView.separatorStyle = .None
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = kLineColor
        tableView.tableFooterView = UIView()
        tableView.registerClass(NoArrowEditCell.self, forCellReuseIdentifier: noArrowIdentifier)
        tableView.registerClass(ArrowEditCell.self, forCellReuseIdentifier: arrowIdentifier)
        tableView.registerClass(RecruitNeedsCell.self, forCellReuseIdentifier: recruiteIdentifier)
        tableView.registerClass(WorkDetailCell.self, forCellReuseIdentifier: workDetailIdentifier)
        tableView.registerClass(SelectPhotoCell.self, forCellReuseIdentifier: selectImgIdentifier)
        
        releaseButton = Util.createReleaseButton("发布")
        releaseButton.addTarget(self, action: .tapReleaseButton, forControlEvents: .TouchUpInside)
        view.addSubview(releaseButton)
        releaseButton.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(releaseButton.superview!)
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
extension ReleaseNoticeViewController {
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(noArrowIdentifier, forIndexPath: indexPath) as! NoArrowEditCell
            cell.delegate = self
            cell.indexPath = indexPath
            cell.setTextInCell("工作主题", placeholder: "请输入工作主题")
            return cell
        } else if indexPath.section == 1 { // 招募需求
            let cell = tableView.dequeueReusableCellWithIdentifier(recruiteIdentifier, forIndexPath: indexPath) as! RecruitNeedsCell
            cell.addRecuitNeedsButton(recruits)
            cell.delegate = self
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCellWithIdentifier(arrowIdentifier, forIndexPath: indexPath) as! ArrowEditCell
            cell.setTextInCell(indexPath.row == 0 ? "工作开始时间" : "工作结束时间", placeholder: indexPath.row == 0 ? "请选择开始时间" : "请选择结束时间")
            return cell
        } else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCellWithIdentifier(arrowIdentifier, forIndexPath: indexPath) as! ArrowEditCell
            cell.setTextInCell("报名截止时间", placeholder: "请选择截止时间")
            return cell
        } else if indexPath.section == 4 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier(arrowIdentifier, forIndexPath: indexPath) as! ArrowEditCell
                cell.setTextInCell("工作地点", placeholder: "选择城市")
                return cell
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier(noArrowIdentifier, forIndexPath: indexPath) as! NoArrowEditCell
                cell.delegate = self
                cell.indexPath = indexPath
                cell.setTextInCell("", placeholder: "指定详细地址 (选填)")
                return cell
            }
        } else if indexPath.section == 5 {
            let cell = tableView.dequeueReusableCellWithIdentifier(workDetailIdentifier, forIndexPath: indexPath) as! WorkDetailCell
            cell.setTextInCell("工作详情", placeholder: "请输入工作内容")
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(selectImgIdentifier, forIndexPath: indexPath) as! SelectPhotoCell
            cell.collectionViewSetDelegate(self, indexPath: indexPath)
            
            return cell
        }
    }
    // MARK: 工作时间request
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 2 {
            if indexPath.row == 0 { // 工作开始时间
                let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 2)) as! ArrowEditCell
                selectDatePicker.animation()
                selectDatePicker.tapSureClosure({ [unowned self](date) in
                    cell.tf.text = date.stringFromDate()
                    self.req.startTime = date.stringFromDateWith("yyyy-MM-dd")
                    self.checkParameters()
                    })
                
            } else { // 工作结束时间
                let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 2)) as! ArrowEditCell
                selectDatePicker.animation()
                selectDatePicker.tapSureClosure({ [unowned self](date) in
                    cell.tf.text = date.stringFromDate()
                    self.req.endTime = date.stringFromDateWith("yyyy-MM-dd")
                    self.checkParameters()
                })
            }
        }
        
        if indexPath.section == 3 { // 报名截止日期
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 3)) as! ArrowEditCell
            selectDatePicker.animation()
            selectDatePicker.tapSureClosure({ [unowned self](date) in
                cell.tf.text = date.stringFromDate()
                self.req.register = date.stringFromDateWith("yyyy-MM-dd")
                self.checkParameters()
            })
        }
        
        if indexPath.section == 4 && indexPath.row == 0 {
            pickerView.animation()
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 1: return 1
        case 2: return 2
        case 3: return 1
        case 4: return 2
        case 5, 6: return 1
        default: return 1
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 1: return kHeight(90 + CGFloat(recruits.count * 38)) // 招募需求
        case 0, 2, 3, 4: return kHeight(56)
        case 5: return kHeight(155) // 工作详情
        case 6:
            return kHeight(177 + CGFloat((photoArray.count / 3 == 3 ? 2 : photoArray.count / 3) * 65)) // 宣传图片
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 6 {
            return 0.01
        }
        return kHeight(10)
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ReleaseNoticeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoArray.count == 9 ? self.photoArray.count : self.photoArray.count + 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(photoCollectionIdentifier, forIndexPath: indexPath) as! PhotoCollectionCell
        if photoArray.count == indexPath.item {
            cell.img = UIImage(named: "release_announcement_Addpictures")
        } else {
            cell.img = photoArray[indexPath.item]
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! PhotoCollectionCell
        if indexPath.item == photoArray.count {
            let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
            let camera = UIAlertAction(title: "拍照", style: .Default, handler: { [unowned self](action) in
                let vc = Util.actionSheetImagePicker(isCamera: true)
                guard let v = vc else { return }
                v.allowsEditing = false
                v.delegate = self
                self.presentViewController(v, animated: true, completion: nil)
            })
            let library = UIAlertAction(title: "从相册中选取", style: .Default, handler: { [unowned self](action) in
                let vc = Util.actionSheetImagePicker(isCamera: false)
                guard let v = vc else { return }
                v.allowsEditing = false
                v.delegate = self
                self.presentViewController(v, animated: true, completion: nil)
            })
            let cancel = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
            sheet.addAction(camera)
            sheet.addAction(library)
            sheet.addAction(cancel)
            self.presentViewController(sheet, animated: true, completion: nil)
        } else {
            
        }
    }
}

// MARK: - UIImagePickerControllerDelegate
extension ReleaseNoticeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let originalImg = info["UIImagePickerControllerOriginalImage"] as! UIImage
        picker.dismissViewControllerAnimated(true) { [unowned self] in
            let imgCropper = VPImageCropperViewController(image: originalImg, cropFrame: CGRect(x: 0, y: self.view.center.y - (ScreenWidth * 9/16)/2, width: ScreenWidth, height: ScreenWidth * 9/16), limitScaleRatio: 3)
            imgCropper.delegate = self
            self.presentViewController(imgCropper, animated: true, completion: {
                //TODO
            })
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true) { }//TODO
    }
}

// MARK: - VPImageCropperDelegate
extension ReleaseNoticeViewController: VPImageCropperDelegate {
    func imageCropperDidCancel(cropperViewController: VPImageCropperViewController!) {
        dismissViewControllerAnimated(true) { }//TODO
    }
    
    func imageCropper(cropperViewController: VPImageCropperViewController!, didFinished editedImage: UIImage!) {
        editedImage.resetSizeOfImageData(editedImage, maxSize: 300) { [unowned self](data) in
            self.photoArray.insert(editedImage, atIndex: self.photoArray.count)
            self.checkParameters()
            let cell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 6)) as! SelectPhotoCell
            cell.collectionView.reloadData()
            if self.photoArray.count / 3 >= 1 {
                let range = NSMakeRange(6, 1)
                self.tableView.reloadSections(NSIndexSet(indexesInRange: range), withRowAnimation: .Automatic)
            }
            self.dismissViewControllerAnimated(true) { }//TODO
        }
    }
}

// MARK: - RecruitNeedsCellDelegate, RecruitInformationDelegate, YGPickerViewDelegate, NoArrowEditCellDelegate
extension ReleaseNoticeViewController: RecruitNeedsCellDelegate, RecruitInformationDelegate, NoArrowEditCellDelegate, WorkDetailCellDelegate {
    
    // WARN: 一次性判断太多报错
    func tooManyCheck() -> Bool {
        return !isEmptyString(req.theme) && !isEmptyString(req.recruitment) && !isEmptyString(req.startTime) && !isEmptyString(req.endTime) && !isEmptyString(req.register) && !isEmptyString(req.city) && !isEmptyString(req.details)
    }
    
    func checkParameters() {
        guard tooManyCheck()  && photoArray.count > 0 else {
            releaseButton.backgroundColor = kGrayColor
            releaseButton.userInteractionEnabled = false
            return
        }
        releaseButton.backgroundColor = kCommonColor
        releaseButton.userInteractionEnabled = true
    }
    // MARK: 发布按钮
    func tapReleaseButton(sender: UIButton) {
        SVToast.show()
        OSSImageUploader.asyncUploadImages(tokenObject, images: photoArray) { [weak self](names, state) in
            if state == .Success {
                self?.req.picture = names.joinWithSeparator(",")
                self?.req.cover = names[0]
                Server.getReleaseNotice(self!.req) { (success, msg, value) in
                    SVToast.dismiss()
                    if success {
                        self?.dismissViewControllerAnimated(true, completion: {
                            self?.photoArray.removeAll()
                        })
                    } else {
                        guard let m = msg else {return}
                        SVToast.showWithError(m)
                    }
                }
            } else {
                SVToast.dismiss()
                SVToast.showWithError("上传图片失败")
                
            }
        }
        
    }
    
    func noarrowCellReturnText(text: String?, tuple: (section: Int, row: Int)) {
        guard let t = text else { fatalError("noarrow cell return text nil") }
        switch tuple {
        case (0,0): req.theme = t
        case (4,1): req.adds = t
        default: fatalError("switch default")
        }
        checkParameters()
    }
    
    func workDetailCellReturnText(text: String) {
        req.details = text
        checkParameters()
    }
    
    func recruitNeedsAddRecruite(sender: UIButton) {
        let recruitInfomation = RecruitInformationViewController()
        recruitInfomation.delegate = self
        navigationController?.pushViewController(recruitInfomation, animated: true)
    }
    
    func recruitNeedsEditRecruite(recruit: Recruit, index: Int) {
        let recruitInfomation = RecruitInformationViewController()
        recruitInfomation.delegate = self
        recruitInfomation.req = EditCircularRecruitReq()
        recruitInfomation.req!.categoryId = recruit.id
        recruitInfomation.req!.categoryName = recruit.skill
        recruitInfomation.req!.number = recruit.recruitCount
        recruitInfomation.req!.price = recruit.budgetPrice
        self.index = index
        navigationController?.pushViewController(recruitInfomation, animated: true)
    }
    
    func recruitInformationSureWithParams(recruit: Recruit) {
        if index != -1 {
            recruits.removeAtIndex(index) //直接移除对象, 对象要遵循Equatable协议, 所有加了个index的参数
        }
        req.recruitment = recruit.id
        if index != -1 {
            recruits.insert(recruit, atIndex: index)
        }else {
            recruits.append(recruit)
        }
        index = -1
        tableView.reloadData()
        checkParameters()
    }
    
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension ReleaseNoticeViewController: UIPickerViewDelegate, UIPickerViewDataSource, YGPickerViewDelegate {
    
    func pickerViewSelectedSure(sender: UIButton, pickerView: UIPickerView) {
        let city = pickerView.delegate!.pickerView!(pickerView, titleForRow: pickerView.selectedRowInComponent(1), forComponent: 1)
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 4)) as! ArrowEditCell
        cell.tf.text = city
        req.city = "\(cityResp.province[provinceInt].citys[pickerView.selectedRowInComponent(1)].id)"
        checkParameters()
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return self.cityResp.province.count
        } else {
            let province = self.cityResp.province[pickerView.selectedRowInComponent(0)]
            return province.citys.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return self.cityResp.province[row].name
        } else {
            let province = self.cityResp.province[pickerView.selectedRowInComponent(0)]
            let city = province.citys[row]
            return city.name
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            LogVerbose(row)
            provinceInt = row
            pickerView.reloadComponent(1)
        }
    }
}