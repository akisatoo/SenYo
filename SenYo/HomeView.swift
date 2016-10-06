//
//  HomeView.swift
//  SenYo
//
//  Created by takahashi akisato on 2016/08/31.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//


import UIKit
import PureLayout
import SimpleAnimation

protocol HomeViewDelegate: NSObjectProtocol {
}

class HomeView: UIView {
    let appdelegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var delegate: HomeViewDelegate?
    var goupView : UIView = GroupView()
    private var userArray : [[UIImageView]] = [[UIImageView]]()
    var aspect = Aspect()
    
    required init() {
        super.init(frame: CGRectMake(0, 0, 0, 0));
        self.backgroundColor = UIColor.whiteColor()
        let myImage = UIImage(named: "hironaka")
        let leader = UIImageView()
        let views = UIView(frame: CGRectMake( 0, 0, 500 * aspect.xAspect(), 500 * aspect.yAspect() ))
        let myScrollView = UIScrollView()
        
        let leaderSize = 100 * aspect.yAspect()
        leader.layer.cornerRadius = leaderSize / 2
        leader.backgroundColor = UIColor.whiteColor()
        leader.layer.borderColor = UIColor.blueColor().CGColor
        leader.layer.borderWidth = 2.0
        leader.layer.masksToBounds = true
        leader.userInteractionEnabled = true
        leader.tag = 1
        leader.image = myImage
        myScrollView.backgroundColor = UIColor.whiteColor()
               
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
                userName.autoPinEdgeToSuperviewEdge( .Left, withInset: CGFloat(xWidth + 10 + 150 * i) * aspect.xAspect() )
            }
        }
        // Scrollできる幅の設定
        myScrollView.contentSize = CGSizeMake( ( CGFloat(userArray[0].count ) * (CGFloat(userArray.count) * 52) ) * aspect.xAspect(), myScrollView.frame.size.height * aspect.yAspect() )
        
        //addsubview
        self.addSubview(views)
        views.addSubview(leader)
       // self.appdelegate.window?.addSubview(goupView)
        
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