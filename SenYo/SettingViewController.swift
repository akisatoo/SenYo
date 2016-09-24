//
//  SettingViewController.swift
//  SenYo
//
//  Created by 松江飛雄馬 on 2016/08/31.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import Foundation
import UIKit

class SettingViewController: UIViewController, SettingViewDelegate {
    
    override func viewDidLoad() {
        let settingView = SettingView()
        super.viewDidLoad()
        self.title = "Setting"
        self.view = settingView
        settingView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // 遷移
    func moveViews( num : Int ){
        switch( num ){
        case 1:
            let myView = MakeGroupViewController()
            self.navigationController?.pushViewController(myView, animated: true)
            break
        default:
            break
        }
    }
}