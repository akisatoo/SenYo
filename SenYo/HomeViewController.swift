//
//  HomeViewController.swift
//  SenYo
//
//  Created by takahashi akisato on 2016/08/31.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, HomeViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "Home"
        let homeView = HomeView()
        homeView.delegate = self
        self.view = homeView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonTouched(sender:UIButton) {
        let noticeView = NoticeViewController()
        self.navigationController?.pushViewController(noticeView, animated: true)
    }
    
}
