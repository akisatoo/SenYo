//
//  MakeGroupViewController.swift
//  SenYo
//
//  Created by 松江飛雄馬 on 2016/09/03.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import Foundation
import UIKit

class MakeGroupViewController : UIViewController, MakeGroupViewDelegate{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "新規グループ作成"
        let makeGroupView = MakeGroupView()
        makeGroupView.delegate = self
        self.view = makeGroupView
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func pushButton(sender : UIButton ){
        let myView = MemBerViewContoller()
        self.navigationController?.pushViewController(myView, animated: true)

    }
}