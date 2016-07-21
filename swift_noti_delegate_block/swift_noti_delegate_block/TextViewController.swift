//
//  TextViewController.swift
//  swift_noti_delegate_block
//
//  Created by chefuzzj on 16/7/20.
//  Copyright © 2016年 chefuzzj. All rights reserved.
//

import UIKit
// Swift中如何定义协议: 必须遵守NSObjectProtocol
protocol TextViewControllerDelegate: NSObjectProtocol{
    // 点击delegate按钮回调
    func delegateBtnWillClick(message : String)
}

let notificationBtnWillClick = "notificationBtnWillClick"

typealias blockBtnClickSendValue = (message:String)->Void

class TextViewController: UIViewController {
    //定义一个属性保存代理,一定要加weak,避免循环引用
    weak var delegate : TextViewControllerDelegate?
    var myblock : blockBtnClickSendValue?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        creatUI()
    }
    
    //MARK: - 初始化三个按钮
    func creatUI()
    {
        let delegateBtn = UIButton(type: UIButtonType.Custom)
        delegateBtn.frame = CGRect(x: 100, y: 100, width: 100, height: 80)
        delegateBtn.setTitle("代理传值", forState: UIControlState.Normal)
        delegateBtn.backgroundColor = UIColor.blueColor()
        delegateBtn.addTarget(self, action: "delegateBtnClick", forControlEvents: .TouchUpInside)
        view.addSubview(delegateBtn)
        
        //闭包
        let blockBtn = UIButton(type: UIButtonType.Custom)
        blockBtn.frame = CGRect(x: 100, y: 200, width: 100, height: 80)
        blockBtn.setTitle("闭包传值", forState: UIControlState.Normal)
        blockBtn.backgroundColor = UIColor.blueColor()
        blockBtn.addTarget(self, action: "blockBtnClick", forControlEvents: .TouchUpInside)
        view.addSubview(blockBtn)
        
        
        let notificationBtn = UIButton(type: UIButtonType.Custom)
        notificationBtn.frame = CGRect(x: 100, y: 300, width: 100, height: 80)
        notificationBtn.setTitle("通知传值", forState: UIControlState.Normal)
        notificationBtn.backgroundColor = UIColor.blueColor()
        notificationBtn.addTarget(self, action: "notificationBtnClick", forControlEvents: .TouchUpInside)
        view.addSubview(notificationBtn)
    }
    
    //MARK: - 点击代理传值按钮
    func delegateBtnClick()
    {
        print("代理传值按钮被点击")
        let str = "代理传值按钮被点击,把上个界面的值传了过来"
        delegate?.delegateBtnWillClick(str)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //MARK: - 点击闭包传值按钮
    func blockBtnClick()
    {
        print("闭包传值按钮被点击")
        if myblock != nil
        {
            myblock!(message: "闭包传值按钮被点击,把上个界面的值传了过来")
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //MARK: - 点击通知传值按钮
    func notificationBtnClick()
    {
        print("通知传值按钮被点击")
        let dict = ["action":"通知传值按钮被点击,把上个界面的值传了过来"]
    NSNotificationCenter.defaultCenter().postNotificationName(notificationBtnWillClick, object: self, userInfo: dict)
        
        self.navigationController?.popViewControllerAnimated(true)
    }
}
