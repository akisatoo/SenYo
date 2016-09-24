//
//  MakeGroupViewController.swift
//  SenYo
//
//  Created by 松江飛雄馬 on 2016/09/03.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import Foundation
import UIKit
import PureLayout
import SimpleAnimation

class MakeGroupViewController : UIViewController, MakeGroupViewDelegate{
    private let memberView  = MemberView()
    private let placeView = UIView(frame: CGRectMake(0, 0, myBoundSize.width, myBoundSize.height ) )
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
    
    // メンバーViewを作成
    func pushButton(sender : UIButton ){
       // let makeGroupView = MakeGroupView()
        
        placeView.backgroundColor = UIColor(white: 0.3, alpha: 0.5)
        placeView.userInteractionEnabled = true
        placeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "viewTapped:"))
        self.view.addSubview( placeView )
        self.view.addSubview( memberView )
        memberView.setAutoLayout()
        memberView.popIn(0.1, duration: 0.6, delay: 0.1, completion: nil )
        print("success")
        //let myView = MemBerViewContoller()
        //self.navigationController?.pushViewController(myView, animated: true)
    }
    
    // 値の受け取り
    override func viewWillAppear(animated: Bool) {
        super.viewDidDisappear(animated)
        var imageView = [UIImageView]()
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let userArray = appDelegate.message
        if userArray != [] {
            for i in 0...userArray.endIndex - 1 {
                imageView.append(UIImageView())
                imageView[i].backgroundColor = UIColor.blueColor()
                imageView[i].layer.cornerRadius = 40.0
                self.view.addSubview(imageView[i])
                imageView[i].autoSetDimensionsToSize( CGSizeMake( 80, 80 ) )
                imageView[i].autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: 500 )
                imageView[i].autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: CGFloat( 20 + i * 150 ))
            }
        }
    }
    // view 削除
    func viewTapped( sender : UITapGestureRecognizer ){
        self.memberView.popOut(1, duration: 0.6, delay: 0.1, completion : { (Bool) -> Void in
            self.placeView.removeFromSuperview()
            self.memberView.removeFromSuperview()
        })
    }
}