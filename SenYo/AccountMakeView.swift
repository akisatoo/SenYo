//
//  AccountMake.swift
//  SenYo
//
//  Created by 松江飛雄馬 on 2016/09/18.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

protocol AccountMakeViewDelegate : NSObjectProtocol {
    func buttonTouched(sendre : UIButton )
    func debugButton(sender : UIButton )
}

class AccountMakeView : UIView, UITextFieldDelegate {
    var delegate  : AccountMakeViewDelegate?
    let aspect = Aspect()
    let passTextField = UITextField()
    let confirmationTextField = UITextField()
    let accountIDTextField = UITextField()
    let nameTextField = UITextField()
    let accountImage = UIImageView()
    
    required init(){
        super.init(frame: CGRectMake(0, 0, 0, 0))
        self.backgroundColor = .whiteColor()
        let scrollView = UIScrollView()
        let makeButton = UIButton()
        let debugButton = UIButton()    // Debug
        
        scrollView.frame = CGRectMake(0, 0, myBoundSize.width, myBoundSize.height)
        accountImage.image = UIImage( named: "logo" )
        //accountImage.layer.cornerRadius = 50
        accountImage.layer.borderWidth = 2.0
        //accountImage.layer.masksToBounds = true
        accountImage.layer.borderColor = UIColor.clearColor().CGColor
        nameTextField.borderStyle = UITextBorderStyle.RoundedRect
        nameTextField.layer.borderWidth = 2.0
        nameTextField.layer.borderColor = UIColor(red: 0.1, green: 1, blue: 1, alpha: 1).CGColor
        nameTextField.placeholder = "  ユーザID"
        nameTextField.autocapitalizationType = UITextAutocapitalizationType.None
        nameTextField.layer.cornerRadius = 24
        accountIDTextField.borderStyle = UITextBorderStyle.RoundedRect
        accountIDTextField.layer.borderWidth = 2.0
        accountIDTextField.layer.borderColor = UIColor(red: 0.1, green: 1, blue: 1, alpha: 1).CGColor
        accountIDTextField.autocapitalizationType = UITextAutocapitalizationType.None
        accountIDTextField.placeholder = "  アカウントID"
        accountIDTextField.layer.cornerRadius = 24
        passTextField.borderStyle = UITextBorderStyle.RoundedRect
        passTextField.layer.borderWidth = 2.0
        passTextField.layer.borderColor = UIColor(red: 0.1, green: 1, blue: 1, alpha: 1).CGColor
        passTextField.autocapitalizationType = UITextAutocapitalizationType.None
        passTextField.placeholder = "  パスワード"
        passTextField.layer.cornerRadius = 24
        
        confirmationTextField.borderStyle = UITextBorderStyle.RoundedRect
        confirmationTextField.layer.borderWidth = 2.0
        confirmationTextField.layer.borderColor = UIColor(red: 0.1, green: 1, blue: 1, alpha: 1).CGColor
        confirmationTextField.autocapitalizationType = UITextAutocapitalizationType.None
        confirmationTextField.placeholder = "  パスワード確認"
        confirmationTextField.layer.cornerRadius = 24
        makeButton.addTarget( delegate, action: "buttonTouched:", forControlEvents: .TouchUpInside)
        makeButton.setTitle("サインイン", forState: .Normal)
        makeButton.layer.borderColor = UIColor.clearColor().CGColor
        makeButton.backgroundColor = UIColor(red: 0.1, green: 1, blue: 1, alpha: 1)
        makeButton.layer.borderWidth = 2.0
        makeButton.layer.cornerRadius = 24
        debugButton.addTarget(delegate, action: "debugButton:", forControlEvents: .TouchUpInside)
        debugButton.setTitle("Debug", forState: .Normal )
        debugButton.backgroundColor = .redColor()
        
        // addsubView
        self.addSubview(scrollView)
        scrollView.addSubview(accountImage)
        scrollView.addSubview(nameTextField)
        scrollView.addSubview(accountIDTextField)
        scrollView.addSubview(passTextField)
        scrollView.addSubview(confirmationTextField)
        scrollView.addSubview(makeButton)
        scrollView.addSubview(debugButton)
        
        // Scrollの幅
        scrollView.contentSize = CGSizeMake(myBoundSize.width, myBoundSize.height * 2 )
        
        // autoLayout
        accountImage.autoSetDimensionsToSize( CGSizeMake( 220 * aspect.xAspect(), 60  * aspect.yAspect() ))
        accountImage.autoPinEdgeToSuperviewEdge( .Left, withInset : myBoundSize.width / 2 - 110  )
        accountImage.autoPinEdgeToSuperviewEdge(.Top, withInset : 100 )
        nameTextField.autoSetDimensionsToSize(CGSizeMake( 300, 46 ))
        nameTextField.autoPinEdge(.Top, toEdge: .Bottom, ofView: accountImage, withOffset: 100 )
        nameTextField.autoPinEdgeToSuperviewEdge(.Left, withInset : myBoundSize.width / 2 - 150 )
        accountIDTextField.autoSetDimensionsToSize(CGSizeMake( 300, 46 ))
        accountIDTextField.autoPinEdge(.Top, toEdge: .Bottom, ofView: nameTextField, withOffset: 18 )
        accountIDTextField.autoPinEdgeToSuperviewEdge(.Left, withInset : myBoundSize.width / 2 - 150)
        
        passTextField.autoSetDimensionsToSize(CGSizeMake( 300, 46 ))
        passTextField.autoPinEdge(.Top, toEdge: .Bottom, ofView: accountIDTextField, withOffset: 18 )
        passTextField.autoPinEdgeToSuperviewEdge(.Left, withInset : myBoundSize.width / 2 - 150 )
        confirmationTextField.autoSetDimensionsToSize(CGSizeMake( 300, 46 ))
        confirmationTextField.autoPinEdge(.Top, toEdge: .Bottom, ofView: passTextField, withOffset: 18 )
        confirmationTextField.autoPinEdgeToSuperviewEdge(.Left, withInset : myBoundSize.width / 2 - 150 )
        makeButton.autoSetDimensionsToSize(CGSizeMake( 200, 46 ))
        makeButton.autoPinEdgeToSuperviewEdge(.Left, withInset : myBoundSize.width / 2 - 100 )
        makeButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: confirmationTextField, withOffset: 18)
        // DEBUG
        debugButton.autoSetDimensionsToSize(CGSizeMake(100, 50))
        debugButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: makeButton, withOffset: 30)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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