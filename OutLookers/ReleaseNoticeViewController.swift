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
    var photoArray: [UIImage]!
    var request = ReleaseNoticeRequest()
    var releaseButton: UIButton!
    lazy var cityResp: CityResp = YGCityData.loadCityData()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "编辑通告"
        setupSubViews()
        selectDatePicker = YGSelectDateView()
        pickerView = YGPickerView(frame: CGRectZero, delegate: self)
        pickerView.delegate = self
    }

    func setupSubViews() {
        photoArray = [UIImage(named: "release_announcement_Addpictures")!]
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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
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
                    self.request.startTime = date.stringFromDateWith("yyyy-MM-dd")
                })
                
            } else { // 工作结束时间
                let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 2)) as! ArrowEditCell
                selectDatePicker.animation()
                selectDatePicker.tapSureClosure({ (date) in
                    cell.tf.text = date.stringFromDate()
                    self.request.endTime = date.stringFromDateWith("yyyy-MM-dd")
                })
            }
        }
        
        if indexPath.section == 3 { // 报名截止日期
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 3)) as! ArrowEditCell
            selectDatePicker.animation()
            selectDatePicker.tapSureClosure({ (date) in
                cell.tf.text = date.stringFromDate()
                self.request.register = date.stringFromDateWith("yyyy-MM-dd")
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
            return kHeight(177 + CGFloat((photoArray.count - 1) / 3 * 65)) // 宣传图片
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
        return self.photoArray.count > 9 ? self.photoArray.count - 1 : self.photoArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(photoCollectionIdentifier, forIndexPath: indexPath) as! PhotoCollectionCell
        cell.img = photoArray[indexPath.item]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! PhotoCollectionCell
        guard let image = cell.imgView.image else { return }
        if image == photoArray[photoArray.count - 1] {
            let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
            let camera = UIAlertAction(title: "拍照", style: .Default, handler: { (action) in
                    let vc = Util.actionSheetImagePicker(isCamera: true)
                guard let v = vc else { return }
                    v.delegate = self
                    self.presentViewController(v, animated: true, completion: nil)
                })
            let library = UIAlertAction(title: "从相册中选取", style: .Default, handler: { (action) in
                let vc = Util.actionSheetImagePicker(isCamera: false)
                guard let v = vc else { return }
                v.delegate = self
                self.presentViewController(v, animated: true, completion: nil)
                })
            let cancel = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
            sheet.addAction(camera)
            sheet.addAction(library)
            sheet.addAction(cancel)
            self.presentViewController(sheet, animated: true, completion: nil)
        }
    }
}

// MARK: - UIImagePickerControllerDelegate 
extension ReleaseNoticeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let originalImg = info["UIImagePickerControllerOriginalImage"] as! UIImage
        picker.dismissViewControllerAnimated(true) {
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
        editedImage.resetSizeOfImageData(editedImage, maxSize: 300) { (data) in
            self.photoArray.insert(editedImage, atIndex: self.photoArray.count - 1)
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
    // MARK: 发布按钮
    func tapReleaseButton(sender: UIButton) {
        self.view.endEditing(true)
        // TODO- 测试
//        request.userId = "1"
//        request.theme = "1"
//        request.recruitment = "11,12,14"
//        request.startTime = "2015-06-05"
//        request.endTime = "2015-06-06"
//        request.register = "2016-06-07"
//        request.city = "123"
//        request.adds = "1111"
        request.picture = "11,12,14"
        if isEmptyString(request.theme) {
            YKToast.makeText("请填写工作主题")
            return
        }
        if isEmptyString(request.recruitment) {
            YKToast.makeText("请选择招募需求")
            return
        }
        if isEmptyString(request.startTime) {
            YKToast.makeText("请选择工作开始时间")
            return
        }
        if isEmptyString(request.endTime) {
            YKToast.makeText("请选择工作结束时间")
            return
        }
        if isEmptyString(request.register) {
            YKToast.makeText("请选择报名截止时间")
            return
        }
        if isEmptyString(request.city) {
            YKToast.makeText("请选择工作地点")
            return
        }
        if isEmptyString(request.details) {
            YKToast.makeText("请填写工作详情")
            return
        }
        if isEmptyString(request.picture) {
            YKToast.makeText("请选择至少一张宣传图片")
            return
        }
        if isEmptyString(request.adds) {
            request.adds = ""
        }
        Server.getReleaseNotice(request) { (success, msg, value) in
            if success {
                LogInfo(value)
            } else {
                LogError(msg)
                YKToast.makeText(msg!)
            }
        }
    }
    
    func noarrowCellReturnText(text: String?, tuple: (section: Int, row: Int)) {
        guard let t = text else { fatalError("noarrow cell return text nil") }
        switch tuple {
        case (0,0): request.theme = t
        case (4,1): request.adds = t
        default: fatalError("switch default")
        }
    }
    
    func workDetailCellReturnText(text: String) {
        request.details = text
    }
    
    func recruitNeedsAddRecruite(sender: UIButton) {
        let recruitInfomation = RecruitInformationViewController()
        recruitInfomation.delegate = self
        navigationController?.pushViewController(recruitInfomation, animated: true)
    }
    
    func recruitInformationSureWithParams(recruit: Recruit) {
        //MARK: 添加招募需求request
        request.recruitment = "11,14,12"
        recruits.append(recruit)
        tableView.reloadData()
//        let range = NSMakeRange(1, 1)
//        tableView.reloadSections(NSIndexSet(indexesInRange: range), withRowAnimation: .Automatic)
    }
    
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension ReleaseNoticeViewController: UIPickerViewDelegate, UIPickerViewDataSource, YGPickerViewDelegate {
    
    func pickerViewSelectedSure(sender: UIButton, pickerView: UIPickerView) {
        let city = pickerView.delegate!.pickerView!(pickerView, titleForRow: pickerView.selectedRowInComponent(1), forComponent: 1)
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 4)) as! ArrowEditCell
        cell.tf.text = city
        // MARK: 选择城市request
        request.city = city
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
            pickerView.reloadComponent(1)
        }
    }
}