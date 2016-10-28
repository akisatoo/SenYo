//
//  File.swift
//  SenYo
//
//  Created by 松江飛雄馬 on 2016/08/31.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

protocol ProfileViewDelegate : NSObjectProtocol {
}

class ProfileView : UIView, UITextFieldDelegate{
    var delegate : ProfileViewDelegate?
    let userImage = UIImageView()
    required init () {
        super.init(frame: CGRectMake(0,0,0,0))
        let userName = UITextField()
        
        let comment = UITextField()
        self.backgroundColor = .whiteColor()
        userName.placeholder = "your name"
        userName.delegate = self
        userName.backgroundColor = UIColor(white: 0.2, alpha: 0.5)
        userImage.layer.cornerRadius = 20
        userImage.backgroundColor = .blackColor()
        userImage.layer.masksToBounds = true
        comment.placeholder = "comment"
        comment.backgroundColor = UIColor(white: 0.2, alpha: 0.5)
        comment.delegate = self
        
        self.addSubview(userName)
        self.addSubview(userImage)
        self.addSubview(comment)
        
        // autolayout
        userImage.autoSetDimensionsToSize(CGSizeMake(100, 100))
        userImage.autoPinEdgeToSuperviewEdge(.Top, withInset: 100 )
        userImage.autoPinEdgeToSuperviewEdge(.Left, withInset: myBoundSize.width / 2 - 50)
        userName.autoSetDimensionsToSize(CGSizeMake(myBoundSize.width - 20, 50))
        userName.autoPinEdge(.Top, toEdge: .Bottom, ofView: userImage, withOffset: 10 )
        userName.autoPinEdgeToSuperviewEdge(.Left, withInset: 10 )
        comment.autoSetDimensionsToSize(CGSizeMake(myBoundSize.width - 20, 50))
        comment.autoPinEdge(.Top, toEdge: .Bottom, ofView: userName, withOffset: 10 )
        comment.autoPinEdgeToSuperviewEdge(.Left, withInset: 10 )

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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