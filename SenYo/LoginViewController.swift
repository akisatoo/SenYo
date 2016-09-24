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
    override func viewDidLoad() {
        super.viewDidLoad()
        print( "DeviceWidth : ", myBoundSize.width, " DeviceHeigh : ", myBoundSize.height )
        let loginView = LoginView()
        loginView.delegate = self
        loginView.userTextFiled.delegate = self
        loginView.passTextFiled.delegate = self
        self.view = loginView
                // -----    ---------
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // Button Action
    func buttonTouched(sender:UIButton) {
        switch ( sender.tag ){
        case 1:
            /*
            // ログインできるか確認
            let params =
            [
            "password": "password",
            "account_id":"hyuma"
            ]
            
            // ---- jsonを取る -------
            Alamofire.request(.POST, "http://127.0.0.1:3000/api/user/login", parameters: params).responseJSON{ response in
            guard let object = response.result.value else {
            return
            }
            
            let json = JSON(object)
            if json["name"] == self.userLabel && json["password"] == self.passLabel {
                // 遷移
            }
            print(json["name"])
            }
            */

            self.appDelegate.afterLogin()
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
}

