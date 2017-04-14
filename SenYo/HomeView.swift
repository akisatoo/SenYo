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
import SwiftyJSON
import Alamofire

protocol HomeViewDelegate: NSObjectProtocol {
}

class HomeView: UIView, UITextFieldDelegate {
    private let appdelegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    internal var delegate: HomeViewDelegate?
    private var aspect = Aspect()
    private let myImage = UIImage(named: "hironaka")
    private var userArray : [[UIImageView]]  = [[UIImageView]]()
    private var userImg : [UIImageView] = []
    private let myScrollView = UIScrollView()
    private var leader = UIImageView()
    private var views = UIView()
    private var message = UITextField()
    private var userData: JSON?
    
    
    required init() {
        super.init(frame: CGRectMake(0, 0, 0, 0));
        self.backgroundColor = UIColor.blueColor()
        
        let balloon = UIImageView(image: UIImage(named: "balloon"))
        
        
        views = UIView(frame: CGRectMake( 0, 0, (myBoundSize.width) * aspect.xAspect(), (myBoundSize.height / 2) * aspect.yAspect() ))
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
        leader.popIn()
        myScrollView.frame = CGRectMake(0, myBoundSize.height / 2, myBoundSize.width, myBoundSize.height / 2 +  35 )
        self.addSubview(myScrollView)
        
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
    }
    
    // set user
    func setMember( groupData : JSON ){
        let scrollSize : CGFloat!
        userImg.removeAll()
        userArray.removeAll()
        removeAllSubviews(self.myScrollView)  // scrollViewからメンバーを削除
        // data storage
        for i in 0..<groupData["members"].count{
            //let image = UIImage(groupData["members"][i]["image"]) // image set
            let img = UIImageView(image: UIImage(named: "hironaka.jpg"))
            img.layer.borderColor = UIColor.redColor().CGColor
            img.layer.borderWidth = 2.0
            img.layer.cornerRadius = 40
            img.layer.masksToBounds = true
            img.autoresizesSubviews = true
            userImg.append(img)
        }
        
        if userImg.count == 1 {
            userArray.append([])
            userArray[0].append(userImg[0])
            myScrollView.addSubview( userArray[0][0] )
            userArray[0][0].autoSetDimensionsToSize(CGSizeMake(80, 80))
            userArray[0][0].autoPinEdgeToSuperviewEdge(.Top, withInset: 100 )
            userArray[0][0].autoPinEdgeToSuperviewEdge(.Left, withInset: myBoundSize.width / 2 - 50 )
            userArray[0][0].popIn()
        }else if userImg.count == 2 {
            for i in 0..<userImg.count {
                userArray.append([])
                userArray[i].append(userImg[i])
                myScrollView.addSubview( userArray[i][0] )
                userArray[i][0].autoSetDimensionsToSize(CGSizeMake(80, 80))
                userArray[i][0].autoPinEdgeToSuperviewEdge(.Top, withInset: 100 )
                userArray[i][0].autoPinEdgeToSuperviewEdge(.Left, withInset: CGFloat( 100 ) + CGFloat(i * 100) )
                userArray[i][0].popIn()
            }
        }else if userImg.count == 3 {
            for i in 0..<userImg.count{
                userArray.append([])
                if i == 0 {
                    userArray[i].append(userImg[i])
                    myScrollView.addSubview( userArray[i][0] )
                    userArray[i][0].autoPinEdgeToSuperviewEdge(.Top, withInset: 20 )
                    userArray[i][0].autoPinEdgeToSuperviewEdge(.Left, withInset: myBoundSize.width / 2 - 40  )
                }else {
                    let count : CGFloat = (i % 2 == 0) ? 1 : -1
                    userArray[i].append(userImg[i])
                    myScrollView.addSubview( userArray[i][0] )
                    userArray[i][0].autoPinEdge(.Top, toEdge: .Bottom, ofView: userArray[0][0], withOffset: 50 )
                    userArray[i][0].autoPinEdge(.Left, toEdge: .Left, ofView: userArray[0][0], withOffset: -60 * count )
                }
                userArray[i][0].autoSetDimensionsToSize(CGSizeMake(80, 80))
                userArray[i][0].popIn()
            }
        }else if userImg.count == 4{
            var count = 0
            for i in 0..<2{
                userArray.append([])
                for j in 0..<2{
                    let width : CGFloat = ( (j+1) % 2 == 0 ) ? 60 : -60
                    userArray[i].append(userImg[count])
                    myScrollView.addSubview( userArray[i][j] )
                    userArray[i][j].autoSetDimensionsToSize(CGSizeMake(80, 80))
                    userArray[i][j].autoPinEdgeToSuperviewEdge(.Top, withInset: 30 + CGFloat( i * 100) )
                    userArray[i][j].autoPinEdgeToSuperviewEdge(.Left, withInset: ((myBoundSize.width / 2 - 40) + width ))
                    userArray[i][j].popIn()
                    count += 1
                }
            }
        }else if userImg.count == 5{
            var count = 0
            for i in 0..<3{
                for j in 0..<3{
                    if ( i == 1 && ( j == 0 || j == 2) ) || ( j == 1 && (i == 0 || i == 2) ) {
                        let img = UIImageView(image: UIImage(named: "hironaka.jpg"))
                        userArray[i].append(img)
                    }else{
                        userArray[i].append(userImg[count])
                        myScrollView.addSubview( userArray[i][j] )
                        userArray[i][j].autoSetDimensionsToSize(CGSizeMake(80, 80))
                        userArray[i][j].autoPinEdgeToSuperviewEdge(.Left, withInset: 50 + CGFloat( j * 100 ))
                        userArray[i][j].autoPinEdgeToSuperviewEdge(.Top, withInset: 30 + CGFloat( i * 80 ) )
                        userArray[i][j].popIn()
                        count += 1
                    }
                }
            }
            
        }else if userImg.count >= 6 {
            var count = 0
            var width : CGFloat!
            let userCount = userImg.count / 4
            let user = userImg.count % 4
            for i in 0..<userCount{
                userArray.append([])
                for j in 0..<4{
                    width = ((j + 1) % 2 == 0) ? 100 : 30
                    userArray[i].append(userImg[count])
                    myScrollView.addSubview( userArray[i][j] )
                    userArray[i][j].autoSetDimensionsToSize(CGSizeMake(80, 80))
                    userArray[i][j].autoPinEdgeToSuperviewEdge( .Left, withInset: ( width + CGFloat( 150 * i )) * aspect.xAspect())
                    userArray[i][j].autoPinEdgeToSuperviewEdge( .Top, withInset:  CGFloat(  -45 + 70 * j  ) * aspect.yAspect() )
                    userArray[i][j].popIn()
                    count += 1
                    
                }
            }
            
            var addUser = 0
            if  user != 0 {
                for i in 0..<user{
                    userArray.append([])
                    userArray[userCount].append(userImg[count])
                    myScrollView.addSubview( userArray[userCount][i] )
                    userArray[userCount][i].autoSetDimensionsToSize(CGSizeMake(80, 80))
                    userArray[userCount][i].autoPinEdge(.Left, toEdge: .Left, ofView: userArray[userCount - 1][i], withOffset: 150 )
                    userArray[userCount][i].autoPinEdge(.Top, toEdge: .Top, ofView: userArray[userCount - 1][i], withOffset: 0 )
                    userArray[userCount][i].popIn()
                    count += 1
                    addUser += 1
                }
            }
        }
        
        let ud = NSUserDefaults.standardUserDefaults()
        let groupData = String(groupData)
        ud.setObject(groupData, forKey: "groupData")
        ud.synchronize()
        // scroll width
        let addWidth = (userImg.count % 4 == 0) ? 0 : 1
        scrollSize = ((CGFloat(userImg.count / 4 ) * 160) + CGFloat( addWidth * 160 ))  * aspect.xAspect()
        if scrollSize < myBoundSize.width {
            myScrollView.scrollEnabled = false
        }else {
            myScrollView.contentSize = CGSizeMake( scrollSize, 0 )
            myScrollView.scrollEnabled = true
        }
    }
    
    //
    func setMemberData( data : JSON ){
        userData = data
    }
    
    func setMessageData( messageData : String ){
        message.placeholder = messageData
    }
    
    // view内のUIパーツの削除
    func removeAllSubviews(parentView: UIView){
        let subviews = parentView.subviews
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
    
    //UITextFieldが編集された直後に呼ばれるデリゲートメソッド.
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
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
