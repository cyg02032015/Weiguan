//
//  Register2ViewController.swift
//  OutLookers
//
//  Created by C on 16/8/5.
//  Copyright © 2016年 weiguanonline. All rights reserved.
//

import UIKit

private extension Selector {
    static let countDownTimer = #selector(Register2ViewController.countDownTimer)
}

class Register2ViewController: YGBaseViewController {

    var phone: String!
    var verifyButton: UIButton!
    var verifyTF: UITextField!
    var nextButton: UIButton!
//    var 
    var timer: NSTimer!
    var countDown: Int = 60
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if timer != nil {
            timer.invalidate()
            timer = nil
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        
        let verifyValid = verifyTF.rx_text.map {
            $0.characters.count == 6
            }.shareReplay(1)
        
        verifyValid.bindTo(nextButton.rx_enabled).addDisposableTo(disposeBag)
        verifyValid.subscribe { [weak self](event) in
            guard let weakSelf = self else { return }
            if event.element == true {
                weakSelf.nextButton.userInteractionEnabled = true
                weakSelf.nextButton.backgroundColor = kCommonColor
            } else {
                weakSelf.nextButton.userInteractionEnabled = false
                weakSelf.nextButton.backgroundColor = kLightGrayColor
            }
            }.addDisposableTo(disposeBag)

    }
    
    func setupSubViews() {
        title = "验证手机号（2/3）"
        let topLabel = UILabel.createLabel(17, textColor: kGrayTextColor)
        view.addSubview(topLabel)
        topLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(topLabel.superview!)
            make.top.equalTo(self.snp.topLayoutGuideBottom).offset(kScale(30))
            make.height.equalTo(kScale(17))
        }
        
        let string = NSMutableAttributedString(string: "我们已发送验证码短信到 ", attributes: [NSForegroundColorAttributeName: kGrayTextColor])
        let phoneStr = NSAttributedString(string: phone, attributes: [NSForegroundColorAttributeName: kCommonColor])
        string.appendAttributedString(phoneStr)
        topLabel.attributedText = string
        
        let verifyView = textFieldContainer()
        view.addSubview(verifyView)
        verifyView.snp.makeConstraints { (make) in
            make.centerX.equalTo(verifyView.superview!).offset(kScale(-60))
            make.size.equalTo(kSize(105, height: 44))
            make.top.equalTo(topLabel.snp.bottom).offset(kScale(30))
        }
        
        verifyTF = getTextField("6位验证码")
        verifyTF.delegate = self
        verifyTF.textAlignment = .Center
        verifyView.addSubview(verifyTF)
        verifyTF.snp.makeConstraints { (make) in
            make.edges.equalTo(verifyTF.superview!)
        }
        
        verifyButton = Util.customCornerButton("获取验证码")
        verifyButton.backgroundColor = kCommonColor
        verifyButton.userInteractionEnabled = true
        verifyButton.titleLabel!.font = UIFont.customFontOfSize(14)
        view.addSubview(verifyButton)
        verifyButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(verifyButton.superview!).offset(kScale(60))
            make.size.equalTo(verifyView)
            make.centerY.equalTo(verifyView)
        }
        
        nextButton = Util.customCornerButton("下一步")
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(nextButton.superview!)
            make.size.equalTo(kSize(220, height: 44))
            make.top.equalTo(verifyButton.snp.bottom).offset(kScale(40))
        }
        
        verifyButton.rx_tap.subscribeNext { [unowned self] in
            self.verifyButton.userInteractionEnabled = false
            self.countDownTimer()
            self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: .countDownTimer, userInfo: nil, repeats: true)
        }.addDisposableTo(disposeBag)
        
        nextButton.rx_tap.subscribeNext {
            
        }.addDisposableTo(disposeBag)
    }
    
    func countDownTimer() {
        if countDown == 0 {
            timer.invalidate()
            verifyButton.userInteractionEnabled = true
            verifyButton.setTitle("重新发送", forState: .Normal)
            verifyButton.backgroundColor = kCommonColor
        } else {
            verifyButton.setTitle("\(countDown)s", forState: .Normal)
            verifyButton.backgroundColor = kLightGrayColor
        }
        countDown -= 1
    }
}

// MARK: -TextFieldDelegate
extension Register2ViewController: UITextFieldDelegate {
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let str = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
        if textField == verifyTF {
            return str.characters.count <= 11
        }
        return true
    }
}
