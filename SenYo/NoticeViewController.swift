//
//  NoticeViewController.swift
//  SenYo
//
//  Created by takahashi akisato on 2016/08/31.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import UIKit

class NoticeViewController: UIViewController, NoticeViewDelegate, UIViewControllerTransitioningDelegate{
    let kAnimator = Animator()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "Notice"
        let noticeView = NoticeView()
        noticeView.delegate = self
        self.view = noticeView
        self.transitioningDelegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // この画面に遷移してくるときに呼ばれるメソッド
        return kAnimator
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // この画面から遷移元に戻るときに呼ばれるメソッド
        return kAnimator
    }
}
