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
import SocketIO

enum HomeViewError : ErrorType{
    case OutOfRange
}

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
    private let connect = ConnentModel.sharedManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        
        // connect
        connect.send_mes()
        
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
        menuItem.action = "click_bar_button:"
        menuItem.target = self
        menuItem.tintColor = UIColor.clearColor()
        menuItem.tag = 1
        self.navigationItem.rightBarButtonItem = menuItem
        groupItem.image = UIImage(named: "group")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        groupItem.style = UIBarButtonItemStyle.Plain
        groupItem.action = "click_bar_button:"
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
        
        // set groupData
        let ud = NSUserDefaults.standardUserDefaults()
        let group_cel_no = ud.objectForKey("groupData") as? Int
        if group_cel_no != nil {
            self.homeView.setMember(self.groupView.getGroupData()[group_cel_no!]) //error
        }
        //  
        if ud.objectForKey( "choose_group" ) != nil {
          let chooseGroup = ud.objectForKey( "choose_group" ) as! Int
          chooseGroupCell(chooseGroup)
        }
    }
    
    // ナビゲーションバーボタンのアクション
    private var menuView_show = 1, groupView_show = 2, menuView_hidden = 3
    internal func click_bar_button( sender : UIBarButtonItem ){
        switch(sender.tag){
        case menuView_show:
            sender.tag = 3
            menuView.hidden = false
            break
        case groupView_show:
            self.hideView.hidden = false
            self.hideView.fadeIn(0.4, delay: 0.3, completion: nil)
            self.groupView.hidden = false
            self.groupView.bounceIn(from: .Left, x: myBoundSize.width / 2 * -1, y: 0, duration: 0.3, delay: 0, completion: nil)
            break
        case menuView_hidden:
            sender.tag = 1
            menuView.hidden = true
            break
        default:
            print("error")
            break
        }
    }
    
    // グループビューを隠す
    func deleteSideMenu(sender: UITapGestureRecognizer){
        groupView.bounceOut(to:.Left, completion : {(Bool) -> Void in (
           self.groupView.hidden = true,
           self.hideView.hidden = true
            )}
        )
    }
    
    //
    private var newsView_trans = 0, progileView_trans = 1, logout = 2
    func chooseCell( sender : Int ){
        var myView : UIViewController!
        switch (sender){
        case newsView_trans:
            myView = NewsViewController()
            self.navigationController?.pushViewController(myView, animated: true)
            break;
        case progileView_trans:
            myView = ProfileViewController()
            self.navigationController?.pushViewController(myView, animated: true)
            break;
        case logout:
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
    
    //
    internal func groupMakeButton(sender: UIButton){
        let myView : UIViewController = MakeGroupViewController()
        self.navigationController?.pushViewController(myView, animated: true )
        self.groupView.hidden = true
        self.hideView.hidden = true
    }
    
    //
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        for touch: UITouch in touches {
            let tag = touch.view!.tag
            switch tag {
            case 1:
                let firstTouch = touches.first!
                firstPoint = firstTouch.locationInView(self.view)
                
                let BUTTON_LENGTH = 3
                for i in 0 ... BUTTON_LENGTH{
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
    
    // ドラッグイベント処理
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
    
    //
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        //メッセージを送る
        let connect = ConnentModel.sharedManager
        let mes : String?
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
                    mes = "right_bottom"
                    connect.socket.emit("post_message", mes!)
                    
                }else{
                    mes = "right_up"
                    connect.socket.emit("post_message", mes!)
                    //右上
                }
            }else{
                if self.dragY <= 0 {
                    //左上
                    mes = "left_top"
                    connect.socket.emit("post_message", mes!)
                }else{
                    //左下
                    mes = "left_bottom"
                    connect.socket.emit("post_message", mes!)
                }
            }
            dragFlag = false
            homeView.setMessageData("")
        }
        firstPoint = nil
    }
    
    // 選択したグループに対する処理
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
        ud.setObject(sender, forKey: "choose_group")
    }
    
    // グループリストの再読込
    func reloadList(){
        let groupModel = GroupModel.sharedManager
        let ud = NSUserDefaults.standardUserDefaults()
        let id = ud.objectForKey("id") as! String
        print("UserData : " , id ) // Debug
        // get gropdata
        groupModel.getGroup(id, success: { (res: JSON) -> Void in
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
