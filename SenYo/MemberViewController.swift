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
    
    func chooseCell( num : Int ){
        print( "cell : \(num)" )
    }
}