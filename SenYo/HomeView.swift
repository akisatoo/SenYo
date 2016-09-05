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
        let noticeButton = UIButton()
        // サイズを設定する.
        noticeButton.frame = CGRectMake(0,0,200,40)
        // 背景色を設定する.
        noticeButton.backgroundColor = UIColor.redColor()
        // 枠を丸くする.
        noticeButton.layer.masksToBounds = true
        // タイトルを設定する(通常時).
        noticeButton.setTitle("Open Notice", forState: UIControlState.Normal)
        noticeButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        // コーナーの半径を設定する.
        noticeButton.layer.cornerRadius = 20.0
        // タグを設定する.
        noticeButton.tag = 1
        // イベントを追加する.
        noticeButton.addTarget(delegate, action: "clickButton:", forControlEvents: .TouchUpInside)
        // ボタンをViewに追加する.
        self.addSubview(noticeButton)
        // ボタンの位置を指定する.
        noticeButton.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 60)
    
        noticeButton.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: 16)
        // Buttonを生成する.
        
        let settingButton = UIButton()
        // サイズを設定する.
        settingButton.frame = CGRectMake(0,0,200,40)
        // 背景色を設定する.
        settingButton.backgroundColor = UIColor.orangeColor()
        // 枠を丸くする.
        settingButton.layer.masksToBounds = true
        // タイトルを設定する(通常時).
        settingButton.setTitle("Open Setting", forState: UIControlState.Normal)
        settingButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        // コーナーの半径を設定する.
        settingButton.layer.cornerRadius = 20.0
        // タグを設定する.
        settingButton.tag = 2
        // イベントを追加する.
        settingButton.addTarget(delegate, action: "clickButton:", forControlEvents: .TouchUpInside)
        // ボタンをViewに追加する.
        self.addSubview(settingButton)
        // ボタンの位置を指定する.
        settingButton.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 60)
        settingButton.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 16)
        
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}