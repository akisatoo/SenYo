//
//  HomeView.swift
//  SenYo
//
//  Created by takahashi akisato on 2016/08/31.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//


import UIKit
import PureLayout

protocol HomeViewDelegate: NSObjectProtocol {
    func clickButton( sender : UIBarButtonItem )
}

class HomeView: UIView, UIToolbarDelegate {
    
    var delegate: HomeViewDelegate?
    private var userArray : [[UIImageView]] = [[UIImageView]]()
    private var myToolbar: UIToolbar!
    var aspect = Aspect()
    
    required init() {
        super.init(frame: CGRectMake(0, 0, 0, 0));
        self.backgroundColor = UIColor.whiteColor()
        let myImage = UIImage(named: "hironaka.jpg")
        let leader = UIImageView()
        let balloon = BalloonView(frame: CGRectMake((myBoundSize.width - 280) / 2, 100, 280, 100))
        let views = UIView(frame: CGRectMake( 0, 0, 500 * aspect.xAspect(), 500 * aspect.yAspect() ))
        let myScrollView = UIScrollView()
        let leaderSize = 100 * aspect.yAspect()
        leader.layer.cornerRadius = leaderSize / 2
        leader.backgroundColor = UIColor.whiteColor()
        leader.layer.borderColor = UIColor.blueColor().CGColor
        leader.layer.borderWidth = 2.0
        leader.layer.masksToBounds = true
        leader.image = myImage
        myScrollView.backgroundColor = UIColor.whiteColor()
        balloon.backgroundColor = UIColor.whiteColor()
        self.addSubview(myScrollView)
        
        
        // User 配置
        for i in 0...6 {
            userArray.append([])
            for j in 0...2 {
                var xWidth = 30
                let userSize = 70 * aspect.yAspect()
                let myImageView = UIImageView()
                let userName = UILabel(frame: CGRectMake( 0, 0, 100 * aspect.xAspect(), 50  * aspect.yAspect() ))
                userName.text = "name"
                myImageView.image = myImage
                myImageView.layer.cornerRadius = userSize / 2
                userArray[i].append(myImageView)
                if j % 2 != 0  {
                    xWidth = 100
                }
                userArray[i][j].backgroundColor = UIColor.whiteColor()
                userArray[i][j].layer.borderColor = UIColor.redColor().CGColor
                userArray[i][j].layer.borderWidth = 2.0
                userArray[i][j].layer.masksToBounds = true
                myScrollView.addSubview( userArray[i][j] )
                myScrollView.addSubview( userName )
                userArray[i][j].autoSetDimensionsToSize( CGSizeMake( userSize, userSize ) )
                userArray[i][j].autoPinEdgeToSuperviewEdge( .Top, withInset:  CGFloat(  -45 + 90 * j  ) * aspect.yAspect() )
                userArray[i][j].autoPinEdgeToSuperviewEdge( .Left, withInset: CGFloat( xWidth + 150 * i ) * aspect.xAspect())
                userName.autoPinEdgeToSuperviewEdge( .Top, withInset: CGFloat( 30 + 90 * j ) * aspect.yAspect() )
                userName.autoPinEdgeToSuperviewEdge( .Left, withInset: CGFloat(xWidth + 10 + 150 * i) * aspect.xAspect()  )
            }
        }
        // Scrollできる幅の設定
        myScrollView.contentSize = CGSizeMake( ( CGFloat(userArray[0].count ) * (CGFloat(userArray.count) * 52) ) * aspect.xAspect(), myScrollView.frame.size.height * aspect.yAspect() )
        // Toolbarの設定
        myToolbar = UIToolbar(frame: CGRectMake( 0, myBoundSize.height - 44, myBoundSize.width, 40.0))
        myToolbar.layer.position = CGPoint(x: myBoundSize.width/2, y: myBoundSize.height-20.0)
        myToolbar.barStyle = UIBarStyle.Default
        myToolbar.tintColor = UIColor.blackColor()
        let flexibleItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let settingButton = UIBarButtonItem()
        settingButton.image = UIImage(named: "setting.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        settingButton.style = UIBarButtonItemStyle.Plain
        settingButton.action = "clickButton:"
        settingButton.target = delegate
        settingButton.tag = 1
        settingButton.tintColor = UIColor.clearColor()
        let groupButton = UIBarButtonItem()
        groupButton.image = UIImage(named: "group.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        groupButton.style = UIBarButtonItemStyle.Plain
        groupButton.action = "clickButton:"
        groupButton.target = delegate
        groupButton.tintColor = UIColor.clearColor()
        groupButton.tag = 2
        myToolbar.items = [settingButton, flexibleItem, groupButton]
        
        //addsubview
        self.addSubview(myToolbar)
        self.addSubview(views)
        views.addSubview(leader)
        //views.addSubview(balloon)
        
        //autolayout
        views.autoPinEdgeToSuperviewEdge(.Top, withInset : 34 )
        views.autoPinEdge(.Bottom, toEdge: .Top, ofView: myScrollView, withOffset: 0)
        leader.autoSetDimensionsToSize( CGSizeMake( leaderSize, leaderSize ))
        leader.autoCenterInSuperview()
        leader.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset:  ( myBoundSize.width / 2 - leaderSize / 2 )  )
        myScrollView.autoSetDimensionsToSize( CGSizeMake(myBoundSize.width, myBoundSize.height / 2 ))
        myScrollView.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 35 * aspect.yAspect())
        
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}