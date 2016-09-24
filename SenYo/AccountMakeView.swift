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
}

class AccountMakeView : UIView, UITextFieldDelegate {
    var delegate  : AccountMakeViewDelegate?
    
    let passTextField = UITextField()
    let accountTextField = UITextField()
    let nameTextField = UITextField()
    let accountImage = UIImageView()
    
    required init(){
        super.init(frame: CGRectMake(0, 0, 0, 0))
        self.backgroundColor = UIColor.grayColor()
        let scrollView = UIScrollView()
        
        let makeButton = UIButton()
        
        scrollView.frame = CGRectMake(0, 0, myBoundSize.width, myBoundSize.height)
        accountImage.image = UIImage( named: "hironaka" )
        accountImage.layer.cornerRadius = 50
        accountImage.layer.borderWidth = 2.0
        accountImage.layer.masksToBounds = true
        accountImage.layer.borderColor = UIColor.blueColor().CGColor
        nameTextField.borderStyle = UITextBorderStyle.RoundedRect
        nameTextField.layer.borderWidth = 2.0
        nameTextField.layer.borderColor = UIColor.blueColor().CGColor
        nameTextField.placeholder = "名前"
        nameTextField.layer.cornerRadius = 5
        accountTextField.borderStyle = UITextBorderStyle.RoundedRect
        accountTextField.layer.borderWidth = 2.0
        accountTextField.layer.borderColor = UIColor.blueColor().CGColor
        accountTextField.placeholder = "アカウントID"
        accountTextField.layer.cornerRadius = 5
        passTextField.borderStyle = UITextBorderStyle.RoundedRect
        passTextField.layer.borderWidth = 2.0
        passTextField.layer.borderColor = UIColor.blueColor().CGColor
        passTextField.placeholder = "パスワード"
        passTextField.layer.cornerRadius = 5
        
        makeButton.addTarget( delegate, action: "buttonTouched:", forControlEvents: .TouchUpInside)
        makeButton.setTitle("Continue", forState: .Normal)
        //makeButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        makeButton.layer.borderColor = UIColor.blueColor().CGColor
        makeButton.backgroundColor = UIColor.blueColor()
        makeButton.layer.borderWidth = 2.0
        makeButton.layer.cornerRadius = 5
       
        // addsubView
        self.addSubview(scrollView)
        scrollView.addSubview(accountImage)
        scrollView.addSubview(nameTextField)
        scrollView.addSubview(accountTextField)
        scrollView.addSubview(passTextField)
        scrollView.addSubview(makeButton)
        
        // Scrollの幅
        scrollView.contentSize = CGSizeMake(myBoundSize.width, myBoundSize.height * 2 )
        
        //autoLayout
        accountImage.autoSetDimensionsToSize( CGSizeMake( 100, 100 ))
        accountImage.autoPinEdgeToSuperviewEdge(.Left, withInset : 20 )
        accountImage.autoPinEdgeToSuperviewEdge(.Top, withInset : 30 )
        nameTextField.autoSetDimensionsToSize(CGSizeMake( 300, 50))
        nameTextField.autoPinEdge(.Top, toEdge: .Bottom, ofView: accountImage, withOffset: 20 )
        nameTextField.autoPinEdgeToSuperviewEdge(.Left, withInset : 20 )
        
        accountTextField.autoSetDimensionsToSize(CGSizeMake( 300, 50))
        accountTextField.autoPinEdge(.Top, toEdge: .Bottom, ofView: nameTextField, withOffset: 20 )
        accountTextField.autoPinEdgeToSuperviewEdge(.Left, withInset : 20 )
        
        passTextField.autoSetDimensionsToSize(CGSizeMake( 300, 50))
        passTextField.autoPinEdge(.Top, toEdge: .Bottom, ofView: accountTextField, withOffset: 20 )
        passTextField.autoPinEdgeToSuperviewEdge(.Left, withInset : 20 )
        makeButton.autoSetDimensionsToSize(CGSizeMake( 100, 50 ))
        makeButton.autoPinEdgeToSuperviewEdge(.Left, withInset : 20 )
        makeButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: passTextField, withOffset: 30)
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