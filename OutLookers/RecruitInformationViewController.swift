//
//  RecruitInformationViewController.swift
//  OutLookers
//
//  Created by C on 16/6/19.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//  招募信息

import UIKit

private let noArrowIdentifier = "noArrowId"
private let arrowIdentifier = "arrowId"
private let budgetPriceIdentifier = "budgetPriceId"

private extension Selector {
    static let tapReleaseButton = #selector(RecruitInformationViewController.tapReleaseButton(_:))
}

enum UnitType: String {
    case YuanHour = "1"
    case YuanRound = "2"
    case YuanOnce = "3"
    case YuanDay = "5"
    case YuanMonth = "6"
    case YuanYear = "7"
    case YuanPeople = "8"
}

protocol RecruitInformationDelegate: class {
    func recruitInformationSureWithParams(recruit: Recruit)
}

class RecruitInformationViewController: YGBaseViewController {

    var tableView: UITableView!
    weak var delegate: RecruitInformationDelegate!
    var rightButton: UIButton!
    var req: EditCircularRecruitReq?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "招募信息"
        
        tableView = UITableView()
        tableView.backgroundColor = kBackgoundColor
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.registerClass(ArrowEditCell.self, forCellReuseIdentifier: arrowIdentifier)
        tableView.registerClass(NoArrowEditCell.self, forCellReuseIdentifier: noArrowIdentifier)
        tableView.registerClass(BudgetPriceCell.self, forCellReuseIdentifier: budgetPriceIdentifier)
        
        rightButton = Util.createReleaseButton("确定")
        rightButton.addTarget(self, action: .tapReleaseButton, forControlEvents: .TouchUpInside)
        view.addSubview(rightButton)
        rightButton.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(rightButton.superview!)
            make.height.equalTo(kScale(50))
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(tableView.superview!)
            make.bottom.equalTo(rightButton.snp.top)
        }
        if var _ = req {
            req!.unit = UnitType.YuanPeople.rawValue
        }else {
            req = EditCircularRecruitReq()
            req!.unit = UnitType.YuanPeople.rawValue
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension RecruitInformationViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(arrowIdentifier, forIndexPath: indexPath) as! ArrowEditCell
            cell.setTextInCell("红人类型", placeholder: "点击选择类型")
            cell.tf.text = req?.categoryName ?? ""
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier(noArrowIdentifier, forIndexPath: indexPath) as! NoArrowEditCell
            cell.tf.keyboardType = .NumberPad
            cell.indexPath = indexPath
            cell.delegate = self
            cell.setTextInCell("招募人数", placeholder: "请输入整数")
            cell.tf.text = req?.number ?? ""
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(budgetPriceIdentifier, forIndexPath: indexPath) as! BudgetPriceCell
            cell.tf.keyboardType = .NumberPad
            cell.setTextInCell("预算价格 (选填)", placeholder: "请输入整数", buttonText: "元/人")
            cell.tf.text = req?.price ?? ""
            _ = cell.tf.rx_text.subscribeNext({ [weak self](text) in
                self?.req?.price = text
                self?.checkParameters()
            })
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            let selectSkill = SelectSkillViewController()
            selectSkill.type = SelectSkillType.Back
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! ArrowEditCell
            selectSkill.tapItemInCollection({ [unowned self](item) in
                cell.tf.text = item.name
                self.req?.categoryId = "\(item.id)"
                self.req?.categoryName = item.name
                self.checkParameters()
            })
            navigationController?.pushViewController(selectSkill, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return kHeight(56)
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}

// MARK: -点击按钮 & NoArrowEditCellDelegate
extension RecruitInformationViewController: NoArrowEditCellDelegate {

    func checkParameters() {
        guard !isEmptyString(req?.categoryId) && !isEmptyString(req?.categoryName) && !isEmptyString(req?.number) && !isEmptyString(req?.price) else {
            rightButton.backgroundColor = kGrayColor
            rightButton.userInteractionEnabled = false
            return
        }
        rightButton.backgroundColor = kCommonColor
        rightButton.userInteractionEnabled = true
    }
    
    func tapReleaseButton(sender: UIButton) {
        Server.editNoticeRecruitNeeds(req!) { [unowned self](success, msg, value) in
            if success {
                guard let object = value else { return }
                let price = object.price == 0 ? "" : "\(object.price)"
                let recruit = Recruit(id: "\(object.id)", skill: object.categoryName, recruitCount: "\(object.number)", budgetPrice: price)
                self.delegate.recruitInformationSureWithParams(recruit)
                self.navigationController?.popViewControllerAnimated(true)
            } else {
                LogError(msg)
            }
        }
    }
    
    func noarrowCellReturnText(text: String?, tuple: (section: Int, row: Int)) {
        switch tuple {
        case (0,1): req?.number = text
        default: ""
        }
        checkParameters()
    }
    
    func textFieldReturnText(text: String) {
        req?.price = text
    }
}