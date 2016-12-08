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

class MakeGroupViewController : UIViewController, MakeGroupViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    private let TRANSITION = 1
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
        createGroupButton.action = "createButtonClick:"
        createGroupButton.target = self
        createGroupButton.tintColor = UIColor.clearColor()
        createGroupButton.tag = 1
        self.navigationItem.rightBarButtonItem = createGroupButton
        
        //
        placeView.backgroundColor = UIColor(white: 0.3, alpha: 0.5)
        placeView.userInteractionEnabled = true
        placeView.hidden = true
        placeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "viewTapped:"))
        memberView.hidden = true
        setSearchList()
        self.view.addSubview( placeView )
        self.view.addSubview( memberView )
        memberView.setAutoLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // メンバーViewを作成
    func pushButton(sender : UIButton ){
        placeView.hidden = false
        memberView.hidden = false
        memberView.popIn(0.1, duration: 0.6, delay: 0.1, completion: nil )
    }
   
    // memberView deleate
    func viewTapped( sender : UITapGestureRecognizer ){
        makeGroupView.setList(memberView.getList())
        memberView.selectUser.removeAll()
        self.memberView.popOut(1, duration: 0.6, delay: 0.1, completion : { (Bool) -> Void in
            self.placeView.hidden = true
            self.memberView.hidden = true
         })
    }
    
    //
    func createButtonClick( sender : UIBarButtonItem ){
        switch( sender.tag ){
        case TRANSITION:
            let groupModel = GroupModel.sharedManager
            var groupData = Group()
            let ud = NSUserDefaults.standardUserDefaults()
            let id = ud.objectForKey("id") as! String
            groupData.leader_id = id
            groupData.members = makeGroupView.member
            groupData.name = makeGroupView.groupName.text!
            if makeGroupView.member != [] {
                memberView.selectUser = makeGroupView.getMember() as! [String]
            }
            
            groupModel.createGroup(groupData, success: { (res: JSON) -> Void in
                // success
                print("Create Group!")
                let myView : UIViewController = HomeViewController()
                self.navigationController?.pushViewController(myView, animated: true )
                },
                error: { (res: JSON) -> Void in
                    // error
                    let alert = groupModel.errorAlert(res)
                    self.presentViewController(alert, animated: true, completion: nil)
            })
            break
        default:
            break
        }
    }
    
    // image Clicked Action
    func imageTapped( sender: UITapGestureRecognizer ) {
        let ipc: UIImagePickerController = UIImagePickerController();
        ipc.delegate = self
        UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(ipc, animated:true, completion:nil)
    }
    
    // album image select
    func imagePickerController(picker: UIImagePickerController, var didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        // close album
        picker.dismissViewControllerAnimated(true, completion: nil);
        
        // resize to image
        let resizeImage = resize(image, width: 480, height: 320)
        image = resizeImage
        makeGroupView.groupImage.image = resizeImage
    }
    
    // image make
    func resize(image: UIImage, width: Int, height: Int) -> UIImage {
        //let imageRef: CGImageRef = image.CGImage!
        //var sourceWidth: Int = CGImageGetWidth(imageRef)
        //var sourceHeight: Int = CGImageGetHeight(imageRef)
        
        let size: CGSize = CGSize(width: width, height: height)
        UIGraphicsBeginImageContext(size)
        image.drawInRect(CGRectMake(0, 0, size.width, size.height))
        
        let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizeImage
    }
    
    func setSearchList(){
        let userModel = UserModel.sharedManager
        let ud = NSUserDefaults.standardUserDefaults()
        let account_id : String = ud.objectForKey("user_id") as! String
        // set gropdata
        userModel.userSearch(account_id, success: { (res: JSON) -> Void in
                // success
                self.memberView.setList(res)
            },
            error: { (res: JSON) -> Void in
                // error
                let alert = userModel.errorAlert(res)
                self.presentViewController(alert, animated: true, completion: nil)
        })
        
    }
}