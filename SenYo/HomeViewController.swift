//
//  HomeViewController.swift
//  SenYo
//
//  Created by takahashi akisato on 2016/08/31.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import UIKit
import PureLayout
//import SwiftyJSON
//import Alamofire
import SimpleAnimation

class HomeViewController: UIViewController, HomeViewDelegate, MenuViewDelegate{
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var groupWindow: UIWindow?
    var groupMenuViewController: GroupMenuViewController?

    private let menuView  = MenuView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        let homeView = HomeView()
        let menuItem = UIBarButtonItem()
        let groupItem = UIBarButtonItem()
        homeView.delegate = self
        menuView.delegate = self
        self.view = homeView
        // self.navigationController?.navigationBar.barTintColor = UIColor.blueColor()
        menuItem.image = UIImage(named: "menu")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        menuItem.style = UIBarButtonItemStyle.Plain
        menuItem.action = "clickButton:"
        menuItem.target = self
        menuItem.tintColor = UIColor.clearColor()
        menuItem.tag = 1
        self.navigationItem.rightBarButtonItem = menuItem
        groupItem.image = UIImage(named: "group")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        groupItem.style = UIBarButtonItemStyle.Plain
        groupItem.action = "clickButton:"
        groupItem.target = self
        groupItem.tintColor = UIColor.clearColor()
        groupItem.tag = 2
        self.navigationItem.leftBarButtonItem = groupItem
        
        //グループメニューのセットアップ
        self.setGroupMenu()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //グループメニューのセットアップ
    func setGroupMenu() {
        self.groupWindow = UIWindow()
        // 背景を白に設定する.
        self.groupWindow!.frame = CGRectMake(0, 0, myBoundSize.width, myBoundSize.height)
        self.groupWindow!.layer.position = CGPointMake(myBoundSize.width/2, myBoundSize.height/2)
        self.groupWindow!.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        
        self.groupMenuViewController = GroupMenuViewController()
        self.groupWindow?.rootViewController = self.groupMenuViewController
        
        //self.groupWindow!.userInteractionEnabled = true
        self.groupWindow!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "closeGroupMenu:"))
        
        
        // myWindowをkeyWindowにする.
        self.groupWindow!.makeKeyWindow()
        
        // windowを表示する.
        self.groupWindow!.makeKeyAndVisible()
        
        self.groupWindow!.hidden = true
    }
    
    // ボタンアクション
    internal func clickButton( sender : UIBarButtonItem ){
        switch(sender.tag){
        case 1:
            sender.tag = 3
            self.view.addSubview(menuView)
            menuView.setAutoLayout()
            break
        case 2:
            //self.view.addSubview(tableView)
            //グループメニューのセットアップ
            self.groupWindow!.fadeIn()
            self.groupMenuViewController!.showAnim({ () -> Void in
                
            })
            break
        case 3:
            sender.tag = 1
            self.menuView.removeFromSuperview()
            break
        default:
            print("error")
        }
    }
    
    // メニュー画面遷移
    func chooseCell( sender : Int ){
        var myView : UIViewController!
        switch (sender){
        case 0:
            myView = NewsViewController()
            self.navigationController?.pushViewController(myView, animated: true)
            break;
        case 1:
            myView = SettingViewController()
            self.navigationController?.pushViewController(myView, animated: true)
            break;
        case 2:
            // ログアウト
            let ud = NSUserDefaults.standardUserDefaults()
            ud.setBool(false, forKey: "loginFlag")
            self.appDelegate.beforeLogin()
            break;
        default:
            break;
        }
    }
    
    func closeGroupMenu(sender : UIViewController) {
        print(sender)
        self.groupMenuViewController!.hideAnim({ () -> Void in
            self.groupWindow!.fadeOut()
        })
        
        
    }
    
}
