//
//  TalentAuthViewController.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/18.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

class TalentAuthViewController: YGBaseViewController {

    var scrollView: UIScrollView!
    var collectionView: UICollectionView!
    lazy var photos = [UIImage]()
    lazy var originPhotos = [AnyObject]()
    var commitButton: UIButton!
    var textField: UITextField!
    var picToken: GetToken!
    lazy var req = HotmanAuthReq()
    var authShow: HotmanAuthShowResp!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "红人认证"
        loadData()
        getToken()
    }
    
    func loadData() {
        Server.hotmanAuthShow { (success, msg, value) in
            if success {
                guard let obj = value else {return}
                self.authShow = obj
                self.setupSubViews()
            } else {
                guard let m = msg else {return}
                SVToast.showWithError(m)
            }
        }
    }
    
    func getToken() {
        Server.getUpdateFileToken(.Picture) { (success, msg, value) in
            if success {
                guard let obj = value else {return}
                self.picToken = obj
            } else {
                LogError(msg)
            }
        }
    }
    
    func setupSubViews() {
        
        commitButton = setRightNaviItem()
        commitButton.setTitle("提交", forState: .Normal)
        
        scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(scrollView.superview!)
            make.top.equalTo(self.snp.topLayoutGuideBottom)
        }
        
        
        let container = UIView()
        container.backgroundColor = kBackgoundColor
        scrollView.addSubview(container)
        container.snp.makeConstraints { (make) in
            make.edges.equalTo(container.superview!)
            make.width.equalTo(ScreenWidth)
        }
        
        let custom1 = CustomContainer()
        custom1.topLabel.text = "绑定手机"
        custom1.centerButton.setImage(UIImage(named: "phone"), forState: .Normal)
        custom1.centerButton.setImage(UIImage(named: "phone-1"), forState: .Selected)
        custom1.bottomLabel.text = authShow.mobile == false ? "未完成" : "已完成"
        custom1.centerButton.selected = authShow.mobile
        container.addSubview(custom1)
        custom1.snp.makeConstraints { (make) in
            make.top.left.equalTo(custom1.superview!)
            make.height.equalTo(kScale(166))
            make.width.equalTo(ScreenWidth/2)
        }
        
        let custom2 = CustomContainer()
        custom2.topLabel.text = "完善个人档案"
        custom2.centerButton.setImage(UIImage(named: "archives"), forState: .Normal)
        custom2.centerButton.setImage(UIImage(named: "archives-1"), forState: .Selected)
        custom2.bottomLabel.text = authShow.archives == false ? "未完成" : "已完成"
        custom2.centerButton.selected = authShow.archives
        container.addSubview(custom2)
        custom2.snp.makeConstraints { (make) in
            make.left.equalTo(custom1.snp.right)
            make.centerY.equalTo(custom1)
            make.height.equalTo(custom1)
            make.width.equalTo(ScreenWidth/2)
        }
        
        let custom3 = CustomContainer()
        custom3.topLabel.text = "发布动态三个以上"
        custom3.centerButton.setImage(UIImage(named: "dynamic"), forState: .Normal)
        custom3.centerButton.setImage(UIImage(named: "dynamic-1"), forState: .Selected)
        custom3.bottomLabel.text = authShow.dynamic == false ? "未完成" : "已完成"
        custom3.centerButton.selected = authShow.dynamic
        container.addSubview(custom3)
        custom3.snp.makeConstraints { (make) in
            make.centerX.equalTo(custom1)
            make.top.equalTo(custom1.snp.bottom)
            make.height.equalTo(custom1)
            make.width.equalTo(custom1)
        }
        
        let custom4 = CustomContainer()
        custom4.topLabel.text = "发布才艺一个以上"
        custom4.centerButton.setImage(UIImage(named: "skill"), forState: .Normal)
        custom4.centerButton.setImage(UIImage(named: "skill-1"), forState: .Selected)
        custom4.bottomLabel.text = authShow.talent == false ? "未完成" : "已完成"
        custom4.centerButton.selected = authShow.talent
        container.addSubview(custom4)
        custom4.snp.makeConstraints { (make) in
            make.centerX.equalTo(custom2)
            make.top.equalTo(custom2.snp.bottom)
            make.height.equalTo(custom1)
            make.width.equalTo(custom1)
        }
        
        let desc = UILabel.createLabel(14, textColor: UIColor(hex: 0x666666))
        desc.numberOfLines = 2
        desc.text = "如满足以上条件，请上传相关资料（如个人名片、才艺证书、公司证明等）以利于审核通过"
        container.addSubview(desc)
        desc.snp.makeConstraints { (make) in
            make.left.equalTo(desc.superview!).offset(kScale(15))
            make.right.equalTo(desc.superview!).offset(kScale(-15))
            make.top.equalTo(custom4.snp.bottom).offset(kScale(30))
            make.height.equalTo(kScale(40))
        }

        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: (ScreenWidth - 30 - 40) / 4, height: kScale(72))
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.backgroundColor = kBackgoundColor
        collectionView.scrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        container.addSubview(collectionView)
        collectionView.registerClass(PhotoCollectionCell.self, forCellWithReuseIdentifier: releasePictureCollectionCellIdentifier)
        collectionView.snp.makeConstraints { (make) in
            make.left.right.equalTo(collectionView.superview!)
            make.top.equalTo(desc.snp.bottom).offset(kScale(12))
            make.height.equalTo(kScale(80))
        }
        
        textField = UITextField()
        textField.textAlignment = .Center
        textField.placeholder = "请输入想认证的角色"
        textField.font = UIFont.customFontOfSize(14)
        container.addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom).offset(kScale(37))
            make.centerX.equalTo(textField.superview!)
            make.size.equalTo(kSize(200, height: 20))
        }
        
        let lineV = UIView()
        lineV.backgroundColor = kLineColor
        container.addSubview(lineV)
        lineV.snp.makeConstraints { (make) in
            make.centerX.equalTo(textField)
            make.top.equalTo(textField.snp.bottom).offset(kScale(3))
            make.size.equalTo(CGSize(width: kScale(200), height: 1))
        }
        
        container.snp.makeConstraints { (make) in
            make.bottom.equalTo(lineV.snp.bottom).offset(kScale(18))
        }
    }
    
    override func tapMoreButton(sender: UIButton) {
        if authShow != nil && authShow.talent && authShow.archives && authShow.dynamic && authShow.mobile && !isEmptyString(textField.text) && self.photos.count > 0 {
            req.name = textField.text!
            let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
            let group = dispatch_group_create()
            SVToast.show()
            dispatch_group_async(group, queue) { [weak self] in
                dispatch_group_enter(group)
                OSSImageUploader.asyncUploadImages(self!.picToken, images: self!.photos, complete: { (names, state) in
                    dispatch_group_leave(group)
                    if state == .Success {
                        self?.req.photo = names.joinWithSeparator(",")
                    } else {
                        self?.req.photo = ""
                        SVToast.dismiss()
                        SVToast.showWithError("上传图片失败")
                    }
                })
            }
            dispatch_group_notify(group, queue) { [weak self] in
                if isEmptyString(self!.req.photo) {
                    return
                }
                Server.hotmanAuth(self!.req, handler: { (success, msg, value) in
                    if success {
                        SVToast.showWithSuccess(value!)
                        delay(1, task: { 
                            self?.navigationController?.popToRootViewControllerAnimated(true)
                        })
                    } else {
                        guard let m = msg else {return}
                        SVToast.showWithError(m)
                    }
                })
            }
        }
    }
}

extension TalentAuthViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
        if indexPath.item == photos.count {
            let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
            let camera = UIAlertAction(title: "拍照", style: .Default, handler: { [unowned self](action) in
                let vc = Util.actionSheetImagePicker(isCamera: true)
                guard let v = vc else { return }
                v.delegate = self
                self.presentViewController(v, animated: true, completion: nil)
            })
            let library = UIAlertAction(title: "从相册中选取", style: .Default, handler: { [unowned self](action) in
                let tz = TZImagePickerController(maxImagesCount: 9, delegate: self)
                tz.allowTakePicture = false
                tz.allowPickingVideo = false
                tz.selectedAssets = NSMutableArray(array: self.originPhotos)
                self.presentViewController(tz, animated: true, completion: nil)
            })
            let cancel = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
            sheet.addAction(camera)
            sheet.addAction(library)
            sheet.addAction(cancel)
            self.presentViewController(sheet, animated: true, completion: nil)
        } else {
            let vc = YKPhotoPreviewController()
            vc.currentIndex = indexPath.item
            vc.photos = self.photos
            vc.originPhotos = self.originPhotos
            vc.didFinishPickingPhotos({ (photos, originPhotos) in
                self.originPhotos = originPhotos
                self.photos = photos
                self.collectionView.reloadData()
            })
            presentViewController(vc, animated: true, completion: nil)
        }
    }
}

extension TalentAuthViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, TZImagePickerControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        _ = info["UIImagePickerControllerOriginalImage"] as! UIImage
        picker.dismissViewControllerAnimated(true) {}
    }
    
    func imagePickerController(picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [AnyObject]!, isSelectOriginalPhoto: Bool) {
        self.photos = photos
        self.originPhotos = assets
        collectionView.reloadData()
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true) { }//TODO
    }
}


class CustomContainer: UIView {
    
    var topLabel: UILabel!
    var centerButton: UIButton!
    var bottomLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    
    func setupSubViews() {
        topLabel = UILabel.createLabel(14)
        topLabel.textAlignment = .Center
        addSubview(topLabel)
        topLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(topLabel.superview!)
            make.height.equalTo(kScale(14))
            make.top.equalTo(topLabel.superview!).offset(kScale(30))
        }
        
        centerButton = UIButton()
        addSubview(centerButton)
        centerButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(topLabel)
            make.size.equalTo(kSize(88, height: 88))
            make.top.equalTo(topLabel.snp.bottom).offset(kScale(10))
        }
        
        bottomLabel = UILabel.createLabel(14, textColor: UIColor(hex: 0x999999))
        bottomLabel.textAlignment = .Center
        addSubview(bottomLabel)
        bottomLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(bottomLabel.superview!)
            make.top.equalTo(centerButton.snp.bottom).offset(kScale(10))
            make.bottom.equalTo(bottomLabel.superview!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}