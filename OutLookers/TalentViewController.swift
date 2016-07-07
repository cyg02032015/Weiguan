//
//  TalentViewController.swift
//  OutLookers
//
//  Created by C on 16/7/5.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private let talentCellIdentifier = "talentCellId"



class TalentViewController: YGBaseViewController {

    lazy var data = [String]()
    var tableView: UITableView!
    weak var delegate: ScrollVerticalDelegate!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        LogInfo("viewwillappear")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LogWarn("viewdidload")
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(TalentTableViewCell.self, forCellReuseIdentifier: talentCellIdentifier)
        tableView.separatorStyle = .None
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = kHeight(602)
        tableView.rowHeight = UITableViewAutomaticDimension
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView.superview!)
        }
    }
}

// MARK: - UITableviewDelegate, UITableviewDatasource
extension TalentViewController {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(talentCellIdentifier, forIndexPath: indexPath) as! TalentTableViewCell
        cell.collectionViewSetDelegate(self, indexPath: indexPath)
        if indexPath.section == 0 {
            cell.detailsLabel.text = "afaslfkjs;lfkasjdflaskfjlsa;fkasfl;askhgaslgkhasglsakhgsaklghaskgljahsgklsjghsakghsakgjahsgkasjghaklsgjhaskdgsahjgksajghaksghjsadkgjhasgkajshgdksadjghsakgjhaskghasgkhasgkashgk"
        } else if indexPath.section == 1 {
            cell.detailsLabel.text = "afaslfkjs;lfkasjdflaskfjlsa;fkasfl;"
        } else {
            cell.detailsLabel.text = "afaslfkjs;lfkasjdflaskfjlsa;fkasfl;asdfasdfsadfsafasldfksajflsafjas;flasjfalfj"
        }
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        if delegate != nil && scrollView.isKindOfClass(UITableView.self) {
            delegate.customScrollViewDidEndDecelerating(true)
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate && delegate != nil && scrollView.isKindOfClass(UITableView.self) {
            delegate.customScrollViewDidEndDecelerating(false)
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if delegate != nil && scrollView.isKindOfClass(UITableView.self) {
            delegate.customScrollViewDidEndDecelerating(false)
        }
    }
}

extension TalentViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(talentWorksCollectionCellIdentifier, forIndexPath: indexPath)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        LogInfo("\(collectionView.tag)     \(indexPath.item)")
    }
}