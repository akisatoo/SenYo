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
        self.backgroundColor = UIColor.whiteColor()
        
        let newAcountButton = UIButton()
        let logoImage = UIImageView()
        let userLabel = UILabel()
        let passLabel = UILabel()
        
        logoImage.image = UIImage(named: "logo")
        loginButton.backgroundColor = UIColor.whiteColor()
        loginButton.layer.masksToBounds = true
        loginButton.layer.borderColor = UIColor(red: 0.1, green: 1, blue: 1, alpha: 1).CGColor
        loginButton.layer.borderWidth = 2.0
        loginButton.setTitle("Sign in", forState: UIControlState.Normal)
        loginButton.setTitleColor(UIColor(red: 0, green: 1, blue: 1, alpha: 1), forState: UIControlState.Normal)
        loginButton.layer.cornerRadius = 20.0
        loginButton.titleLabel?.font = UIFont.systemFontOfSize(18)
        loginButton.tag = 1
        loginButton.addTarget( delegate, action: "buttonTouched:", forControlEvents: .TouchUpInside)
        
        userTextFiled.borderStyle = UITextBorderStyle.RoundedRect
        userTextFiled.textAlignment = NSTextAlignment.Center
        userTextFiled.layer.borderColor = UIColor(red: 0.1, green: 1, blue: 1, alpha: 1).CGColor
        userTextFiled.layer.borderWidth = 2.0
        userTextFiled.layer.cornerRadius = 20.0
        userTextFiled.tag = 1
        userTextFiled.addTarget( delegate, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        
        passTextFiled.textAlignment = NSTextAlignment.Center
        passTextFiled.borderStyle = UITextBorderStyle.RoundedRect
        passTextFiled.secureTextEntry = true
        passTextFiled.layer.borderColor = UIColor(red: 0.1, green: 1, blue: 1, alpha: 1).CGColor
        passTextFiled.layer.cornerRadius = 20.0
        passTextFiled.layer.borderWidth = 2.0
        passTextFiled.tag = 2
        passTextFiled.addTarget( delegate, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        
        userLabel.text = "USER ID: "
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
       // self.addSubview(userLabel)
        //self.addSubview(passLabel)
        self.addSubview(newAcountButton)
        self.addSubview(logoImage)
        
        // AutoLayout
        logoImage.autoSetDimensionsToSize( CGSizeMake( 220, 60 ) )
        logoImage.autoPinEdgeToSuperviewEdge(.Left, withInset : myBoundSize.width / 2 - 110  )
        logoImage.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: 120)
        //userLabel.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 30 )
        //userLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: logoImage, withOffset: 100)
        userTextFiled.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 30 )
        userTextFiled.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: logoImage, withOffset: 150)
        userTextFiled.autoSetDimension(.Width, toSize: myBoundSize.width - 60 )
        userTextFiled.autoSetDimension(.Height, toSize: 50)
        
        //passLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: userTextFiled, withOffset: 10)
        //passLabel.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 30)
        
        passTextFiled.autoSetDimension(.Width, toSize: myBoundSize.width - 60 )
        passTextFiled.autoSetDimension(.Height, toSize: 50)
        passTextFiled.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: userTextFiled, withOffset: 10)
        passTextFiled.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 30)
        loginButton.autoSetDimensionsToSize( CGSizeMake( myBoundSize.width - 150, 40 ) )
        loginButton.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: myBoundSize.width / 2 - 110 )
        loginButton.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: passTextFiled, withOffset: 20)
        newAcountButton.autoPinEdgeToSuperviewEdge(.Left, withInset : myBoundSize.width / 2 - 90 )
        newAcountButton.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: loginButton, withOffset: 20)
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