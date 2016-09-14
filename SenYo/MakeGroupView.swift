//
//  MakeGroupView.swift
//  SenYo
//
//  Created by 松江飛雄馬 on 2016/09/03.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

protocol MakeGroupViewDelegate : NSObjectProtocol {
    func pushButton(sender : UIButton)
}

class MakeGroupView : UIView, UITextFieldDelegate {
    var delegate : MakeGroupViewDelegate?
    
    required init(){
        super.init(frame : CGRectMake(0, 0, 0, 0))
        self.backgroundColor = UIColor.brownColor()
        let groupButton = UIButton(frame: CGRectMake(0, 0, 100, 100 ))
        let myTextField = UITextField(frame: CGRectMake(0,0,200,30))
        groupButton.backgroundColor = UIColor.blackColor()
        groupButton.setTitle("Member", forState: UIControlState.Normal)
        groupButton.addTarget(delegate, action: "pushButton:", forControlEvents: .TouchUpInside)
        myTextField.text = "Hello Swift!!"
        myTextField.delegate = self
        myTextField.borderStyle = UITextBorderStyle.RoundedRect
        /*
        if userArray != [] {
            print("success!!")
            for i in 0...userArray.endIndex - 1 {
                imageView.append(UIImageView())
                imageView[i].backgroundColor = UIColor.blueColor()
                imageView[i].layer.position = CGPointMake( CGFloat(200 + i * 100), 200 )
                self.addSubview(imageView[i])
            }
        }
        */
        //
        self.addSubview(groupButton)
        self.addSubview(myTextField)
        
        //
        groupButton.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 60)
        groupButton.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: myBoundSize.width / 2 )
        myTextField.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: myBoundSize.height / 2)
        myTextField.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: myBoundSize.width / 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}