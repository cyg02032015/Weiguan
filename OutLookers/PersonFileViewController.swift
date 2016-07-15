//
//  PersonFileViewController.swift
//  OutLookers
//
//  Created by Youngkook on 16/7/14.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let arrowEditCellId = "arrowEditCellId"
private let bwhCellId = "bwhCellId"
private let personStyleCellId = "personStyleCellId"

class PersonFileViewController: YGBaseViewController {

    var sectionTitles = ["基本资料", "个人特征", "通告经验"]
    var sectionImages = ["data", "Features", "Announcement-1"]
    var commitButton: UIButton!
    var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }
    
    func setupSubViews() {
        title = "个人档案"
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = kLineColor
        tableView.backgroundColor = kBackgoundColor
        tableView.registerClass(ArrowEditCell.self, forCellReuseIdentifier: arrowEditCellId)
        tableView.registerClass(BWHTableViewCell.self, forCellReuseIdentifier: bwhCellId)
        tableView.registerClass(PersonStyleCell.self, forCellReuseIdentifier: personStyleCellId)
        view.addSubview(tableView)
        
        commitButton = Util.createReleaseButton("提交")
        view.addSubview(commitButton)
        commitButton.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(commitButton.superview!)
            make.height.equalTo(kScale(44))
        }
        
        
        tableView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(tableView.superview!)
            make.bottom.equalTo(commitButton.snp.top)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension PersonFileViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        } else {
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row != 2 {
                let cell = tableView.dequeueReusableCellWithIdentifier(arrowEditCellId, forIndexPath: indexPath) as! ArrowEditCell
                cell.tf.font = UIFont.customFontOfSize(16)
                cell.label.font = UIFont.customFontOfSize(16)
                cell.label.textColor = UIColor(hex: 0x777777)
                if indexPath.row == 0 {
                    cell.setTextInCell("身高", placeholder: "请选择身高CM")
                } else if indexPath.row == 1 {
                    cell.setTextInCell("体重", placeholder: "请选择体重KG")
                } else if indexPath.row == 3 {
                    cell.setTextInCell("星座", placeholder: "请选择星座")
                }
                return cell
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier(bwhCellId, forIndexPath: indexPath) as! BWHTableViewCell
                return cell
            }
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier(personStyleCellId, forIndexPath: indexPath) as! PersonStyleCell
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return kHeight(46)
        } else if indexPath.section == 1 {
            return kHeight(124)
        } else {
            return kHeight(79)
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = PersonFileHeadView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: kScale(46)))
        view.delegate = self
        view.section = section
        view.imgView.image = UIImage(named: sectionImages[section])
        view.label.text = sectionTitles[section]
        if section == 1 {
            view.editButton.hidden = false
        } else {
            view.editButton.hidden = true
        }
        return view
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kHeight(46)
    }
}

extension PersonFileViewController: PersonFileHeadViewDelegate {
    func personFileTapEditButton(sender: UIButton) {
        LogInfo("section = \(sender.tag)")
    }
}
