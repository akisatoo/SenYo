//
//  LoginView.swift
//  SenYo
//
//  Created by takahashi akisato on 2016/08/27.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import UIKit
import PureLayout

protocol LoginViewDelegate: NSObjectProtocol {
    func buttonTouched(sender:UIButton)
}

class LoginView: UIView, UITextFieldDelegate {
    var delegate: LoginViewDelegate?
    let aspect = Aspect()
    var userTextFiled = UITextField()
    var passTextFiled = UITextField()
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //
    required init() {
        super.init(frame: CGRectMake(0, 0, 0, 0));
        self.backgroundColor = UIColor( white: 0.3, alpha: 1 )
        let myButton = UIButton()
        let newAcountButton = UIButton()
        let logoImage = UIImageView()
        let userLabel = UILabel()
        let passLabel = UILabel()
        
        logoImage.image = UIImage(named: "hironaka")
        myButton.backgroundColor = UIColor.blueColor()
        myButton.layer.masksToBounds = true
        myButton.setTitle("Sign in", forState: UIControlState.Normal)
        myButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
        myButton.layer.cornerRadius = 5.0
        myButton.titleLabel?.font = UIFont.systemFontOfSize(18)
        myButton.tag = 1
        myButton.addTarget( delegate, action: "buttonTouched:", forControlEvents: .TouchUpInside)
        
        userTextFiled.delegate = self
        userTextFiled.borderStyle = UITextBorderStyle.RoundedRect
        userTextFiled.textAlignment = NSTextAlignment.Center
        userTextFiled.layer.borderColor = UIColor(white: 0.6, alpha: 1).CGColor
        userTextFiled.layer.borderWidth = 2.0
        
        passTextFiled.delegate = self
        passTextFiled.textAlignment = NSTextAlignment.Center
        passTextFiled.borderStyle = UITextBorderStyle.RoundedRect
        passTextFiled.secureTextEntry = true
        passTextFiled.layer.borderColor = UIColor(white: 0.6, alpha: 1).CGColor
        passTextFiled.layer.borderWidth = 2.0
        userLabel.text = "USER : "
        userLabel.textColor = UIColor.whiteColor()
        passLabel.text = "PASS : "
        passLabel.textColor = UIColor.whiteColor()
        newAcountButton.setTitle("アカウントを作成する", forState: .Normal)
        newAcountButton.setTitleColor(UIColor.greenColor(), forState: .Normal)
        newAcountButton.tag = 2
        newAcountButton.addTarget( delegate, action: "buttonTouched:", forControlEvents: .TouchUpInside)
        //
        self.addSubview(myButton)
        self.addSubview(userTextFiled)
        self.addSubview(passTextFiled)
        self.addSubview(userLabel)
        self.addSubview(passLabel)
        self.addSubview(newAcountButton)
        self.addSubview(logoImage)
        
        // AutoLayout
        myButton.autoSetDimensionsToSize( CGSizeMake( myBoundSize.width - 60, 50 ) )
        myButton.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 30 )
        myButton.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: passTextFiled, withOffset: 20)
        
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
        newAcountButton.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: myButton, withOffset: 50)
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