//
//  ViewController.swift
//  swift_noti_delegate_block
//
//  Created by chefuzzj on 16/7/20.
//  Copyright © 2016年 chefuzzj. All rights reserved.
//

import UIKit

class ViewController: UIViewController,TextViewControllerDelegate {

    var textVC:TextViewController = TextViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let pushBtn = UIButton(type: UIButtonType.Custom)
        pushBtn.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        pushBtn.setTitle("跳转", forState: UIControlState.Normal)
        pushBtn.backgroundColor = UIColor.blueColor()
        pushBtn.addTarget(self, action: "pushBtnClick", forControlEvents: .TouchUpInside)
        view.addSubview(pushBtn)

        //监听通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "receiveNoti:", name: notificationBtnWillClick, object: nil)
        
        textVC.myblock =  {(message:String) -> Void in
            
            print("\(message)")
        }

    }
    
    //MARK: - 注销通知,相当于OC中的dealloc方法
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //MARK: - 按钮点击方法,跳转界面
    func pushBtnClick()
    {
        //设置此控制器为代理
        textVC.delegate = self;
        self.navigationController?.pushViewController(textVC, animated: true)
    }
    //MARK: - 通知方法
    func receiveNoti(notification : NSNotification)
    {
        let userInfo = notification.userInfo
        print(userInfo!["action"])
    }
    
    //MARK: - 代理方法
    func delegateBtnWillClick(message: String) {
        print(message)
    }
}

