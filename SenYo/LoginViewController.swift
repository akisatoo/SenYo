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
        
        let loginView = LoginView()
        loginView.delegate = self
        self.view = loginView
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func buttonTouched(sender:UIButton) {
        //ログイン後画面へ遷移
        self.appDelegate.afterLogin()
    }
    
}

