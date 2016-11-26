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
    func signIn( sender: UIButton )
}

class ProfileView : UIView, UITextFieldDelegate{
    var delegate : ProfileViewDelegate?
    let userImage = UIImageView()
    required init () {
        super.init(frame: CGRectMake( 0, 0, 0, 0 ))
        let logoImg = UIImageView(image: UIImage(named: "logo"))
        let userName = UITextField()
        let comment = UITextField()
        let signinButton = UIButton()
        let passTextField = UITextField()
        let color = UIColor(red: 0.1, green: 1, blue: 1, alpha: 1).CGColor
        self.backgroundColor = .whiteColor()
        logoImg.autoresizesSubviews = true
        userImage.layer.cornerRadius = 45
        userImage.layer.masksToBounds = true
        userImage.backgroundColor = UIColor.whiteColor()
        userImage.layer.borderColor = color
        userImage.layer.borderWidth = 2.0
        userName.placeholder = "    ユーザID"
        userName.delegate = self
        userName.layer.borderWidth = 2.0
        userName.layer.borderColor = color
        userName.layer.cornerRadius = 20
        comment.placeholder = "    メールアドレス"
        comment.layer.borderWidth = 2.0
        comment.layer.borderColor = color
        comment.layer.cornerRadius = 20
        comment.delegate = self
        passTextField.layer.borderWidth = 2.0
        passTextField.layer.borderColor = color
        passTextField.autocapitalizationType = UITextAutocapitalizationType.None
        passTextField.placeholder = "     パスワード"
        passTextField.layer.cornerRadius = 20
        passTextField.delegate = self
        
        signinButton.layer.borderColor = color
        signinButton.layer.borderWidth = 2.0
        signinButton.layer.cornerRadius = 20
        signinButton.setTitle( "SignIn", forState: UIControlState.Normal)
        // event
        signinButton.addTarget( delegate, action: "signIn:", forControlEvents: .TouchUpInside )
        
        //add subview
        self.addSubview(logoImg)
        self.addSubview(userImage)
        self.addSubview(userName)
        self.addSubview(comment)
        self.addSubview(passTextField)
        self.addSubview(signinButton)
        
        // autolayout
        logoImg.autoSetDimensionsToSize( CGSizeMake( 220, 60 ) )
        logoImg.autoPinEdgeToSuperviewEdge(.Left, withInset : myBoundSize.width / 2 - 110  )
        logoImg.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: 100)
        userImage.autoSetDimensionsToSize(CGSizeMake(90, 90))
        userImage.autoPinEdge(.Top, toEdge: .Bottom, ofView: logoImg, withOffset: 30)
        userImage.autoPinEdgeToSuperviewEdge(.Left, withInset: myBoundSize.width / 2 - 50)
        userName.autoSetDimensionsToSize(CGSizeMake(myBoundSize.width - 70, 44))
        userName.autoPinEdge(.Top, toEdge: .Bottom, ofView: userImage, withOffset: 50 )
        userName.autoPinEdgeToSuperviewEdge(.Left, withInset: 35 )
        comment.autoSetDimensionsToSize(CGSizeMake(myBoundSize.width - 70, 44))
        comment.autoPinEdge(.Top, toEdge: .Bottom, ofView: userName, withOffset: 20 )
        comment.autoPinEdgeToSuperviewEdge(.Left, withInset: 35 )
        passTextField.autoSetDimensionsToSize(CGSizeMake(myBoundSize.width - 70, 44))
        passTextField.autoPinEdge(.Top, toEdge: .Bottom, ofView: comment, withOffset: 20 )
        passTextField.autoPinEdgeToSuperviewEdge(.Left, withInset: 35 )
        signinButton.autoSetDimensionsToSize(CGSizeMake(160, 44))
        signinButton.autoPinEdgeToSuperviewEdge(.Left, withInset: myBoundSize.width / 2 - 80 )
        signinButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: passTextField, withOffset: 20 )
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
