import Foundation
import UIKit
import PureLayout
import SwiftyJSON
import Alamofire

protocol ProfileViewDelegate : NSObjectProtocol {
    func buttonAction( sender: UIButton )
}

class ProfileView : UIView, UITextFieldDelegate{
    var delegate : ProfileViewDelegate?
    let userImage = UIImageView()

    required init () {
        super.init(frame: CGRectMake( 0, 0, 0, 0 ))
        let userName = UITextField()
        let groupMake = UIButton()
        let messageEdit = UIButton()
        let signoutBtn = UIButton()
        let passChangeBtn = UIButton()
        let color = UIColor(red: 0, green: 0.9, blue: 1, alpha: 1)
        let ud = NSUserDefaults.standardUserDefaults()
        self.backgroundColor = .whiteColor()
        userImage.layer.cornerRadius = 50
        userImage.layer.masksToBounds = true
        userImage.backgroundColor = UIColor.whiteColor()
        userImage.layer.borderColor = color.CGColor
        userImage.layer.borderWidth = 2.0
        userName.placeholder = "ユーザID"
        userName.text = ud.objectForKey("account_id") as? String
        userName.textAlignment = .Center
        userName.delegate = self
        let border = CALayer()
        let borderWidth = CGFloat(2.0)
        border.borderColor = UIColor.blackColor().CGColor
        border.frame = CGRect(x: 80, y: 40, width: 150, height: 1)
        border.borderWidth = borderWidth
        userName.layer.addSublayer(border)
        groupMake.setTitle("新しいグループの作成 ＋ ", forState: .Normal)
        groupMake.titleLabel?.font = UIFont.systemFontOfSize(14)
        groupMake.layer.borderWidth = 2.0
        groupMake.layer.borderColor = color.CGColor
        groupMake.backgroundColor = color
        groupMake.layer.cornerRadius = 20
        groupMake.tag = 1
        messageEdit.setTitle("メッセージ編集　✎", forState: .Normal)
        messageEdit.titleLabel?.font = UIFont.systemFontOfSize(14)
        messageEdit.layer.borderWidth = 2.0
        messageEdit.backgroundColor = color
        messageEdit.layer.borderColor = color.CGColor
        messageEdit.layer.cornerRadius = 20
        messageEdit.tag = 2
        passChangeBtn.backgroundColor = .clearColor()
        passChangeBtn.setTitle("パスワード変更", forState: .Normal)
        passChangeBtn.setTitleColor(color, forState: .Normal)
        passChangeBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        passChangeBtn.tag = 3
        signoutBtn.backgroundColor = UIColor.grayColor()
        signoutBtn.layer.cornerRadius = 20
        signoutBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        signoutBtn.tag = 4
        signoutBtn.setTitle( "ログアウト", forState: .Normal)
        // event
        groupMake.addTarget(delegate, action: Selector("buttonAction:"), forControlEvents: .TouchUpInside)
        messageEdit.addTarget(delegate, action: Selector("buttonAction:"), forControlEvents: .TouchUpInside)
        passChangeBtn.addTarget(delegate, action: Selector("buttonAction:"), forControlEvents: .TouchUpInside )
        signoutBtn.addTarget( delegate, action: Selector("buttonAction:"), forControlEvents: .TouchUpInside )
        
        //add subview
        self.addSubview(userImage)
        self.addSubview(userName)
        self.addSubview(groupMake)
        self.addSubview(messageEdit)
        self.addSubview(passChangeBtn)
        self.addSubview(signoutBtn)
        
        // autolayout
        userImage.autoSetDimensionsToSize(CGSizeMake(100, 100))
        userImage.autoPinEdgeToSuperviewEdge(.Top, withInset: 100 )
        userImage.autoPinEdgeToSuperviewEdge(.Left, withInset: myBoundSize.width / 2 - 50)
        userName.autoSetDimensionsToSize(CGSizeMake(myBoundSize.width - 70, 44))
        userName.autoPinEdge(.Top, toEdge: .Bottom, ofView: userImage, withOffset: 10 )
        userName.autoPinEdgeToSuperviewEdge(.Left, withInset: 35 )
        groupMake.autoSetDimensionsToSize(CGSizeMake(myBoundSize.width - 140, 40))
        groupMake.autoPinEdge(.Top, toEdge: .Bottom, ofView: userName, withOffset: 40 )
        groupMake.autoPinEdgeToSuperviewEdge(.Left, withInset: 70 )
        messageEdit.autoSetDimensionsToSize(CGSizeMake(myBoundSize.width - 140, 40))
        messageEdit.autoPinEdge(.Top, toEdge: .Bottom, ofView: groupMake, withOffset: 15 )
        messageEdit.autoPinEdgeToSuperviewEdge(.Left, withInset: 70 )
        passChangeBtn.autoSetDimensionsToSize(CGSizeMake(100, 44))
        passChangeBtn.autoPinEdgeToSuperviewEdge(.Left, withInset: myBoundSize.width / 2 - 50 )
        passChangeBtn.autoPinEdge(.Bottom, toEdge: .Top, ofView: signoutBtn, withOffset: -10 )
        signoutBtn.autoSetDimensionsToSize(CGSizeMake(180, 40))
        signoutBtn.autoPinEdgeToSuperviewEdge(.Left, withInset: myBoundSize.width / 2 - 90 )
        signoutBtn.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 50 )
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
