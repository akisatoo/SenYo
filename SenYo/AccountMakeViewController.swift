//
//  AccountMakeViewController.swift
//  SenYo
//
//  Created by 松江飛雄馬 on 2016/09/18.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import Foundation
import UIKit

class AccountMakeViewContoller : ViewController, AccountMakeViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        let accountMake = AccountMakeView()
        self.view = accountMake
        accountMake.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func buttonTouched(sendre : UIButton ){
        let myView = LoginViewController()
        self.presentViewController(myView, animated: true, completion: nil)}
    
}