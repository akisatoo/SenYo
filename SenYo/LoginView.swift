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
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //
    required init() {
        super.init(frame: CGRectMake(0, 0, 0, 0));
        self.backgroundColor = UIColor.redColor()
        let myButton = UIButton()
        let userTextFiled = UITextField()
        let passTextFiled = UITextField()
        let userLabel = UILabel()
        let passLabel = UILabel()
        
        myButton.frame = CGRectMake(0,0,200,40)
        myButton.backgroundColor = UIColor.redColor()
        myButton.layer.masksToBounds = true
        myButton.setTitle("Login!!", forState: UIControlState.Normal)
        myButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
        myButton.layer.cornerRadius = 20.0
        myButton.tag = 1
        myButton.addTarget(delegate, action: "buttonTouched:", forControlEvents: .TouchUpInside)
        userTextFiled.delegate = self
        userTextFiled.borderStyle = UITextBorderStyle.RoundedRect
        userTextFiled.textAlignment = NSTextAlignment.Center
        //userTextFiled.center = CGPoint( x : us, y : self.center.y )
        passTextFiled.delegate = self
        passTextFiled.textAlignment = NSTextAlignment.Center
        passTextFiled.borderStyle = UITextBorderStyle.RoundedRect
        passTextFiled.secureTextEntry = true
        userLabel.frame = CGRectMake(0, 0, 100, 50 )
        userLabel.text = "USER : "
        passLabel.frame = CGRectMake(0, 0, 100, 50 )
        passLabel.text = "PASS : "
        
        //
        self.addSubview(myButton)
        self.addSubview(userTextFiled)
        self.addSubview(passTextFiled)
        self.addSubview(userLabel)
        self.addSubview(passLabel)
        
        // AutoLayout
        myButton.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 60)
        myButton.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: myBoundSize.width / 2)
        
        userLabel.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 50)
        userLabel.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: myBoundSize.height / 3 )
        passLabel.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: ( myBoundSize.height / 2 ) )
        passLabel.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 50)

        userTextFiled.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 150 )
        userTextFiled.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: myBoundSize.height / 3 )
        userTextFiled.autoSetDimension(.Width, toSize: 200)
        userTextFiled.autoSetDimension(.Height, toSize: 30)
        
        passTextFiled.autoSetDimension(.Width, toSize: 200)
        passTextFiled.autoSetDimension(.Height, toSize: 30)
        passTextFiled.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: passLabel, withOffset: 10)
        passTextFiled.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset:  myBoundSize.height / 2 )
        passTextFiled.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 150)
        

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}