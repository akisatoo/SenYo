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
    private var userArray : [[UIImageView]] = [[UIImageView]]()
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init() {
        super.init(frame: CGRectMake(0, 0, 0, 0));
        self.backgroundColor = UIColor.blueColor()
        let myImage = UIImage(named: "no_image.jpg")
        let leader = UIImageView()
        let noticeButton = UIButton()
        let settingButton = UIButton()
        let myScrollView = UIScrollView()
        
        //noticeButton.frame = CGRectMake(0,0,200,40)
        noticeButton.backgroundColor = UIColor.redColor()
        noticeButton.layer.masksToBounds = true
        noticeButton.setTitle("Open Notice", forState: UIControlState.Normal)
        noticeButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        noticeButton.layer.cornerRadius = 20.0
        noticeButton.tag = 1
        noticeButton.addTarget(delegate, action: "clickButton:", forControlEvents: .TouchUpInside)
        
        //settingButton.frame = CGRectMake(0,0,200,40)
        settingButton.backgroundColor = UIColor.orangeColor()
        settingButton.layer.masksToBounds = true
        settingButton.setTitle("Open Setting", forState: UIControlState.Normal)
        settingButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        settingButton.layer.cornerRadius = 20.0
        settingButton.tag = 2
        settingButton.addTarget(delegate, action: "clickButton:", forControlEvents: .TouchUpInside)
        leader.layer.cornerRadius = 50
        leader.backgroundColor = UIColor.blackColor()
        myScrollView.backgroundColor = UIColor.whiteColor()
        // User 配置
        for i in 0...6 {
            userArray.append([])
            for j in 0...2 {
                var xWidth = 50
                let myImageView = UIImageView( frame: CGRectMake( 0, 0, 70, 70 ))
                let userName = UILabel(frame: CGRectMake( 0, 0, 100, 50 ))
                userName.text = "name"
               // myImageView.image = myImage
                myImageView.layer.cornerRadius = 35
                userArray[i].append(myImageView)
                
                
                if j % 2 != 0  {
                    xWidth = 120
                }
                userArray[i][j].layer.position = CGPointMake( CGFloat(xWidth + 150 * i), CGFloat(70 + 100 * j) )
                userArray[i][j].backgroundColor = UIColor.blackColor()
                userName.layer.position = CGPointMake( CGFloat(xWidth + 30 + 150 * i), CGFloat(120 + 100 * j) )
                myScrollView.addSubview( userArray[i][j] )
                myScrollView.addSubview( userName )
                
                
            }
        }
        // Scrollできる幅の設定
        myScrollView.contentSize = CGSizeMake(userArray[userArray.endIndex - 1][2].layer.position.x + 130, myScrollView.frame.size.height  )
        
        //addsubview
        let leaderView = UIView()
        self.addSubview(noticeButton)
        self.addSubview(settingButton)
        self.addSubview(myScrollView)
        leaderView.addSubview(leader)
        self.addSubview(leaderView)
        //autolayout
        leaderView.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: 64)
        leaderView.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Top, ofView: myScrollView, withOffset: 0)
        leader.autoSetDimensionsToSize(CGSizeMake(100, 100))
        leader.autoCenterInSuperview()
        leader.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: myBoundSize.width / 2 - 50  )
        myScrollView.autoSetDimensionsToSize(CGSizeMake(myBoundSize.width, myBoundSize.height / 2))
        myScrollView.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 50)
        noticeButton.autoSetDimensionsToSize(CGSizeMake(100, 30))
        noticeButton.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 15)
        noticeButton.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: 16)
        settingButton.autoSetDimensionsToSize(CGSizeMake(100,30))
        settingButton.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 15)
        settingButton.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 16)
        /*
        for i in 0...6 {
            for j in 0...2 {
                var xWidth = 50
                
                if j % 2 != 0  {
                    xWidth = 120
                }
                userArray[i][j].autoSetDimensionsToSize(CGSizeMake(500, 200))
                userArray[i][j].autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: myScrollView)
                userArray[i][j].autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 100)
                //CGFloat(xWidth + 150 * i), CGFloat(70 + 100 * j)
                print(" [\(i)][\(j)] : \(userArray[i][j])")
            }
        }
        */
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}