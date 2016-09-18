//
//  LoginViewController.swift
//  SenYo
//
//  Created by takahashi akisato on 2016/08/27.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import UIKit
import Foundation

class LoginViewController: UIViewController, LoginViewDelegate {
    
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        print( "DeviceWidth : ", myBoundSize.width, " DeviceHeigh : ", myBoundSize.height )
        let loginView = LoginView()
        loginView.delegate = self
        self.view = loginView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func buttonTouched(sender:UIButton) {
        switch ( sender.tag ){
        case 1:
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
}

