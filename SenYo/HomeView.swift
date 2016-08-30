//
//  HomeView.swift
//  SenYo
//
//  Created by takahashi akisato on 2016/08/31.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//


import UIKit
import PureLayout

protocol HomeViewDelegate: NSObjectProtocol {}

class HomeView: UIView {
    var delegate: HomeViewDelegate?
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init() {
        super.init(frame: CGRectMake(0, 0, 0, 0));
        self.backgroundColor = UIColor.blueColor()
        
        
        // Buttonを生成する.
        let myButton = UIButton()
        // サイズを設定する.
        myButton.frame = CGRectMake(0,0,200,40)
        // 背景色を設定する.
        myButton.backgroundColor = UIColor.redColor()
        // 枠を丸くする.
        myButton.layer.masksToBounds = true
        // タイトルを設定する(通常時).
        myButton.setTitle("Open Notice", forState: UIControlState.Normal)
        myButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        // コーナーの半径を設定する.
        myButton.layer.cornerRadius = 20.0
        // タグを設定する.
        myButton.tag = 1
        // イベントを追加する.
        myButton.addTarget(delegate, action: "buttonTouched:", forControlEvents: .TouchUpInside)
        // ボタンをViewに追加する.
        self.addSubview(myButton)
        // ボタンの位置を指定する.
        myButton.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 60)
        myButton.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: 16)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}