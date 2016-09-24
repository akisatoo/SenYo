//
//  LoginView.swift
//  SenYo
//
//  Created by takahashi akisato on 2016/08/27.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import UIKit
import PureLayout
import SimpleAnimation

protocol LoginViewDelegate: NSObjectProtocol {
    func buttonTouched(sender:UIButton)
    func textFieldDidChange(textField: UITextField)
}

class LoginView: UIView {
    var delegate: LoginViewDelegate?
    let aspect = Aspect()
    var userTextFiled = UITextField()
    var passTextFiled = UITextField()
    private let loginButton = UIButton()
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //
    required init() {
        super.init(frame: CGRectMake(0, 0, 0, 0));
        self.backgroundColor = UIColor( white: 0.3, alpha: 1 )
        
        let newAcountButton = UIButton()
        let logoImage = UIImageView()
        let userLabel = UILabel()
        let passLabel = UILabel()
        
        logoImage.image = UIImage(named: "hironaka")
        loginButton.backgroundColor = UIColor.whiteColor()
        loginButton.layer.masksToBounds = true
        loginButton.layer.borderColor = UIColor(red: 0.1, green: 1, blue: 1, alpha: 1).CGColor
        loginButton.layer.borderWidth = 2.0
        loginButton.setTitle("Sign in", forState: UIControlState.Normal)
        loginButton.setTitleColor(UIColor(red: 0, green: 1, blue: 1, alpha: 1), forState: UIControlState.Normal)
        loginButton.layer.cornerRadius = 5.0
        loginButton.titleLabel?.font = UIFont.systemFontOfSize(18)
        loginButton.tag = 1
        loginButton.addTarget( delegate, action: "buttonTouched:", forControlEvents: .TouchUpInside)
        
        userTextFiled.borderStyle = UITextBorderStyle.RoundedRect
        userTextFiled.textAlignment = NSTextAlignment.Center
        userTextFiled.layer.borderColor = UIColor(white: 0.6, alpha: 1).CGColor
        userTextFiled.layer.borderWidth = 2.0
        userTextFiled.layer.cornerRadius = 5.0
        userTextFiled.tag = 1
        userTextFiled.addTarget( delegate, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        
        passTextFiled.textAlignment = NSTextAlignment.Center
        passTextFiled.borderStyle = UITextBorderStyle.RoundedRect
        passTextFiled.secureTextEntry = true
        passTextFiled.layer.borderColor = UIColor(white: 0.6, alpha: 1).CGColor
        passTextFiled.layer.cornerRadius = 5.0
        passTextFiled.layer.borderWidth = 2.0
        passTextFiled.tag = 2
        passTextFiled.addTarget( delegate, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        
        userLabel.text = "USER : "
        userLabel.textColor = UIColor.whiteColor()
        passLabel.text = "PASS : "
        passLabel.textColor = UIColor.whiteColor()
        newAcountButton.setTitle("アカウントを作成する", forState: .Normal)
        newAcountButton.setTitleColor(UIColor(red: 0, green: 1, blue: 1, alpha: 1), forState: .Normal)
        newAcountButton.tag = 2
        newAcountButton.addTarget( delegate, action: "buttonTouched:", forControlEvents: .TouchUpInside)
        
        //
        self.addSubview(loginButton)
        self.addSubview(userTextFiled)
        self.addSubview(passTextFiled)
        self.addSubview(userLabel)
        self.addSubview(passLabel)
        self.addSubview(newAcountButton)
        self.addSubview(logoImage)
        
        // AutoLayout
        loginButton.autoSetDimensionsToSize( CGSizeMake( myBoundSize.width - 60, 50 ) )
        loginButton.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 30 )
        loginButton.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: passTextFiled, withOffset: 20)
        
        userLabel.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 30 )
        userLabel.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: myBoundSize.height / 3 - 20  )
        passLabel.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: ( myBoundSize.height / 2 ) - 20 )
        passLabel.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 30)

        userTextFiled.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 30 )
        userTextFiled.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: myBoundSize.height / 3 )
        userTextFiled.autoSetDimension(.Width, toSize: myBoundSize.width - 60 )
        userTextFiled.autoSetDimension(.Height, toSize: 50)
        
        passTextFiled.autoSetDimension(.Width, toSize: myBoundSize.width - 60 )
        passTextFiled.autoSetDimension(.Height, toSize: 50)
        passTextFiled.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset:  myBoundSize.height / 2 )
        passTextFiled.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 30)
        newAcountButton.autoPinEdgeToSuperviewEdge(.Right, withInset : 30 )
        newAcountButton.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: loginButton, withOffset: 50)
        logoImage.autoSetDimensionsToSize( CGSizeMake( 100, 100 ) )
        logoImage.autoPinEdgeToSuperviewEdge(.Left, withInset : myBoundSize.width / 2 - 50  )
        logoImage.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Top, ofView: userLabel, withOffset: -30)
        

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    // retrunを押すとキーボードを閉じる
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // ユーザがキーボード以外の場所をタップすると、キーボードを閉じる
        self.endEditing(true)
    }
}