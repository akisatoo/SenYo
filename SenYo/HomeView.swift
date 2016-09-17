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
        self.backgroundColor = UIColor.blueColor()
        let myImage = UIImage(named: "hironaka.jpg")
        let leader = UIImageView()
        let views = UIView(frame: CGRectMake(0, 0, 300 * aspect.xAspect(), 300 * aspect.yAspect() ))
        let myScrollView = UIScrollView()
        leader.layer.cornerRadius = 50
        leader.backgroundColor = UIColor.whiteColor()
        myScrollView.backgroundColor = UIColor.whiteColor()
        self.addSubview(myScrollView)
        //leader.image = myImage
        
        // User 配置
        for i in 0...6 {
            userArray.append([])
            for j in 0...2 {
                var xWidth = 30
                let userSize = 70 * aspect.yAspect()
                let myImageView = UIImageView()
                let userName = UILabel(frame: CGRectMake( 0, 0, 100 * aspect.xAspect(), 50  * aspect.yAspect() ))
                userName.text = "name"
                //myImageView.image = myImage
                myImageView.layer.cornerRadius = userSize / 2
                userArray[i].append(myImageView)
                if j % 2 != 0  {
                    xWidth = 100
                }
                userArray[i][j].backgroundColor = UIColor.blackColor()
                
                myScrollView.addSubview( userArray[i][j] )
                myScrollView.addSubview( userName )
                userArray[i][j].autoSetDimensionsToSize( CGSizeMake( userSize, userSize ) )
                userArray[i][j].autoPinEdgeToSuperviewEdge( .Top, withInset:  CGFloat(  -35 + 90 * j  ) * aspect.yAspect() )
                userArray[i][j].autoPinEdgeToSuperviewEdge( .Left, withInset: CGFloat(xWidth + 150 * i) * aspect.xAspect())
                userName.autoPinEdgeToSuperviewEdge( .Top, withInset: CGFloat( 40 + 90 * j ) * aspect.yAspect() )
                userName.autoPinEdgeToSuperviewEdge( .Left, withInset: CGFloat(xWidth + 10 + 150 * i) * aspect.xAspect()  )
            }
        }
        // Scrollできる幅の設定
        myScrollView.contentSize = CGSizeMake( ( CGFloat(userArray[0].count ) * (CGFloat(userArray.count) * 52) ) * aspect.xAspect(), myScrollView.frame.size.height * aspect.yAspect() )
        myToolbar = UIToolbar(frame: CGRectMake( 0, myBoundSize.height - 44, myBoundSize.width, 40.0))
        myToolbar.layer.position = CGPoint(x: myBoundSize.width/2, y: myBoundSize.height-20.0)
        myToolbar.barStyle = UIBarStyle.Default
        myToolbar.tintColor = UIColor.blackColor()
        //myToolbar.backgroundColor = UIColor.kColor()
        let myUIBarButtonNotice: UIBarButtonItem = UIBarButtonItem(title: "お知らせ", style:.Plain, target: delegate, action: "clickButton:")
        myUIBarButtonNotice.tag = 1
        let myUIBarButtonSetting: UIBarButtonItem = UIBarButtonItem(title: "設定", style:UIBarButtonItemStyle.Plain, target: delegate, action: "clickButton:")
        let flexibleItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        myUIBarButtonSetting.tag = 2
        myToolbar.items = [myUIBarButtonNotice, flexibleItem, myUIBarButtonSetting]
        
        //addsubview
        self.addSubview(myToolbar)
        self.addSubview(views)
        views.addSubview(leader)

        //autolayout
        views.autoPinEdgeToSuperviewEdge(.Top, withInset : 34 )
        views.autoPinEdge(.Bottom, toEdge: .Top, ofView: myScrollView, withOffset: 0)
        leader.autoSetDimensionsToSize(CGSizeMake(100, 100))
        leader.autoCenterInSuperview()
        leader.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: myBoundSize.width / 2 - 50  )
        myScrollView.autoSetDimensionsToSize(CGSizeMake(myBoundSize.width, myBoundSize.height / 2))
        myScrollView.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 35)
        
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}