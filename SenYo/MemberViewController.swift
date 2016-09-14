//
//  MemberViewController.swift
//  SenYo
//
//  Created by 松江飛雄馬 on 2016/09/05.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import Foundation
import UIKit

class MemBerViewContoller : UIViewController, MemberViewDelegate {
    var memberArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "メンバー検索"
        let memberView = MemberView()
        self.view = memberView
        memberView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 遷移先に値をセット
    override func viewWillDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.message = memberArray
    }
    
    func chooseCell( name : String ){
        memberArray.append(name)
    }
}