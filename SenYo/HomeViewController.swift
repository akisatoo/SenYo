//
//  HomeViewController.swift
//  SenYo
//
//  Created by takahashi akisato on 2016/08/31.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, HomeViewDelegate{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        let homeView = HomeView()
        homeView.delegate = self
        self.view = homeView
       // self.navigationController?.navigationBar.barTintColor = UIColor.blueColor()
        let newsItem = UIBarButtonItem()
        newsItem.image = UIImage(named: "bell.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        newsItem.style = UIBarButtonItemStyle.Plain
        newsItem.action = "clickButton:"
        newsItem.target = self
        newsItem.tintColor = UIColor.clearColor()
        newsItem.tag = 3
        self.navigationItem.rightBarButtonItem = newsItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 画面遷移
    internal func clickButton( sender : UIBarButtonItem ){
        switch(sender.tag){
        case 1:
            let setting = SettingViewController()
            self.navigationController?.pushViewController(setting, animated: true )
            break
        case 2:
            let noticeView = NoticeViewController()
            self.navigationController?.pushViewController(noticeView, animated: true)
            break
        case 3:
            let view = NewsViewController()
            self.navigationController?.pushViewController(view, animated: true)
            break
        default:
            print("error")
        }
    }
}
