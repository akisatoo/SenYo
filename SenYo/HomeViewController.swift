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
import SwiftyJSON
import Alamofire

class HomeViewController: UIViewController, HomeViewDelegate, MenuViewDelegate, GroupViewDelegate{
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    private let hideView = UIView( frame : CGRectMake(0, 0, myBoundSize.width, myBoundSize.height ))
    private var dragFlag : Bool = false
    private let aspect = Aspect()
    private var messageArray : [UIImageView] = []
    private let menuView  = MenuView()
    private let groupView = GroupView()
    private let homeView = HomeView()
    private var locationX : CGFloat!
    private var locationY : CGFloat!
    private var dragX : CGFloat!
    private var dragY : CGFloat!
    private var firstPoint : CGPoint?
    private let menuItem = UIBarButtonItem()
    private let groupItem = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        homeView.delegate = self
        menuView.delegate = self
        groupView.delegate = self
        self.view = homeView
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        self.view.backgroundColor = .whiteColor()
        reloadList()
        hideView.backgroundColor = UIColor(white: 0.3, alpha: 0.5)
        groupView.groupMakeButton.addTarget(self, action: "groupMakeButton:", forControlEvents: .TouchUpInside)
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
        //
        hideView.hidden = true
        self.hideView.userInteractionEnabled = true
        self.hideView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "deleteSideMenu:"))
        groupView.hidden = true
        menuView.hidden = true
        
        // addsubview
        self.appDelegate.window?.addSubview(self.hideView)
        self.appDelegate.window?.addSubview(groupView)
        self.view.addSubview(menuView)
        // autolayout
        menuView.setAutoLayout()
        groupView.setAutoLayout()
        // set user
        let ud = NSUserDefaults.standardUserDefaults()
        let groupData = ud.objectForKey("groupData") as? Int
        print("groupData : ",groupData)
        if groupData != nil {
            self.homeView.setMember(self.groupView.getGroupData()[groupData!] )
        }
    }
    
    // NavigationBar Button Action
    internal func barButtonClick( sender : UIBarButtonItem ){
        switch(sender.tag){
        case 1:
            sender.tag = 3
            menuView.hidden = false
            break
        case 2:
            self.hideView.hidden = false
            self.hideView.fadeIn(0.4, delay: 0.3, completion: nil)
            self.groupView.hidden = false
            self.groupView.bounceIn(from : .Left)
            break
        case 3:
            sender.tag = 1
            menuView.hidden = true
            break
        default:
            print("error")
        }
    }
    
    // Slide Menu Delete
    func deleteSideMenu(sender: UITapGestureRecognizer){
        groupView.bounceOut(to:.Left, completion : {(Bool) -> Void in (
           self.groupView.hidden = true,
           self.hideView.hidden = true
            )}
        )
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
            // logout
            let ud = NSUserDefaults.standardUserDefaults()
            ud.removeObjectForKey("id")
            ud.removeObjectForKey("user_id")
            self.appDelegate.beforeLogin()
            break;
        default:
            break;
        }
        menuItem.tag = 1
        menuView.hidden = true
    }
    
    // MakeGroupView Transition
    internal func groupMakeButton(sender: UIButton){
        let myView : UIViewController = MakeGroupViewController()
        self.navigationController?.pushViewController(myView, animated: true )
        self.groupView.hidden = true
        self.hideView.hidden = true
    }
    
    // ------- Send Message ----------
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        for touch: UITouch in touches {
            let tag = touch.view!.tag
            switch tag {
            case 1:
                let firstTouch = touches.first!
                firstPoint = firstTouch.locationInView(self.view)
                for i in 0 ... 3{
                    let button = UIImageView(image: UIImage(named: "sen\(i + 1)"))
                    button.tag = i + 1
                    messageArray.append(button)
                    self.view.addSubview(messageArray[i])
                    
                    if ( i + 1 ) % 2 == 0 {
                        messageArray[i].autoPinEdgeToSuperviewEdge(.Top, withInset: 80 * aspect.yAspect() )
                    }else{
                        messageArray[i].autoPinEdgeToSuperviewEdge(.Top, withInset: 180 * aspect.yAspect())
                    }
                    messageArray[i].autoPinEdgeToSuperviewEdge(.Left, withInset: ( 80 + 160 * CGFloat( i / 2 ) ) * aspect.xAspect())
                    messageArray[i].autoSetDimensionsToSize( CGSizeMake(50 * aspect.xAspect(), 50 * aspect.yAspect()))
                    messageArray[i].popIn(0.1, duration: 0.5, delay: 0.2, completion: nil )
                }
                dragFlag = true
                break
            default:
                break
            }
        }
    }
    // drag action
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if dragFlag {
            let aTouch = touches.first! as UITouch
            let location = aTouch.locationInView(self.view)
            self.locationX = location.x
            self.locationY = location.y
            // 移動した距離
            dragX = location.x - firstPoint!.x
            dragY =  location.y - firstPoint!.y
            homeView.setMessageData(messagePlaceholder(dragX, dragY: dragY))
        }
    }
    
    // TapEnd Event
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        // icon deleate
        if dragFlag {
            for i in 0 ... 3{
                messageArray[i].popOut(0.1, duration: 0.5, delay: 0.2, completion: {(Bool)-> Void in
                    self.messageArray[i].removeFromSuperview()
                })
            }
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
            dragFlag = false
            homeView.setMessageData("")
        }
        firstPoint = nil
    }
    // ----------       ------------
    
    
    // ----    choose group     ----
    func chooseGroupCell( sender : Int ){
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setInteger(sender, forKey: "groupData")
        let groupData = ud.objectForKey("groupData") as? Int
        print("send data", groupData! )
        groupView.bounceOut(to:.Left, completion : {(Bool) -> Void in (
            self.groupView.hidden = true,
            self.hideView.hidden = true,
            self.homeView.setMember(self.groupView.getGroupData()[sender])
            )}
        )
    }
    // ----                     ----
    
    // list reload
    func reloadList(){
        let groupModel = GroupModel.sharedManager
        let ud = NSUserDefaults.standardUserDefaults()
        let id = ud.objectForKey("id") as! String
        let userData = id
        print("UserData : " , userData ) // Debug
        // get gropdata
        groupModel.getGroup(userData, success: { (res: JSON) -> Void in
            // success
            var dic : [JSON] = []
            for i in 0..<res["res"].count {
                dic.append(res["res"][i])
            }
            self.groupView.setGroupData( dic )
            
            },
            error: { (res: JSON) -> Void in
                // error
                let alert = groupModel.errorAlert(res)
                self.presentViewController(alert, animated: true, completion: nil)
        })
    }
    
    //
    func messagePlaceholder( drafX : CGFloat, dragY : CGFloat ) ->String {
        var placholder : String = ""
        if self.dragX > 0 {
            placholder = (self.dragY >= 0) ? "今日集まれる人":"来れる人"
        }else{
            placholder = (self.dragY <= 0) ? "飲みにく人":"今研究室にいる人"
        }
        return placholder
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
