//
//  LoginViewController.swift
//  SenYo
//
//  Created by takahashi akisato on 2016/08/27.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SimpleAnimation
import Foundation


class LoginViewController: UIViewController, LoginViewDelegate, UITextFieldDelegate{
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    private var userLabel : String = ""
    private var passLabel : String = ""
    var loginView: LoginView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print( "DeviceWidth : ", myBoundSize.width, " DeviceHeigh : ", myBoundSize.height )
        loginView = LoginView()
        loginView!.delegate = self
        self.view = loginView
    }
    
    
    // Button Action
    func buttonTouched( sender : UIButton ) {
        switch ( sender.tag ){
        case 1:
            print("Login!")
            let userModel = UserModel.sharedManager
            var userData = User()
            userData.account_id = (loginView?.userTextFiled.text)!
            userData.password = (loginView?.passTextFiled.text)!
            userModel.login(userData, success: { (res: JSON) -> Void in
                // success
                //ローカルにログイン情報を保持
                let id : String = String(res["res"]["_id"])
                let password : String = String(res["res"]["password"])
                let account_id : String = String(res["res"]["account_id"])
                let name : String = String(res["res"]["name"])
                let image_url = NSURL(string: String(res["res"]["image"]))
                let error : NSError?
                var imageData : NSData!
                var img : UIImage!
                do{
                    imageData = try NSData(contentsOfURL: image_url!, options: .DataReadingMappedIfSafe )
                        img = UIImage(data:imageData);
                    
                }catch{
                    print("Error: can't create image.")
                }
                let ud = NSUserDefaults.standardUserDefaults()
                ud.setObject(id, forKey: "id")
                ud.setObject(password, forKey: "password")
                ud.setObject(name, forKey: "img")
                ud.setObject(account_id, forKey: "account_id")
                
                ud.setObject(self.loginView?.userTextFiled.text, forKey: "user_id")
                self.appDelegate.afterLogin()
            },
            error: { (res: JSON) -> Void in
                // error   
                let alert = userModel.errorAlert(res)
                self.presentViewController(alert, animated: true, completion: nil)
            })
        break;
        case 2:
            let mySecondViewController: UIViewController = AccountMakeViewContoller()
            self.presentViewController(mySecondViewController, animated: true, completion: nil)
            break;
        default:
            break
        }
    }
    
    //
    func textFieldDidChange(textField: UITextField){
        switch ( textField.tag ){
        case 1:
            userLabel = textField.text!
            print( "user : ", userLabel)
            break;
        case 2:
            passLabel = textField.text!
            print("pass : ", passLabel)
            break;
        default:
            break
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

