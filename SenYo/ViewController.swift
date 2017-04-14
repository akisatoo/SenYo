//
//  ViewController.swift
//  SenYo
//
//  Created by takahashi akisato on 2016/07/31.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import UIKit
import PureLayout

var myBoundSize: CGSize = UIScreen.mainScreen().bounds.size
class ViewController: UIViewController {
    var logoImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.whiteColor()
        
        //imageView作成
        self.logoImageView = UIImageView(frame: CGRectMake(0, 0, 204, 77))
        //画面centerに
        self.logoImageView.center = self.view.center
        //logo設定
        self.logoImageView.image = UIImage(named: "logo")
        //viewに追加
        self.view.addSubview(self.logoImageView)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        //少し縮小するアニメーション
        UIView.animateWithDuration(0.3,
                                   delay: 1.0,
                                   options: UIViewAnimationOptions.CurveEaseOut,
                                   animations: { () in
                                    self.logoImageView.transform = CGAffineTransformMakeScale(0.9, 0.9)
            }, completion: { (Bool) in
                
        })
        
        //拡大させて、消えるアニメーション
        UIView.animateWithDuration(0.2,
                                   delay: 1.3,
                                   options: UIViewAnimationOptions.CurveEaseOut,
                                   animations: { () in
                                    self.logoImageView.transform = CGAffineTransformMakeScale(1.2, 1.2)
                                    self.logoImageView.alpha = 0
            }, completion: { (Bool) in
                self.logoImageView.removeFromSuperview()
                let ud = NSUserDefaults.standardUserDefaults()
                let isLogin = ud.objectForKey("id")
                if ( isLogin == nil ) {
                    self.beforeLogin()
                } else {
                    self.afterLogin()
                }
                
        })        
    }
    
    //ログイン前のViewを表示(Login画面)
    func beforeLogin() {
        let loginView: LoginViewController = LoginViewController()
        self.presentViewController(loginView, animated: true, completion: nil)
    }
    // Home画面を表示
    func afterLogin() {
        let mainNavigationController: UINavigationController?
        let homeView: HomeViewController = HomeViewController()
        mainNavigationController = UINavigationController(rootViewController: homeView)
        self.presentViewController(mainNavigationController!, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

