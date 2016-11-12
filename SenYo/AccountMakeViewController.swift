//
//  AccountMakeViewController.swift
//  SenYo
//
//  Created by 松江飛雄馬 on 2016/09/18.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SimpleAnimation
import Foundation
import Photos

class AccountMakeViewContoller : ViewController, AccountMakeViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var accountMakeView: AccountMakeView?
    override func viewDidLoad() {
        super.viewDidLoad()
        accountMakeView = AccountMakeView()
        self.view = accountMakeView
        accountMakeView?.accountImage.userInteractionEnabled = true
        accountMakeView?.accountImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "imageTapped:"))
        accountMakeView!.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Account Make
    func buttonTouched(sender : UIButton ){
        let userModel = UserModel.sharedManager
        var userData = User()
        userData.password = accountMakeView!.passTextField.text!
        userData.account_id = accountMakeView!.accountIDTextField.text!
        userData.name = accountMakeView!.nameTextField.text!
        
       // print("userdate : ", userData)
        userModel.createUser( userData, success: { (res: JSON) -> Void in
                // success
                let myView = LoginViewController()
                self.presentViewController(myView, animated: true, completion: nil)
            },
            error: { (res: JSON) -> Void in
                print("response : ", res )
                // error
                let alert = userModel.errorAlert(res)
                self.presentViewController(alert, animated: true, completion: nil)
        })
    }
    
    // Debug
    func debugButton(sender: UIButton) {
        let myView : UIViewController = LoginViewController()
        self.presentViewController(myView, animated: true, completion: nil)
    }
    
    // Image Clicked Action
    func imageTapped(sender: UITapGestureRecognizer ) {
        let ipc: UIImagePickerController = UIImagePickerController();
        ipc.delegate = self
        UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(ipc, animated:true, completion:nil)
    }
    
    // 画像が選択されたときによばれます
    func imagePickerController(picker: UIImagePickerController, var didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        // アルバム画面を閉じます
        picker.dismissViewControllerAnimated(true, completion: nil);
        
        // 画像をリサイズしてUIImageViewにセット
        let resizeImage = resize(image, width: 480, height: 320)
        image = resizeImage
        accountMakeView?.accountImage.image = resizeImage
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
}