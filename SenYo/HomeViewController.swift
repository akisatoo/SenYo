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

class HomeViewController: UIViewController, HomeViewDelegate, MenuViewDelegate, GroupViewDelegate{
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    private let hideView = UIView( frame : CGRectMake(0, 0, myBoundSize.width, myBoundSize.height ))
    private var dragFlag : Bool = false
    private let aspect = Aspect()
    private var messageArray : [UIImageView] = []
    private let menuView  = MenuView()
    private let gropeView = GroupView()
    private var locationX : CGFloat!
    private var locationY : CGFloat!
    private var dragX : CGFloat!
    private var dragY : CGFloat!
    private let menuItem = UIBarButtonItem()
    private let groupItem = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        let homeView = HomeView()
        homeView.delegate = self
        menuView.delegate = self
        gropeView.delegate = self
        self.view = homeView
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        self.view.backgroundColor = .whiteColor()
        hideView.backgroundColor = UIColor(white: 0.3, alpha: 0.5)
        gropeView.groupMakeButton.addTarget(self, action: "groupMakeButton:", forControlEvents: .TouchUpInside)
        menuItem.image = UIImage(named: "menu")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        menuItem.style = UIBarButtonItemStyle.Plain
        menuItem.action = "barButtonClick:"
        menuItem.target = self
        menuItem.tintColor = UIColor.clearColor()
        menuItem.tag = 1
        self.navigationItem.rightBarButtonItem = menuItem
        groupItem.image = UIImage(named: "group")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        groupItem.style = UIBarButtonItemStyle.Plain
        groupItem.action = "barButtonClick:"
        groupItem.target = self
        groupItem.tintColor = UIColor.clearColor()
        groupItem.tag = 2
        self.navigationItem.leftBarButtonItem = groupItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // NavigationBar Button Action
    internal func barButtonClick( sender : UIBarButtonItem ){
        switch(sender.tag){
        case 1:
            sender.tag = 3
            self.view.addSubview(menuView)
            menuView.setAutoLayout()
            break
        case 2:
            self.appDelegate.window?.addSubview(self.hideView)
            self.appDelegate.window?.addSubview(gropeView)
            gropeView.setAutoLayout()
            gropeView.bounceIn(from: .Left, x: 0, y: 0, duration: 0.4, delay: 0.3, completion: nil)
            self.hideView.fadeIn(0.4, delay: 0.3, completion: nil)
            self.hideView.userInteractionEnabled = true
            self.hideView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "deleteSideMenu:"))
            break
        case 3:
            sender.tag = 1
            self.menuView.removeFromSuperview()
            break
        default:
            print("error")
        }
    }
    
    // Menu Button Action
    func chooseCell( sender : Int ){
        var myView : UIViewController!
        // Screen Transition
        switch (sender){
        case 0:
            myView = NewsViewController()
            self.navigationController?.pushViewController(myView, animated: true)
            break;
        case 1:
            myView = ProfileViewController()
            self.navigationController?.pushViewController(myView, animated: true)
            break;
        case 2:
            // ログアウト
            let ud = NSUserDefaults.standardUserDefaults()
            ud.removeObjectForKey("id")
            self.appDelegate.beforeLogin()
            break;
        default:
            break;
        }
        menuItem.tag = 1
        self.menuView.removeFromSuperview()
    }
    
    // GroupMakeButton Action
    internal func groupMakeButton(sender: UIButton){
        let myView : UIViewController = MakeGroupViewController()
        self.navigationController?.pushViewController(myView, animated: true )
        self.gropeView.removeFromSuperview()
        self.hideView.removeFromSuperview()

    }
    
    // Touch Began Action
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
                    
                    if ( i + 1 ) % 2 == 0 {
                        messageArray[i].autoPinEdgeToSuperviewEdge(.Top, withInset: 100 * aspect.yAspect() )
                    }else{
                        messageArray[i].autoPinEdgeToSuperviewEdge(.Top, withInset: 220 * aspect.yAspect())
                    }
                    messageArray[i].autoPinEdgeToSuperviewEdge(.Left, withInset: ( 80 + 160 * CGFloat( i / 2 ) ) * aspect.xAspect())
                    messageArray[i].autoSetDimensionsToSize( CGSizeMake(50 * aspect.xAspect(), 50 * aspect.yAspect()))
                    messageArray[i].popIn(0.1, duration: 0.5, delay: 0.2, completion: nil )
                    //messageArray[i].tag = i + 1
                }
                dragFlag = true
                break
            default:
                break
            }
        }
    }
    
    //Drag Action
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if dragFlag {
            let aTouch = touches.first! as UITouch
            // 移動した先の座標を取得.
            let location = aTouch.locationInView(self.view)
            self.locationX = location.x
            self.locationY = location.y
            // 移動する前の座標を取得.
            let prevLocation = aTouch.previousLocationInView(self.view)
            // 移動した距離
            dragX = location.x - prevLocation.x
            dragY = location.y - prevLocation.y
            print(prevLocation," x : ",dragX, " y : ", dragY)
        }
    }
    
    // Slide Menu Delete
    func deleteSideMenu(sender: UITapGestureRecognizer){
        gropeView.bounceOut(to: .Left, x: 0, y: 0, duration: 0.5, delay: 0.2, completion: {(Bool) -> Void in (
                self.gropeView.removeFromSuperview(),
                self.hideView.removeFromSuperview()
            )}
        )
    }
    
    // TapEnd Event
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touchesEnded")
        super.touchesEnded(touches, withEvent: event)
        
        // アイコンを消す
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
                        if self.dragY <= 0 {
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
