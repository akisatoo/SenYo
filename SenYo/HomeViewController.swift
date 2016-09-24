//
//  HomeViewController.swift
//  SenYo
//
//  Created by takahashi akisato on 2016/08/31.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import UIKit
//import SwiftyJSON
//import Alamofire

class HomeViewController: UIViewController, HomeViewDelegate, UIViewControllerTransitioningDelegate{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        let homeView = HomeView()
        let menuItem = UIBarButtonItem()
        let groupItem = UIBarButtonItem()
        homeView.delegate = self
        self.view = homeView
        // self.navigationController?.navigationBar.barTintColor = UIColor.blueColor()
        menuItem.image = UIImage(named: "menu")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        menuItem.style = UIBarButtonItemStyle.Plain
        menuItem.action = "clickButton:"
        menuItem.target = self
        menuItem.tintColor = UIColor.clearColor()
        menuItem.tag = 1
        self.navigationItem.rightBarButtonItem = menuItem
        groupItem.image = UIImage(named: "group")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        groupItem.style = UIBarButtonItemStyle.Plain
        groupItem.action = "clickButton:"
        groupItem.target = self
        groupItem.tintColor = UIColor.clearColor()
        groupItem.tag = 2
        self.navigationItem.leftBarButtonItem = groupItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ボタンアクション
    internal func clickButton( sender : UIBarButtonItem ){
        switch(sender.tag){
        case 1:
            break
        case 2:
            break
        case 3:
            
            break
        default:
            print("error")
        }
    }
    
    /*func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    
    return kAnimationController
    }*/
}
