//
//  SettingViewController.swift
//  SenYo
//
//  Created by 松江飛雄馬 on 2016/08/31.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController, ProfileViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    let profileView = ProfileView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit Profile"
        self.view = profileView
        profileView.delegate = self
        profileView.userImage.userInteractionEnabled = true
        profileView.userImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "imageTapped:"))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    internal func signIn( sender: UIButton ){
        print( "debug ") // debug 
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
        profileView.userImage.image = resizeImage
    }
    
    // image make
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