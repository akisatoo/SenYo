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

class HomeView: UIView, UITextFieldDelegate {
    let appdelegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var delegate: HomeViewDelegate?
    private var userArray : [[UIImageView]] = [[UIImageView]]()
    private var message = UITextField()
    var aspect = Aspect()
    
    required init() {
        super.init(frame: CGRectMake(0, 0, 0, 0));
        self.backgroundColor = UIColor.blueColor()
        let myImage = UIImage(named: "hironaka")
        let balloon = UIImageView(image: UIImage(named: "balloon"))
        let leader = UIImageView()
        let views = UIView(frame: CGRectMake( 0, 0, (myBoundSize.width) * aspect.xAspect(), (myBoundSize.height / 2) * aspect.yAspect() ))
        let myScrollView = UIScrollView()
        myScrollView.backgroundColor = .whiteColor()
        let leaderSize = 100 * aspect.yAspect()
        
        balloon.autoresizesSubviews = true
        message.delegate = self
        message.placeholder = "メッセージ"
        leader.layer.cornerRadius = leaderSize / 2
        leader.backgroundColor = UIColor.whiteColor()
        leader.layer.borderColor = UIColor.blueColor().CGColor
        leader.layer.borderWidth = 2.0
        leader.layer.masksToBounds = true
        leader.userInteractionEnabled = true
        leader.tag = 1
       // leader.image = myImage
        self.addSubview(myScrollView)
        
        // User 配置
        for i in 0...6 {
            userArray.append([])
            for j in 0...2 {
                var xWidth = 30
                let userSize = 80 * aspect.yAspect()
                let myImageView = UIImageView()
                let userName = UILabel(frame: CGRectMake( 0, 0, 100 * aspect.xAspect(), 50  * aspect.yAspect() ))
                userName.text = "name"
              //  myImageView.image = myImage
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
                userName.autoPinEdgeToSuperviewEdge( .Left, withInset: CGFloat(xWidth + 17 + 150 * i) * aspect.xAspect() )
                
                userArray[i][j].popIn(0.6, duration: 0.6, delay: 0.5, completion: nil)
            }
        }
        // Scrollできる幅の設定
        myScrollView.contentSize = CGSizeMake( ( CGFloat(userArray[0].count ) * (CGFloat(userArray.count) * 52) ) * aspect.xAspect(), myScrollView.frame.size.height * aspect.yAspect() )
        
        //addsubview
        self.addSubview(views)
        views.addSubview(leader)
        views.addSubview(balloon)
        views.addSubview(message)
        
        //autolayout
        views.autoPinEdgeToSuperviewEdge(.Top, withInset : 0 )
        leader.autoSetDimensionsToSize( CGSizeMake( leaderSize, leaderSize ))
        leader.autoCenterInSuperview()
        leader.autoPinEdgeToSuperviewEdge(.Top, withInset: 100 )
        leader.autoPinEdgeToSuperviewEdge(.Left, withInset:  ( myBoundSize.width / 2 - leaderSize / 2 ) )
        balloon.autoSetDimensionsToSize(CGSizeMake(250, 70))
        balloon.autoPinEdgeToSuperviewEdge(.Left, withInset: myBoundSize.width / 2 - 125)
        balloon.autoPinEdge(.Top, toEdge: .Bottom, ofView: leader, withOffset: 30 )
        message.autoSetDimensionsToSize(CGSizeMake(246, 50))
        message.autoPinEdgeToSuperviewEdge(.Left, withInset: myBoundSize.width / 2 - 123)
        message.autoPinEdge(.Top, toEdge: .Top, ofView: balloon, withOffset: 18 )
        myScrollView.autoSetDimensionsToSize( CGSizeMake(myBoundSize.width, myBoundSize.height / 2 ))
        myScrollView.autoPinEdge(.Top, toEdge: .Bottom, ofView: views, withOffset: 0)
        
        
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    /*
    UITextFieldが編集された直後に呼ばれるデリゲートメソッド.
    */
    func textFieldDidBeginEditing(textField: UITextField){
        print("textFieldDidBeginEditing:" + textField.text!)
    }
    
    /*
    UITextFieldが編集終了する直前に呼ばれるデリゲートメソッド.
    */
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        print("textFieldShouldEndEditing:" + textField.text!)
        
        return true
    }
    
    /*
    改行ボタンが押された際に呼ばれるデリゲートメソッド.
    */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }

}
