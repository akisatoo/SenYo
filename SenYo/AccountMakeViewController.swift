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


class AccountMakeViewContoller : ViewController, AccountMakeViewDelegate {

    var accountMake: AccountMakeView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accountMake = AccountMakeView()
        self.view = accountMake
        accountMake!.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func buttonTouched(sendre : UIButton ){
        
        let userModel = UserModel.sharedManager
        var userData = User()
        userData.password = accountMake!.passTextField.text!
        userData.account_id = accountMake!.accountTextField.text!
        userData.name = accountMake!.nameTextField.text!
        
        userModel.createUser(userData, success: { (res: JSON) -> Void in
                // success
                let myView = LoginViewController()
                self.presentViewController(myView, animated: true, completion: nil)
            },
            error: { (res: JSON) -> Void in
                // error
                let alert = userModel.errorAlert(res)
                self.presentViewController(alert, animated: true, completion: nil)
        })
        
        
    }
    
}