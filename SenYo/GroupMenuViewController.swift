//
//  GroupMenuViewController.swift
//  SenYo
//
//  Created by takahashi akisato on 2016/09/25.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import UIKit

class GroupMenuViewController: UIViewController, GroupMenuViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let groupMenuView = GroupMenuView()
        groupMenuView.delegate = self
        self.view = groupMenuView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAnim(complete: () -> Void) {
        self.view.bounceIn(from: .Left, x: 0, duration: 0.5, delay: 0, completion : { (Bool) -> Void in
            complete()
        })
    }
    
    func hideAnim(complete: () -> Void) {
        self.view.bounceOut(to: .Left, x: myBoundSize.width/4, duration: 0.5, delay: 0, completion : { (Bool) -> Void in
            complete()
        })
    }
    
    func chooseCell(sender: Int) {
        
    }
}
