//
//  MakeGroupViewController.swift
//  SenYo
//
//  Created by 松江飛雄馬 on 2016/09/03.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import Foundation
import UIKit
import PureLayout
import SimpleAnimation
import Alamofire
import SwiftyJSON

class MakeGroupViewController : UIViewController, MakeGroupViewDelegate{
    private let memberView  = MemberView()
    private let makeGroupView = MakeGroupView()
    private let placeView = UIView(frame: CGRectMake(0, 0, myBoundSize.width, myBoundSize.height ) )
    private let createGroupButton = UIBarButtonItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        self.title = "新規グループ作成"
        makeGroupView.delegate = self
        self.view = makeGroupView
        createGroupButton.image = UIImage(named: "menu")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        createGroupButton.style = UIBarButtonItemStyle.Plain
        //createGroupButton.title = "作成"
        createGroupButton.action = "createButtonClick:"
        createGroupButton.target = self
        createGroupButton.tintColor = UIColor.clearColor()
        createGroupButton.tag = 1
        self.navigationItem.rightBarButtonItem = createGroupButton
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // メンバーViewを作成
    func pushButton(sender : UIButton ){
       // let makeGroupView = MakeGroupView()
        placeView.backgroundColor = UIColor(white: 0.3, alpha: 0.5)
        placeView.userInteractionEnabled = true
        placeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "viewTapped:"))
        self.view.addSubview( placeView )
        self.view.addSubview( memberView )
        memberView.setAutoLayout()
        memberView.popIn(0.1, duration: 0.6, delay: 0.1, completion: nil )
        print("success")
        //let myView = MemBerViewContoller()
        //self.navigationController?.pushViewController(myView, animated: true)
    }
   
    // memberView deleate
    func viewTapped( sender : UITapGestureRecognizer ){
        makeGroupView.setList(memberView.getList())
        makeGroupView.reload()
        self.memberView.popOut(1, duration: 0.6, delay: 0.1, completion : { (Bool) -> Void in
            self.placeView.removeFromSuperview()
            self.memberView.removeFromSuperview()
        })
    }
    
    //
    func createButtonClick( sender : UIBarButtonItem ){
        switch( sender.tag ){
        case 1:
            let groupModel = GroupModel.sharedManager
            var groupData = Group()
            let ud = NSUserDefaults.standardUserDefaults()
            let id = ud.objectForKey("id")
            
            // 必要な情報を入れる
            groupData.leader_id = id as! String
            groupData.members = makeGroupView.member
            groupData.name = makeGroupView.groupName.text!
            
            groupModel.createGroup(groupData, success: { (res: JSON) -> Void in
                // success
                //ローカルにログイン情報を保持
                let id = String(res["res"]["_id"])
                let ud = NSUserDefaults.standardUserDefaults()
                ud.setObject(id, forKey: "id")
                },
                error: { (res: JSON) -> Void in
                    // error
                    let alert = groupModel.errorAlert(res)
                    self.presentViewController(alert, animated: true, completion: nil)
            })
            
            print("Create Group!")
            break
        default:
            break
        }
        
    }
}