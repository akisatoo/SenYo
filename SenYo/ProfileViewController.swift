//
//  SettingViewController.swift
//  SenYo
//
//  Created by 松江飛雄馬 on 2016/08/31.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController, ProfileViewDelegate, MessageViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let GROUP_MAKE = 1
    let MESSAGE_EDIT = 2
    let PASS_CHANGE = 3
    let SIGN_OUT = 4
    let profileView = ProfileView()
    let messageView = MessageView()
    var trantionView : UIViewController!
    let hideView = UIView(frame: CGRectMake(0, 0, myBoundSize.width, myBoundSize.height))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit Profile"
        self.view = profileView
        profileView.delegate = self
        messageView.delegate = self
        hideView.backgroundColor = UIColor( white : 0, alpha : 0.5 )
        profileView.userImage.userInteractionEnabled = true
        profileView.userImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "imageTapped:"))
        messageView.hidden = true
        hideView.hidden = true
        self.hideView.userInteractionEnabled = true
        self.hideView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "deleteView:"))
        self.appDelegate.window?.addSubview(hideView)
        self.appDelegate.window?.addSubview(messageView)
        messageView.autoLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Button Action
    func buttonAction( sender: UIButton ){
        switch sender.tag {
        case GROUP_MAKE:
            trantionView = MakeGroupViewController()
            self.navigationController?.pushViewController(trantionView, animated: true)
            break
        case MESSAGE_EDIT:
            self.messageView.popIn(0.3, delay: 0.2, completion: nil)
            messageView.hidden = false
            self.hideView.fadeIn(0.3, delay: 0.2, completion: nil)
            hideView.hidden = false
            break
        case PASS_CHANGE:
            break
        case SIGN_OUT:
            // logout
            let ud = NSUserDefaults.standardUserDefaults()
            ud.removeObjectForKey("id")
            ud.removeObjectForKey("user_id")
            self.appDelegate.beforeLogin()
            break
        default:
            print( "debug ") // debug
            break
        }
    }
    
    // Image Clicked Action
    func imageTapped(sender: UITapGestureRecognizer ) {
        let ipc: UIImagePickerController = UIImagePickerController();
        ipc.delegate = self
        UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(ipc, animated:true, completion:nil)
    }
    
    // MessageView Deleate
    func deleteView(sender: UITapGestureRecognizer){
        self.messageView.popOut(0.3, delay: 0.2, completion: {(Bool) -> Void in (
            self.messageView.hidden = true,
            self.hideView.hidden = true
            )}
        )
    }
    
    // 画像が選択されたときによばれます
    func imagePickerController(picker: UIImagePickerController, var didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        picker.dismissViewControllerAnimated(true, completion: nil);
        let resizeImage = resize(image, width: 480, height: 320)
        image = resizeImage
        profileView.userImage.image = resizeImage
    }
    
    //
    func resize(image: UIImage, width: Int, height: Int) -> UIImage {
        //let imageRef: CGImageRef = image.CGImage!
        // var sourceWidth: Int = CGImageGetWidth(imageRef)
        //var sourceHeight: Int = CGImageGetHeight(imageRef)
        
        let size: CGSize = CGSize(width: width, height: height)
        UIGraphicsBeginImageContext(size)
        image.drawInRect(CGRectMake(0, 0, size.width, size.height))
        
        let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizeImage
    }
}
