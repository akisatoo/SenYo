//
//  HomeViewController.swift
//  SenYo
//
//  Created by takahashi akisato on 2016/08/31.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import UIKit
import PureLayout
import SimpleAnimation
//import SwiftyJSON
//import Alamofire

class HomeViewController: UIViewController, HomeViewDelegate, MenuViewDelegate{
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    private var dragFlag : Bool = false
    private var messageArray : [UIImageView] = []
    private let menuView  = MenuView()
    private var dragX : CGFloat!
    private var dragY : CGFloat!
    
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ボタンアクション
    internal func clickButton( sender : UIBarButtonItem ){
        switch(sender.tag){
        case 1:
            sender.tag = 2
            self.view.addSubview(menuView)
            menuView.setAutoLayout()
            break
        case 2:
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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        for touch: UITouch in touches {
            let tag = touch.view!.tag
            switch tag {
            case 1:
                for i in 0 ... 3{
                    let button = UIImageView(image: UIImage(named: "sen\(i + 1)"))
                    button.tag = i + 1
                    messageArray.append(button)
                    self.view.addSubview(messageArray[i])
                    messageArray[i].autoSetDimensionsToSize(CGSizeMake(45, 45))
                    if ( i + 1 ) % 2 == 0 {
                        messageArray[i].autoPinEdgeToSuperviewEdge(.Top, withInset: 100 )
                    }else{
                        messageArray[i].autoPinEdgeToSuperviewEdge(.Top, withInset: 180 )
                    }
                    messageArray[i].autoPinEdgeToSuperviewEdge(.Left, withInset: 90 + 150 * CGFloat( i / 2 ))
                    messageArray[i].popIn(0.1, duration: 0.5, delay: 0.2, completion: nil )
                }
                
                dragFlag = true
                break
            default:
                break
            }
        }
    }
    
    //ドラッグイベント
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if dragFlag {
            let aTouch = touches.first! as UITouch
            
            // 移動した先の座標を取得.
            let location = aTouch.locationInView(self.view)
            
            // 移動する前の座標を取得.
            let prevLocation = aTouch.previousLocationInView(self.view)
            
            dragX = location.x - prevLocation.x
            dragY = location.y - prevLocation.y
            print(prevLocation," x : ",dragX, " y : ", dragY)
        }
    }
    
    // TapEnd Event
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touchesEnded")
        if dragFlag {
            for i in 0 ... 3{
                messageArray[i].popOut(0.1, duration: 0.5, delay: 0.2, completion: {(Bool)-> Void in
                    self.messageArray[i].removeFromSuperview()
                    if self.dragX > 0 {
                        if self.dragY >= 0 {
                            //右下
                            print("right_bottom")
                        }else{
                            //右上
                            print("right_top")
                        }
                    }else{
                        if self.dragY < 0 {
                            //左下
                            print("left_top")
                        }else{
                            //左上
                            print("left_bottom")
                        }

                    }
                })
            }
            dragFlag = false
        }
    }
}
