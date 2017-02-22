//
//  MessageView.swift
//  SenYo
//
//  Created by 松江飛雄馬 on 2017/01/10.
//  Copyright © 2017年 takahashi akisato. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

protocol MessageViewDelegate : NSObjectProtocol {
}

class MessageView : UIView, UITextFieldDelegate{
    var delegate : MessageViewDelegate?
    let textCount : Int = 4
    var tf :[UITextField] = []
    let label = UILabel()
    
    required init () {
        super.init(frame: CGRectMake( 0, 0, 0, 0 ))
       // self.backgroundColor = UIColor.redColor()
        tf = makeUITextField( textCount )
        label.text = "グループメッセージを編集"
        label.font = UIFont.boldSystemFontOfSize(16)
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Center
        //add subview
        self.addSubview(label)
    }
    
    func makeUITextField( DataNum: Int ) -> [UITextField] {
        var textFields:[UITextField] = []
       // let icon = [UIImageView] = []
        for var i = 0; i < DataNum; i++ {
            let textField : UITextField = UITextField()
            let img = UIImage( named: "sen"+String(i + 1))
            let imgViews = UIImageView(image: img)
            textField.borderStyle = UITextBorderStyle.RoundedRect
            textField.keyboardType = UIKeyboardType.Default
            textField.returnKeyType = UIReturnKeyType.Done
            textField.delegate = self
            textField.placeholder = "  メッセージ" + String(i + 1) + "を設定する"
            textField.layer.cornerRadius = 22
            textField.font = UIFont.boldSystemFontOfSize(14)
            textField.addSubview(imgViews)
            textFields.append(textField)
            self.addSubview(textField)
            imgViews.autoSetDimensionsToSize(CGSizeMake(30, 30))
            imgViews.autoPinEdgeToSuperviewEdge(.Right, withInset: 12 )
            imgViews.autoPinEdgeToSuperviewEdge(.Top, withInset: 6 )
            textField.autoSetDimensionsToSize(CGSizeMake(300, 44))
            textField.autoPinEdgeToSuperviewEdge(.Left, withInset: myBoundSize.width / 2 - 160 )
            
        }
        return textFields
    }
    
    func autoLayout(){
        self.autoSetDimensionsToSize(CGSizeMake(350, 400))
        self.autoPinEdgeToSuperviewEdge(.Left, withInset: myBoundSize.width / 2 - 175 )
        self.autoPinEdgeToSuperviewEdge(.Top, withInset: myBoundSize.height / 4 )
        label.autoSetDimensionsToSize(CGSizeMake(300, 50))
        label.autoPinEdgeToSuperviewEdge(.Top, withInset: 10 )
        label.autoPinEdgeToSuperviewEdge(.Left, withInset: myBoundSize.width / 2 - 160)
        tf[0].autoPinEdge(.Top, toEdge: .Bottom, ofView: label, withOffset: 5)
        tf[1].autoPinEdge(.Top, toEdge: .Bottom, ofView: tf[0], withOffset: 10)
        tf[2].autoPinEdge(.Top, toEdge: .Bottom, ofView: tf[1], withOffset: 10)
        tf[3].autoPinEdge(.Top, toEdge: .Bottom, ofView: tf[2], withOffset: 10)
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
