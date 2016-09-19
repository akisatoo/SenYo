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

}

class AccountMakeView : UIView, UITextFieldDelegate {
    var delegate  : AccountMakeViewDelegate?
    
    required init(){
        super.init(frame: CGRectMake(0, 0, 0, 0))
        self.backgroundColor = UIColor.grayColor()
        let scrollView = UIScrollView()
        let nameTextView = UITextField()
        let addressTextField = UITextField()
        let passTextField = UITextField()
        let accountImage = UIImageView()
        let makeButton = UIButton()
        
        scrollView.frame = CGRectMake(0, 0, myBoundSize.width, myBoundSize.height)
        accountImage.image = UIImage( named: "hironaka" )
        accountImage.layer.cornerRadius = 50
        accountImage.layer.borderWidth = 2.0
        accountImage.layer.masksToBounds = true
        accountImage.layer.borderColor = UIColor.blueColor().CGColor
        nameTextView.borderStyle = UITextBorderStyle.RoundedRect
        nameTextView.layer.borderWidth = 2.0
        nameTextView.layer.borderColor = UIColor.blueColor().CGColor
        nameTextView.placeholder = "名前"
        nameTextView.layer.cornerRadius = 5
        addressTextField.borderStyle = UITextBorderStyle.RoundedRect
        addressTextField.layer.borderWidth = 2.0
        addressTextField.layer.borderColor = UIColor.blueColor().CGColor
        addressTextField.placeholder = "アドレス"
        addressTextField.layer.cornerRadius = 5
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
        scrollView.addSubview(nameTextView)
        scrollView.addSubview(addressTextField)
        scrollView.addSubview(passTextField)
        scrollView.addSubview(makeButton)
        
        // Scrollの幅
        scrollView.contentSize = CGSizeMake(myBoundSize.width, myBoundSize.height * 2 )
        
        //autoLayout
        accountImage.autoSetDimensionsToSize( CGSizeMake( 100, 100 ))
        accountImage.autoPinEdgeToSuperviewEdge(.Left, withInset : 20 )
        accountImage.autoPinEdgeToSuperviewEdge(.Top, withInset : 30 )
        nameTextView.autoSetDimensionsToSize(CGSizeMake( 300, 50))
        nameTextView.autoPinEdge(.Top, toEdge: .Bottom, ofView: accountImage, withOffset: 20 )
        nameTextView.autoPinEdgeToSuperviewEdge(.Left, withInset : 20 )
        
        addressTextField.autoSetDimensionsToSize(CGSizeMake( 300, 50))
        addressTextField.autoPinEdge(.Top, toEdge: .Bottom, ofView: nameTextView, withOffset: 20 )
        addressTextField.autoPinEdgeToSuperviewEdge(.Left, withInset : 20 )
        
        passTextField.autoSetDimensionsToSize(CGSizeMake( 300, 50))
        passTextField.autoPinEdge(.Top, toEdge: .Bottom, ofView: addressTextField, withOffset: 20 )
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